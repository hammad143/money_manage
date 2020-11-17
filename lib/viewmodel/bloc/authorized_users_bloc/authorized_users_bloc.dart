import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_event.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_state.dart';

class AuthorizedUsersBloc
    extends Bloc<AuthorizedUsersEvent, AuthorizedUsersState> {
  AuthorizedUsersBloc({AuthorizedUsersInitState initialState})
      : super(AuthorizedUsersInitState());

  final firebaseService = FirebaseService();
  @override
  Stream<AuthorizedUsersState> mapEventToState(
      AuthorizedUsersEvent event) async* {
    final key = event.authorizeUserKey;
    final document = await firebaseService.findDocumentExistsByField(
        collectionName: "users",
        dataToMatch: {"appKey": key},
        key1: "appKey",
        key2: "appKey");
    final userID = Hive.box(kGoogleUserId).get("userID");
    print("This is userID $userID");
    //Condition

    if (document != null && userID != null) {
      final currentUser = await firebaseService.findDocumentExistsByField(
        collectionName: "users",
        dataToMatch: {"id": userID},
        key1: "id",
        key2: "id",
      );
      final authorizedItemCollection =
          currentUser.reference.collection("authorized_users");
      final model = GoogleUserModel.fromJson(document.data());
      final authorizedDoc =
          await firebaseService.findDocumentFromCollectionByField(
              collectionReference: authorizedItemCollection,
              keyToFind: "appKey",
              value: key);
      if (authorizedDoc == null) {
        await authorizedItemCollection.add({
          "id": model.id.toString(),
          "name": model.displayName,
          "email": model.email,
          "photoUrl": model.photoUrl,
          "auto_increment": model.autoInc,
          "appKey": model.appUserKey,
        });
      } else {
        print("Document Exists of Authorized users");
      }

      final List<GoogleUserModel> list = [];
      final snaphots = await authorizedItemCollection.get();
      final docs = snaphots.docs;
      docs.forEach((element) {
        final data = element.data();
        list.add(GoogleUserModel.fromJson(data));
      });
      //ListOfAuthorizedUsersWidget(listOfAuthorizedUsers: list);
      yield AuthorizedUsersSuccessState(data: list);
    } else
      throw AssertionError("UserID not included into database");
  }
}
