import 'package:flutter_movie_app/domain/entity/user_info.dart';

abstract class AuthRepository {
  Future<UserInfo?> getUserLogged();
  Future<UserInfo> onRegister(String email, String password);
  Future<UserInfo> onLogin(String email, String password);
  Future<bool> onLogout();
}
