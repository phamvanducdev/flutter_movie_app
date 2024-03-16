abstract class AuthRepository {
  Future<void> onLogin(String email, String password);
}
