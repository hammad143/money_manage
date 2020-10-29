import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_event.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_state.dart';

class AddAmountInfoBloc extends Bloc<AddAmountInfoEvent, AddAmountInfoState> {
  AddAmountInfoBloc() : super(null);
  @override
  Stream<AddAmountInfoState> mapEventToState(AddAmountInfoEvent event) async* {
    final box = Hive.box(kHiveDataName);
    if (event.title.isNotEmpty && event.amount.isNotEmpty) {
      box.putAll({
        "title": event.title,
        "amount": event.amount,
        "date": event.dateInString
      });
    }
    yield AddAmountInfoDone(hiveBox: box);
  }
}
