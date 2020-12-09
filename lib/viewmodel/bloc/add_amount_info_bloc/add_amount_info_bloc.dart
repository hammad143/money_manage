import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/tiles_item_model/item_model.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/services/item_adding_service/item_adding_service.dart';
import 'package:money_management/util/boxes_facade/boxes_facade.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_event.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_state.dart';

class AddAmountInfoBloc extends Bloc<AddDataEvent, AddAmountInfoState> {
  AddAmountInfoBloc() : super(AddAmountInfoInitialState());
  final FBService _firebaseService = ItemAddingService();
  List<ItemsAddingModel> _itemModel = [];
  BoxesFacade _boxFacade = BoxesFacade();
  Box<ItemsAddingModel> get itemAddingBox =>
      _boxFacade.getListItemBox<ItemsAddingModel>();

  @override
  Stream<AddAmountInfoState> mapEventToState(AddDataEvent event) async* {
    if (event is AddAmountInfoInitialEvent) {
      final list = await _firebaseService.getDocs();
      if (list.length == itemAddingBox.length) {
        print("Length is same ");
        _itemModel = itemAddingBox.values.toList();
        yield AddAmountInfoInitialState(_itemModel);
      } else {
        for (int i = 0; i < list.length; i++) {
          if (!itemAddingBox.containsKey(i)) {
            print("Item is being Added now!!!!!!!!!!!!");
            itemAddingBox.add(list[i]);
          }
        }
        _itemModel = itemAddingBox.values.toList();
        yield AddAmountInfoInitialState(_itemModel);
      }
    } else if (event is AddAmountInfoEvent) {
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
        final item = await _firebaseService.addDoc(itemModel);
        itemAddingBox.add(item);
        print("Added an Item");
        _itemModel = itemAddingBox.values.toList();
        yield AddAmountInfoDone(_itemModel);
      }
    } else
      yield AddAmountInfoError("Item has not been added");
  }
}
/*
* on init event occurs fetch documents
* get all documents length
* if documents length matches to box length, return currentBox
* else add last added item  to the currentBox
* */
