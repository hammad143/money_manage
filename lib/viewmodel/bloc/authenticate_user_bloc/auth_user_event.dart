import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticateUserEvent extends Equatable {
  final GoogleSignIn signIn;

  AuthenticateUserEvent([this.signIn]);
  @override
  List<Object> get props => [];
}

class AuthenticateUserRequestEvent extends AuthenticateUserEvent {
  final GoogleSignIn signIn;
  AuthenticateUserRequestEvent([this.signIn]) : super(signIn);
}

class AuthenticateUserSignOuttEvent extends AuthenticateUserEvent {}
