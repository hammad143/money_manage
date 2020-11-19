import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    final userLogIn = await googleSignIn.signIn();
    final googleIdBox = Hive.box(kGoogleUserId);
    final isUserLoggedInBox = Hive.box<bool>(kGoogleAuthKey);
    final userDisplayNameBox = Hive.box(kUserDisplayname);
    final counterBox = Hive.box<int>(counterKey);
    final autoIncrementIDbox = Hive.box(kAutoIncrementKey);
    final firebaseDB = FirebaseService();
    final numOfUsers = await firebaseDB.getNumberOfDocs("users");

    if (event is AuthenticateUserRequestEvent) {
      if (isUserLoggedInBox.get("isLoggedIn") == null) {
        if (userLogIn != null) {
          userDisplayNameBox.put("displayName", "${userLogIn.displayName}");
          print("Adding user");

          final foundUser = await firebaseDB.findDocumentExistsByField(
              collectionName: "users",
              key1: "id",
              key2: "userID",
              dataToMatch: {"userID": userLogIn.id});
          if (foundUser != null) {
            print("My User $foundUser");
            final user = GoogleUserModel.fromJson(foundUser.data());
            generateUniqueKeyBox.put("appKey", user.appUserKey);
          } else {
            final key = Uuid().v4();
            autoIncrementIDbox.put("auto_increment", numOfUsers);
            await generateUniqueKeyBox.put("appKey", key);
            print("Number of Users $numOfUsers");
            final DocumentReference currentDocumentReference =
                await firebaseDB.addUser(collectionName: "users", data: {
              "id": userLogIn.id,
              "name": userLogIn.displayName,
              "email": userLogIn.email,
              "photoUrl": userLogIn.photoUrl,
              'auto_increment': numOfUsers,
              "appKey": key,
            });
            await currentDocumentReference.collection("items").add({});
            await currentDocumentReference
                .collection("authorized_users")
                .add({});
          }

          googleIdBox.put("userID", userLogIn.id);
          isUserLoggedInBox.put("isLoggedIn", true);
          yield UserLoggedInState();
        }
      }
    } //if(event is Authenticate)
    else if (event is AuthenticateUserSignOuttEvent) {
      isUserLoggedInBox.delete("isLoggedIn");
      final x = await googleSignIn.signOut();
      print("User Signout ${x}");
      yield UserNotLoggedInState();
    }
  } // mapEventToState

}
