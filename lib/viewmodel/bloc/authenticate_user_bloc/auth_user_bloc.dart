import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/unique_key.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_user_event.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_user_state.dart';

class AuthenticateUserBloc
    extends Bloc<AuthenticateUserEvent, AuthenticateUserState> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  final OauthBox = Hive.box<bool>(kGoogleAuthKey);
  AuthenticateUserBloc() : super(UserNotLoggedInState());

  @override
  Stream<AuthenticateUserState> mapEventToState(
      AuthenticateUserEvent event) async* {
    if (event is AuthenticateUserRequestEvent) {
      print("Is called");

      if (OauthBox.get("isLoggedIn") == null) {
        final isLoggedIn = await googleSignIn.signIn();

        if (isLoggedIn != null) {
          final googleModel = GoogleUserModel(
              id: BigInt.parse(isLoggedIn.id),
              displayName: isLoggedIn.displayName,
              photoUrl: isLoggedIn.photoUrl,
              email: isLoggedIn.email,
              appUserKey: StoreUniqueKey.instance.uniqueID);

          final isAdded =
              await FirebaseService().addUser(googleUserModel: googleModel);
          print("User Added ${isAdded}");
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
