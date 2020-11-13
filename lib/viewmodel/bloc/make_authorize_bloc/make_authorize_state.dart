import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MakeAuthorizeState extends Equatable {
  @override
  List<Object> get props => [];
}

class MakeAuthorizeInitState extends MakeAuthorizeState {}

class MakeAuthorizeErrorState extends MakeAuthorizeState {}

class MakeAuthorizeSuccessState extends MakeAuthorizeState {
  final Stream<QuerySnapshot> snapshot;

  MakeAuthorizeSuccessState({this.snapshot});
}
