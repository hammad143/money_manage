import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';
import 'package:money_management/services/authenticate_user_service/authenticate_user_service.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/util/boxes/box.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_user_event.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_user_state.dart';
import 'package:uuid/uuid.dart';

class AuthenticateUserBloc
    extends Bloc<AuthenticateUserEvent, AuthenticateUserState> {
  final firebaseDB = FirebaseService();
  AuthenticateUserSerivce userAuthenticate;
  AuthenticateUserBox<bool> localAuthenticationCheckBox =
      AuthenticateUserBox<bool>();
  GenerateRandomKeyBox generateRandomKeyBox = GenerateRandomKeyBox();
  UserDisplayNameBox userDisplayNameBox = UserDisplayNameBox();
  AutoIncrementIDBox autoIncIDbox = AutoIncrementIDBox();
  StoreGoogleIDBox storeGoogleIDBox = StoreGoogleIDBox();
//  GoogleSignIn googleSignIn = GoogleSignIn();
  //final OauthBox = Hive.box<bool>(kGoogleAuthKey);
  //final generateUniqueKeyBox = Hive.box(kgenerateKey);
  AuthenticateUserBloc() : super(UserNotLoggedInState());

  @override
  Stream<AuthenticateUserState> mapEventToState(
      AuthenticateUserEvent event) async* {
    final isLoggedIn = localAuthenticationCheckBox
        .getBox()
        .get(AuthenticateUserBox.IS_USER_LOGGED_IN, defaultValue: false);
    if (event is AuthenticateUserRequestEvent) {
      final numOfUsers = await firebaseDB.getNumberOfDocs("users");
      userAuthenticate = AuthenticateUserSerivce(event.authentication);
      final authenticatedUser =
          (await userAuthenticate.authenticate()) ?? false;
      print("My Authentication value: $authenticatedUser");

      //final userLogIn = await googleSignIn.signIn();
      //final googleIdBox = Hive.box(kGoogleUserId);
      //final isUserLoggedInBox = Hive.box<bool>(kGoogleAuthKey);
      //final userDisplayNameBox = Hive.box(kUserDisplayname);
      //final counterBox = Hive.box<int>(counterKey);
      //final autoIncrementIDbox = Hive.box(kAutoIncrementKey);

      if (isLoggedIn) {
        if (authenticatedUser) {
          userDisplayNameBox
              .getBox()
              .put(UserDisplayNameBox.DISPLAY_NAME, authenticatedUser);
          print("Adding user");

          final foundUser = await firebaseDB.findDocumentExistsByField(
              collectionName: "users",
              key1: "id",
              key2: "userID",
              dataToMatch: {"userID": authenticatedUser});
          if (foundUser != null) {
            final userIntoJSON = GoogleUserModel.fromJson(foundUser.data());
            generateRandomKeyBox
                .getBox()
                .put(GenerateRandomKeyBox.APP_KEY, userIntoJSON.appUserKey);
          } else {
            final key = Uuid().v4();
            autoIncIDbox
                .getBox()
                .put(AutoIncrementIDBox.AUTO_INCREMENT, numOfUsers + 1);
            await generateRandomKeyBox
                .getBox()
                .put(GenerateRandomKeyBox.APP_KEY, key);
            print("Number of Users $numOfUsers");
            final DocumentReference currentDocumentReference =
                await firebaseDB.addUser(collectionName: "users", data: {
              "id": authenticatedUser.id,
              "name": authenticatedUser.displayName,
              "email": authenticatedUser.email,
              "photoUrl": authenticatedUser.photoUrl,
              'auto_increment': numOfUsers,
              "appKey": key,
            });
            await currentDocumentReference.collection("items").add({});
            await currentDocumentReference
                .collection("authorized_users")
                .add({});
          }

          storeGoogleIDBox
              .getBox()
              .put(StoreGoogleIDBox.ID, authenticatedUser.id);
          localAuthenticationCheckBox
            ..getBox().put(AuthenticateUserBox.IS_USER_LOGGED_IN, true);
          yield UserLoggedInState();
        }
      }
    } //if(event is Authenticate)
    else if (event is AuthenticateUserSignOuttEvent) {
      localAuthenticationCheckBox
          .getBox()
          .delete(AuthenticateUserBox.IS_USER_LOGGED_IN);
      print("User Signout");
      yield UserNotLoggedInState();
    }
  } // mapEventToState

}
