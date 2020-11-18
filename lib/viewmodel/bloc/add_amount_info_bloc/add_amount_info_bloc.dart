import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_event.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_state.dart';

class AddAmountInfoBloc extends Bloc<AddDataEvent, AddAmountInfoState> {
  AddAmountInfoBloc()
      : super(AddAmountInfoInitialState<ListOfTilesModel>(
            box: Hive.box(storageKey)));
  @override
  Stream<AddAmountInfoState> mapEventToState(AddDataEvent event) async* {
    final box = Hive.box(kHiveDataName);
    final storageBox = Hive.box<ListOfTilesModel>(storageKey);
    final googleUserIdBox = Hive.box(kGoogleUserId);
    final userID = googleUserIdBox.get("userID");
    final firebaseDB = FirebaseService();
    if (event is AddAmountInfoEvent) {
      if (event.title.isNotEmpty && event.amount.isNotEmpty) {
        final title = event.title,
            amount = event.amount,
            option = event.valueSelectedState.selectedValue,
            date = event.dateInString;
        final document = await firebaseDB.findDocumentExistsByField(
            collectionName: "users",
            dataToMatch: {"id": userID},
            key1: "id",
            key2: "id");
        final collectionOfItems = await document.reference.collection("items")
          ..orderBy('auto_increment');
        final snapshot = await collectionOfItems.get();
        final numOfItems = snapshot.docs.length + 1;
        final itemAddedDocument = await collectionOfItems.add({
          "auto_increment": numOfItems,
          "title": title,
          "amount": amount,
          "date": date,
          "option": option,
        });
        final data = (await itemAddedDocument.get()).data();

        storageBox.add(ListOfTilesModel.fromJSON(data));
        yield AddAmountInfoDone<ListOfTilesModel>(box: storageBox);
      }
    }
  }
}
/*
* Box with the key of Storage
* that box will have a List object
*
* */
