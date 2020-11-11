import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_user_event.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_user_state.dart';
import 'package:uuid/uuid.dart';

class AuthenticateUserBloc
    extends Bloc<AuthenticateUserEvent, AuthenticateUserState> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  final OauthBox = Hive.box<bool>(kGoogleAuthKey);
  final generateUniqueKeyBox = Hive.box(kgenerateKey);
  AuthenticateUserBloc() : super(UserNotLoggedInState());

  @override
  Stream<AuthenticateUserState> mapEventToState(
      AuthenticateUserEvent event) async* {
    if (event is AuthenticateUserRequestEvent) {
      print("Is called");

      if (OauthBox.get("isLoggedIn") == null) {
        final isLoggedIn = await googleSignIn.signIn();

        if (isLoggedIn != null) {
          final firebaseDB = FirebaseService();

          final user = await firebaseDB
              .doesUserExists(GoogleUserModel(id: BigInt.parse(isLoggedIn.id)));
          if (user != null) {
            print("My User $user");
            generateUniqueKeyBox.put("unique key", user.appUserKey);
          } else {
            final key = Uuid().v4();
            final googleModel = GoogleUserModel(
                id: BigInt.parse(isLoggedIn.id),
                displayName: isLoggedIn.displayName,
                photoUrl: isLoggedIn.photoUrl,
                email: isLoggedIn.email,
                appUserKey: key);

            generateUniqueKeyBox.put("unique key", key);
            final docRef =
                await firebaseDB.addUser(googleUserModel: googleModel);
            if (docRef != null) await docRef.collection("items").add({});
          }

          OauthBox.put("isLoggedIn", true);
          yield UserLoggedInState();
        }
      }
    } //if(event is Authenticate)
    else if (event is AuthenticateUserSignOuttEvent) {
      OauthBox.delete("isLoggedIn");
      final x = await googleSignIn.signOut();
      print("User Signout ${x}");
      yield UserNotLoggedInState();
    }
  } // mapEventToState

}
