import 'package:money_management/services/authenticate_user_service/authenticate_user.dart';
import 'package:money_management/services/authenticate_user_service/authenticate_user_service.dart';
import 'package:money_management/services/authenticate_user_service/google_auth_service.dart';

abstract class AuthenticateAble {
  checkType(AuthenticationType type);
}

class AuthAble implements AuthenticateAble {
  @override
  AuthenticateUser checkType(AuthenticationType type) {
    switch (type) {
      case AuthenticationType.google:
        return GoogleAuthService();
        break;
      case AuthenticationType.facebook:
        break;
    }
    //final auth = await GoogleAuthService().authenticate();
    //return auth;
  }
}
