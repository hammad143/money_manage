import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_event.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_state.dart';

class AddAmountInfoBloc extends Bloc<AddAmountInfoEvent, AddAmountInfoState> {
  AddAmountInfoBloc() : super(AddAmountInfoInitialState());
  @override
  Stream<AddAmountInfoState> mapEventToState(AddAmountInfoEvent event) async* {
    final box = Hive.box(kHiveDataName);
    final listIndexBox = Hive.box(kListIndex);
    final storageBox = Hive.box<List>(kHiveStorage);
    if (event.title.isNotEmpty && event.amount.isNotEmpty) {
      box.putAll({
        "title": event.title,
        "amount": event.amount,
        "date": event.dateInString
      });
      final title = box.get("title");
      final amount = box.get("amount");
      final date = box.get("date");
      final index = listIndexBox.get("index");
      if (index == null) {
        listIndexBox.put("index", 0);
      } else {
        listIndexBox.put(
            "index", listIndexBox.get("index", defaultValue: 0) + 1);

        final list =
            storageBox.get("storage").cast<ListOfTilesModel>().toList();
        //storageBox.putAt(index, "awesome");
        if (list != null) {
          print("added successfully");
          yield AddAmountInfoDone(box: storageBox);
        }
      }
    }
  }
}
/*
* Box with the key of Storage
* that box will have a List object
*
* */
