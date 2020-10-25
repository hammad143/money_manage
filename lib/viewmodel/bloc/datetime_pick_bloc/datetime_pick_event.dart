import 'package:equatable/equatable.dart';

class DateTimePickEvent extends Equatable {
  final DateTime dateTime;

  DateTimePickEvent(this.dateTime);
  @override
  List<Object> get props => [];
}
