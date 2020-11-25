import 'package:equatable/equatable.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';

class AuthorizedUsersState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthorizedUsersInitState extends AuthorizedUsersState {}

class AuthorizedUsersSuccessState extends AuthorizedUsersState {
  final List<GoogleUserModel> data;
  final int totalItems;

  AuthorizedUsersSuccessState({this.data, this.totalItems});

  @override
  // TODO: implement props
  List<Object> get props => [data];
}
