import 'package:equatable/equatable.dart';

class AddAmountInfoEvent extends Equatable {
  final String title, amount, dateInString;

  AddAmountInfoEvent(this.title, this.amount, this.dateInString);
  @override
  // TODO: implement props
  List<Object> get props => [];
}
