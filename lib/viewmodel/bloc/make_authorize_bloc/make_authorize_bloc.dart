import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/viewmodel/bloc/make_authorize_bloc/make_authorize_event.dart';
import 'package:money_management/viewmodel/bloc/make_authorize_bloc/make_authorize_state.dart';

class MakeAuthorizeBloc extends Bloc<MakeAuthorizeEvent, MakeAuthorizeState> {
  MakeAuthorizeBloc() : super(MakeAuthorizeInitState());

  @override
  Stream<MakeAuthorizeState> mapEventToState(MakeAuthorizeEvent event) async* {
    final String authorizeKey = event.authorizedKey;
    final keyBox = Hive.box(kgenerateKey);
    final firebaseService = FirebaseService();
    print("$authorizeKey");
    final document = await firebaseService.findDocumentExistsByField(
      collectionName: "users",
      key1: "appKey",
      key2: "appKey",
      dataToMatch: {"appKey": authorizeKey},
    );
    final collectionOfItems = document.reference.collection("items");
    final snapshotOfItems = await collectionOfItems.get();
    final documentsLength = snapshotOfItems.docs.length;
    print("${documentsLength}");
    final snapshot = collectionOfItems.snapshots();
    yield MakeAuthorizeSuccessState(snapshot: snapshot);
  }
}
