import 'package:bloc/bloc.dart';
import 'package:money_management/model/tiles_item_model/item_model.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/services/item_adding_service/item_adding_service.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_event.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_state.dart';

class AddAmountInfoBloc extends Bloc<AddDataEvent, AddAmountInfoState> {
  AddAmountInfoBloc() : super(AddAmountInfoInitialState());
  final FBService _firebaseService = ItemAddingService();

  @override
  Stream<AddAmountInfoState> mapEventToState(AddDataEvent event) async* {
    /*//final box = Hive.box(kHiveDataName);
    final storageBox = Hive.box<ListOfTilesModel>(storageKey);
    final googleUserIdBox = Hive.box(kGoogleUserId);
    final userID = googleUserIdBox.get("userID");
    final firebaseDB = FirebaseService();*/

    if (event is AddAmountInfoEvent) {
      if (0 ==
              0 /*event.title.isNotEmpty &&
          event.amount.isNotEmpty &&
          event.valueSelectedState.selectedValue != null &&
          event.currencyValue != null &&
          event.location != null*/
          ) {
        ItemsAddingModel itemModel = ItemsAddingModel(
            event.title,
            event.amount,
            event.dateInString,
            "received",
            event.currencyValue,
            0.255555,
            0.26666);
        itemModel = await _firebaseService.addDoc(itemModel);
        yield AddAmountInfoDone(itemModel);
        /* final title = event.title,
            amount = event.amount,
            option = event.valueSelectedState.selectedValue,
            date = event.dateInString,
            currency = event.currencyValue;
        final location = event.location;
        final latitude = location.lat;
        final longitude = location.long;
        final document = await firebaseDB.findDocumentExistsByField(
            collectionName: "users",
            dataToMatch: {"id": userID},
            key1: "id",
            key2: "id");
        final collectionOfItems = await document.reference.collection("items");
        print("This is the Collection $collectionOfItems");
        final snapshot = await collectionOfItems.get();
        final numOfItems = snapshot.docs.length + 1;
        final itemAddedDocument = await collectionOfItems.add({
          "auto_increment": numOfItems,
          "title": title,
          "amount": amount,
          "currency": currency,
          "date": date,
          "option": option,
          "latitude": latitude,
          "longitude": longitude,
        });
        final data = (await itemAddedDocument.get()).data();

        storageBox.add(ListOfTilesModel.fromJSON(data));*/
        //yield AddAmountInfoDone<ListOfTilesModel>(box: storageBox);
      }
    } else
      yield AddAmountInfoError("Item has not been added");
  }
}
/*
* Box with the key of Storage
* that box will have a List object
*
* */
