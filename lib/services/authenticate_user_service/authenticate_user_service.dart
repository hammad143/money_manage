import 'package:money_management/services/authenticate_user_service/authenticate_user.dart';

class AuthenticateUserService<T> {
  //final AuthenticateAble authenticateAble;
  //final AuthenticationType authType;
  final AuthenticateUser<T> authUser;
  AuthenticateUserService(this.authUser);

  T authenticate() {
    final user = authUser.authenticate();
    return user;
  }

  signOut() {
    //authenticationService.signOut();
  }
}

enum AuthenticationType {
  google,
  facebook,
  github,
  twitter,
  normal,
}
