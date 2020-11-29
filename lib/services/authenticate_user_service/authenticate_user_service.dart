abstract class AuthenticateUser<T> {
  T authenticate();

  Future<bool> signOut();
}

class AuthenticateUserSerivce {
  final AuthenticateUser authenticationSerivce;

  AuthenticateUserSerivce(this.authenticationSerivce);

  authenticate() async {
    final x = await authenticationSerivce.authenticate();
    return x;
  }

  signOut() {
    authenticationSerivce.signOut();
  }
}
