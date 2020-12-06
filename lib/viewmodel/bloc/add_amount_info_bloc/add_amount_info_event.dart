import 'package:equatable/equatable.dart';
import 'package:money_management/model/location_model.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_state.dart';

class AddDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddAmountInfoInitialEvent extends AddDataEvent {}

class AddAmountInfoEvent extends AddDataEvent {
  final String title, amount, dateInString, currencyValue;
  DropDownSelectChangeState valueSelectedState;
  LocationModel location;
  final int index;
  AddAmountInfoEvent(this.title, this.amount, this.dateInString,
      this.valueSelectedState, this.currencyValue, this.location,
      {this.index});
  @override
  List<Object> get props => [];
}

class AddLastIndexEvent extends AddDataEvent {
  @override
  List<Object> get props => [];
}
