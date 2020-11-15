import 'package:equatable/equatable.dart';

class AuthorizedUsersState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthorizedUsersInitState extends AuthorizedUsersState {}

class AuthorizedUsersSuccessState extends AuthorizedUsersState {
  final Map<String, dynamic> data;

  AuthorizedUsersSuccessState({this.data});

  @override
  // TODO: implement props
  List<Object> get props => [data];
}
