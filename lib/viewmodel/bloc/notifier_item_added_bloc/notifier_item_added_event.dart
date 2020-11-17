import 'package:equatable/equatable.dart';

class NotifierItemAddedEvent extends Equatable {
  final String key;

  NotifierItemAddedEvent(this.key);

  @override
  List<Object> get props => [];
}
