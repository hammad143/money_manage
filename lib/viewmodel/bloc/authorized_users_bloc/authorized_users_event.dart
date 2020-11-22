import 'package:equatable/equatable.dart';

class AuthorizedUsersEvent extends Equatable {
  final String authorizeUserKey;

  AuthorizedUsersEvent(this.authorizeUserKey);
  @override
  List<Object> get props => [];
}
