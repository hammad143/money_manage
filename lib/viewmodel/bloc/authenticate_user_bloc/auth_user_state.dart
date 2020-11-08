import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticateUserState extends Equatable {
  final GoogleSignIn googleSignIn;

  const AuthenticateUserState([this.googleSignIn]);
  @override
  List<Object> get props => [];
}

class UserNotLoggedInState extends AuthenticateUserState {
  //UserNotLoggedInState(GoogleSignIn googleSignIn) : super(googleSignIn);
}

class UserLoggedInState extends AuthenticateUserState {
  //UserLoggedInState(GoogleSignIn googleSignIn) : super(googleSignIn);
}
