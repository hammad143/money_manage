import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NotifierItemAddedEvent extends Equatable {
  final QuerySnapshot querySnapshot;

  NotifierItemAddedEvent(this.querySnapshot);
  @override
  List<Object> get props => [];
}
