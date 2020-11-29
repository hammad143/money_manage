import 'package:equatable/equatable.dart';
import 'package:money_management/services/authenticate_user_service/authenticate_user_service.dart';

class AuthenticateUserEvent extends Equatable {
  AuthenticateUserEvent();
  @override
  List<Object> get props => [];
}

class AuthenticateUserRequestEvent extends AuthenticateUserEvent {
  AuthenticateUser authentication;
  AuthenticateUserRequestEvent(authentication) : super();
}

class AuthenticateUserSignOuttEvent extends AuthenticateUserEvent {}
