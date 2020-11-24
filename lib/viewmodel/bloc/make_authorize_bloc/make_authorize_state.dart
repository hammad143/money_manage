import 'package:equatable/equatable.dart';

class MakeAuthorizeState extends Equatable {
  @override
  List<Object> get props => [];
}

class MakeAuthorizeInitState extends MakeAuthorizeState {}

class MakeAuthorizeErrorState extends MakeAuthorizeState {
  final String msg;

  MakeAuthorizeErrorState(this.msg);

  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class MakeAuthorizeSuccessState extends MakeAuthorizeState {
  String displayName;

  MakeAuthorizeSuccessState({this.displayName});
  @override
  List<Object> get props => [displayName];
}

class MakeAlreadyAuthorizeState extends MakeAuthorizeState {}
