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
    final counterBox = Hive.box<int>(counterKey);
    final googleIdBox = Hive.box(kGoogleUserId);
    final itemAutoIncBox = Hive.box(kNestedIncrementKey);
    if (event is AddAmountInfoEvent) {
      if (event.title.isNotEmpty && event.amount.isNotEmpty) {
        box.putAll({
          "title": event.title,
          "amount": event.amount,
          "date": event.dateInString,
          "option": event.valueSelectedState.selectedValue,
        });
        final title = box.get("title");
        final amount = box.get("amount");
        final date = box.get("date");
        final options = box.get("option");

        try {
          final lastIndex = counterBox.values.last;
          final incrementByOne = lastIndex + 1;

          counterBox.add(incrementByOne);
          storageBox.put(
            incrementByOne,
            ListOfTilesModel(
                title: title,
                amount: amount,
                dateInString: date,
                option: options),
          );
          final id = googleIdBox.get("userID");
          final querySnapshot = await FirebaseService().collection.get();
          final docs = querySnapshot.docs;
          final currentUser = docs.firstWhere((element) {
            final data = element.data();
            return data['id'] == id;
          });
          await currentUser.reference.collection("items").add({
            "title": title,
            "amount": amount,
            "option": options,
            "date": date,
            'auto_item_inc': incrementByOne,
          });
          print("${counterBox.values.last} This is the number");

          //docs.

        } catch (error) {
          counterBox.add(0);
          storageBox.put(
            0,
            ListOfTilesModel(
                title: title,
                amount: amount,
                dateInString: date,
                option: options),
          );
        }
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
