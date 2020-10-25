import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DateTimePickState extends Equatable {
  final DateTime dateTime;

  DateTimePickState({this.dateTime});
  @override
  // TODO: implement props
  List<Object> get props => [dateTime];
}

class DateTimePickInitialState extends DateTimePickState {
  DateTime get date {
    final currentDate = DateTime.now();
    final currentTime = TimeOfDay.now();
    return DateTime(currentDate.year, currentDate.month, currentDate.day,
        currentTime.hour, currentDate.minute);
  }
}

class DateTimePickedState extends DateTimePickState {
  final DateTime dateTime;
  DateTimePickedState(this.dateTime) : super(dateTime: dateTime);
}
