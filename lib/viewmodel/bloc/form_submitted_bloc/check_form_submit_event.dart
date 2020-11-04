import 'package:equatable/equatable.dart';

class CheckFormSubmitEvent extends Equatable {
  final bool isFormSubmit;

  CheckFormSubmitEvent(this.isFormSubmit);
  @override
  List<Object> get props => [];

}