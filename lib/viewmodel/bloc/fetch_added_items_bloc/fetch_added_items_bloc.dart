import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/viewmodel/bloc/fetch_added_items_bloc/fetch_added_items_event.dart';
import 'package:money_management/viewmodel/bloc/fetch_added_items_bloc/fetch_added_items_state.dart';

class FetchAddedAmountBloc
    extends Bloc<FetchAddedItemsEvent, FetchAddedItemsState> {
  FetchAddedAmountBloc() : super(null);

  @override
  Stream<FetchAddedItemsState> mapEventToState(
      FetchAddedItemsEvent event) async* {
    final firebaseService = FirebaseService();
    final googleUserIdBox = Hive.box(kGoogleUserId);
    final userID = googleUserIdBox.get("userID");
    final document = await firebaseService.findDocumentExistsByField(
        collectionName: "users",
        dataToMatch: {"id": userID},
        key1: "id",
        key2: "id");
    print("I'm calling on scroll as a listener");
  }
}
