import 'package:flutter_movie_app/domain/repository/auth_repository.dart';
import 'package:flutter_movie_app/shared/base_bloc.dart';
import 'package:flutter_movie_app/shared/helpers/validation_helper.dart';
import 'package:rxdart/subjects.dart';

class LoginBLoC implements BaseBLoC {
  final AuthRepository _authRepository;

  LoginBLoC({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final _isLoadingObject = BehaviorSubject<bool>();
  Stream<bool> get isLoadingStream => _isLoadingObject.stream;

  final _isValidateObject = BehaviorSubject<bool>();
  Stream<bool> get isValidateStream => _isValidateObject.stream;

  final _isEnableLoginButtonObject = BehaviorSubject<bool>();
  Stream<bool> get isEnableLoginButtonStream => _isEnableLoginButtonObject.stream;

  String _email = '';
  String _password = '';

  void onChangeEmail(String value) {
    _email = value;
    onValidate();
  }

  void onChangePassword(String value) {
    _password = value;
    onValidate();
  }

  void onValidate() {
    if (_email.isNotEmpty) {
      _isValidateObject.add(ValidationHelper.isEmail(_email));
    } else {
      _isValidateObject.add(true);
    }
    _isEnableLoginButtonObject.add(
      _email.isNotEmpty && _password.isNotEmpty && ValidationHelper.isEmail(_email),
    );
  }

  void onLogin({
    required void Function() onSuccess,
    required void Function() onFailed,
  }) async {
    try {
      _isLoadingObject.add(true);
      await _authRepository.onLogin(_email, _password);
      _isLoadingObject.add(false);
      onSuccess();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      _isLoadingObject.add(false);
      onFailed();
    }
  }

  @override
  void dispose() {
    _isLoadingObject.close();
    _isValidateObject.close();
    _isEnableLoginButtonObject.close();
  }
}
