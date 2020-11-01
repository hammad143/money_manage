import 'package:equatable/equatable.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_state.dart';

class AddDataEvent extends Equatable {
  @override

  List<Object> get props => [];

}
class AddAmountInfoEvent extends AddDataEvent {
  final String title, amount, dateInString;
  DropDownSelectChangeState valueSelectedState;
  final int index;
  AddAmountInfoEvent(this.title, this.amount, this.dateInString, this.valueSelectedState, {this.index});
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class AddLastIndexEvent extends AddDataEvent {

  @override
  List<Object> get props => [];

}
