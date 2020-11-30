import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_management/services/authenticate_user_service/google_auth_service.dart';

abstract class AuthenticateAble<T> {
  T type;
  T checkType();
}

class GoogleServiceAuthAble
    implements AuthenticateAble<Future<GoogleSignInAccount>> {
  @override
  Future<GoogleSignInAccount> type;

  @override
  Future<GoogleSignInAccount> checkType() async {
    final auth = await GoogleAuthService().authenticate();
    return auth;
  }
}
