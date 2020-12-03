import 'package:bloc/bloc.dart';
import 'package:money_management/model/user_adding_model/google_user_adding_model.dart';
import 'package:money_management/model/user_adding_model/user_adding_model.dart';
import 'package:money_management/services/authenticate_user_service/authenticate_user.dart';
import 'package:money_management/services/authenticate_user_service/authenticateable.dart';
import 'package:money_management/services/authenticate_user_service/google_auth_service.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/util/boxes/box.dart';
import 'package:money_management/util/boxes_facade/boxes_facade.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_user_event.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_user_state.dart';

class AuthenticateUserBloc
    extends Bloc<AuthenticateUserEvent, AuthenticateUserState> {
  final firebaseDB = FirebaseService();
  AuthenticateUserBox<bool> localAuthenticationCheckBox =
      AuthenticateUserBox<bool>();
  final BoxesFacade _boxesFacade = BoxesFacade();
  UserAddingModel _userModel;
  bool isUserLoggedIn = false;
//  GoogleSignIn googleSignIn = GoogleSignIn();
  //final OauthBox = Hive.box<bool>(kGoogleAuthKey);
  //final generateUniqueKeyBox = Hive.box(kgenerateKey);
  AuthenticateUserBloc() : super(UserNotLoggedInState());

  @override
  Stream<AuthenticateUserState> mapEventToState(event) async* {
    final isLoggedIn = localAuthenticationCheckBox
        .getBox()
        .get(AuthenticateUserBox.IS_USER_LOGGED_IN, defaultValue: false);

    //Event is AuthenticateUserRequestEvent
    if (event is AuthenticateUserRequestEvent) {
      final numOfUsers = await firebaseDB.getNumberOfDocs("users");
      AuthenticateUser authAble =
          AuthAble().checkType(event.authenticationType);
      //authAble.
      switch (authAble.runtimeType) {
        case GoogleAuthService:
          final googleAuthentication = (authAble as GoogleAuthService);
          final authenticatedUser = await googleAuthentication.authenticate();
          print("Auth User ------- ${authenticatedUser.id} -----------------");
          if (authenticatedUser != null) {
            isUserLoggedIn = true;
            _userModel = GoogleUserAddingModel.toMap(authenticatedUser);
            final user = await GoogleFirebaseService().addDoc(_userModel);
            final userQuerySnap = await user.get();
            _userModel = GoogleUserAddingModel.toJSON(userQuerySnap.data());
          }
          break;
      }

      if (isUserLoggedIn) {
        _boxesFacade
            .getUserUniqueKeyBox()
            .put(_boxesFacade.userUniqueKey, _userModel.userID);
        _boxesFacade
            .getLocalAuthenticationBox<bool>()
            .put(_boxesFacade.localAuthenticationKey, isUserLoggedIn);
        _boxesFacade
            .getUserDisplayName()
            .put(_boxesFacade.userDisplayNameKey, _userModel.name);
        _boxesFacade
            .getRandomGenerateKeyBox()
            .put(_boxesFacade.randomGenerateKey, _userModel.uniqueKey);
        //storeUserIDBox.getBox().put(StoreUserIDBox.ID, _userModel.userID);
        //localAuthenticationCheckBox .getBox() .put(AuthenticateUserBox.IS_USER_LOGGED_IN, isUserLoggedIn);
        //userDisplayNameBox .getBox() .put(UserDisplayNameBox.DISPLAY_NAME, _userModel.name);
        //generateRandomKeyBox .getBox() .put(GenerateRandomKeyBox.APP_KEY, _userModel.uniqueKey);
        print("####### User Logged In #########");
        yield UserLoggedInState();
      } else {
        print("####### User is not logged In #########");
      }
      //final googleIdBox = Hive.box(kGoogleUserId);
      //final isUserLoggedInBox = Hive.box<bool>(kGoogleAuthKey);
      //final userDisplayNameBox = Hive.box(kUserDisplayname);
      //final counterBox = Hive.box<int>(counterKey);
      //final autoIncrementIDbox = Hive.box(kAutoIncrementKey);

      /*  if (isUserLoggedIn) {
        if (authenticatedUser) {
          userDisplayNameBox.getBox().put(
              UserDisplayNameBox.DISPLAY_NAME, authenticatedUser.displayName);
          print("Adding user");

          final foundUser = await firebaseDB.findDocumentExistsByField(
              collectionName: "users",
              key1: "id",
              key2: "userID",
              dataToMatch: {"userID": authenticatedUser.id});
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
            generateRandomKeyBox
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
              .getBox()
              .put(AuthenticateUserBox.IS_USER_LOGGED_IN, true);
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
    }*/
    } // mapEventToState
  }
}
/*
* in SyncView we will pass a subtype of AuthenticateUser in BLOC
* Event will  authentication of type AuthenticateUser
* AuthenticateUser auth
* if(authType equalTo AuthenticationType.google)
*   event.authentication as GoogleAuthService assignTo auth;
*   auth.authenticate
*
* */
