abstract class AuthenticateUser<T> {
  T authenticate();

  Future<bool> signOut();
}
