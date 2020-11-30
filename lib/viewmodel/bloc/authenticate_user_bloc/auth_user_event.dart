import 'package:equatable/equatable.dart';
import 'package:money_management/services/authenticate_user_service/authenticate_user_service.dart';

class AuthenticateUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticateUserRequestEvent extends AuthenticateUserEvent {
  final AuthenticationType authenticationType;
  AuthenticateUserRequestEvent(this.authenticationType);
}

class AuthenticateUserSignOuttEvent extends AuthenticateUserEvent {}
