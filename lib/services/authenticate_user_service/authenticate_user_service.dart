import 'package:money_management/services/authenticate_user_service/authenticate_user.dart';
import 'package:money_management/services/authenticate_user_service/authenticateable.dart';

class AuthenticateUserService<T> {
  //final AuthenticateAble authenticateAble;
  //final AuthenticationType authType;
  final AuthenticateUser<T> authUser;
  T user;
  AuthenticateUserService(this.authUser);

  Future<T> authenticate() async {
     user = await authUser.authenticate();
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
