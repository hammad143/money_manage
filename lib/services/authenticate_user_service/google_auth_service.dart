import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_management/services/authenticate_user_service/authenticate_user.dart';

class GoogleAuthService
    implements AuthenticateUser<Future<GoogleSignInAccount>> {
  final GoogleSignIn _googleAuthentication = GoogleSignIn();
  @override
  Future<GoogleSignInAccount> authenticate() async {
    //final isSignedIn = await _googleAuthentication.isSignedIn();
    final user = await _googleAuthentication.signIn();
    return user;
  }

  Future<GoogleSignInAccount> _authenticate() async {}

  @override
  Future<bool> signOut() async {
    await _googleAuthentication.signOut();
    if (await _googleAuthentication.isSignedIn())
      return true;
    else
      return false;
  }
}
