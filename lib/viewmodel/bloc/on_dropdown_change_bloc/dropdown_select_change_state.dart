import 'package:equatable/equatable.dart';

class DropDownSelectChangeState extends Equatable {
  @override
  List<Object> get props => [];
}

class DropDownSelectedValue extends DropDownSelectChangeState {
  final value;
  DropDownSelectedValue(this.value);
  @override
  List<Object> get props => [value];
}
