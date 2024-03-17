import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_movie_app/data/source/local/data_storage.dart';
import 'package:flutter_movie_app/domain/entity/user_info.dart' as models;
import 'package:flutter_movie_app/data/dto/user_dto.dart';
import 'package:flutter_movie_app/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final DataStorage _dataStorage;

  AuthRepositoryImpl({
    required FirebaseAuth firebaseAuth,
    required DataStorage dataStorage,
  })  : _firebaseAuth = firebaseAuth,
        _dataStorage = dataStorage;

  @override
  Future<models.UserInfo?> getUserLogged() async {
    final userDto = await _dataStorage.getUserLogged();
    if (userDto == null) {
      return null;
    }
    return models.UserInfo.fromUserDto(userDto);
  }

  @override
  Future<models.UserInfo> onRegister(String email, String password) async {
    var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    var authUser = userCredential.user;
    if (authUser == null) {
      throw Exception('Failed to sign up account.');
    }
    var userDto = UserDto.fromAuthUser(authUser);
    await _dataStorage.saveUserLogged(userDto);
    return models.UserInfo.fromUserDto(userDto);
  }

  @override
  Future<models.UserInfo> onLogin(String email, String password) async {
    var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    var authUser = userCredential.user;
    if (authUser == null) {
      throw Exception('Failed to sign in account.');
    }
    var userDto = UserDto.fromAuthUser(authUser);
    await _dataStorage.saveUserLogged(userDto);
    return models.UserInfo.fromUserDto(userDto);
  }

  @override
  Future<bool> onLogout() async {
    return await _dataStorage.removeUserLogged();
  }
}
