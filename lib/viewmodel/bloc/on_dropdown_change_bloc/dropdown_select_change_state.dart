import 'package:equatable/equatable.dart';

class DropDownSelectChangeState extends Equatable {
  final int value;
  DropDownSelectChangeState([this.value]);

  String get selectedValue {
    if(value != null) {
      switch(value) {
        case 0:
          return "Spent";
        case 1:
          return "Received";
        case 2:
          return "Lost";
         break;
        default:
          return null;
          break;
      }
    }
    return null;
  }

  @override
  List<Object> get props => [value];
}

class DropDownSelectedValue extends DropDownSelectChangeState {
  final value;
  DropDownSelectedValue(this.value);
  @override
  List<Object> get props => [value];
}
