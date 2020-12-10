import 'package:bloc/bloc.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_event.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_state.dart';

class DropDownSelectChangeBloc
    extends Bloc<DropDownSelectChangeEvent, DropDownSelectChangeState> {
  DropDownSelectChangeBloc() : super(null);
  @override
  Stream<DropDownSelectChangeState> mapEventToState(
      DropDownSelectChangeEvent event) async* {
    print("Event State change: ${event} ${event.value}");
    if (event.value != null) yield DropDownSelectedValue(event.value);
  }
}
