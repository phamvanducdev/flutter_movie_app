import 'package:flutter_movie_app/domain/repository/auth_repository.dart';
import 'package:flutter_movie_app/presentation/login/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LoginBLoC bLoC;
  late AuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    bLoC = LoginBLoC(
      authRepository: authRepository,
    );
  });

  test('Test onChangeEmail valid', () async {
    // Define the expected
    var email = 'email@example.com';

    // Mock the behavior of getUserLogged method

    /// Call the method test
    bLoC.onChangeEmail(email);

    /// Expect that the isValidateStream has received the expected true
    expect(await bLoC.isValidateStream.first, true);
  });

  test('Test onChangeEmail unvalid', () async {
    // Define the expected
    var email = 'email example.com';

    // Mock the behavior of getUserLogged method

    /// Call the method test
    bLoC.onChangeEmail(email);

    /// Expect that the isValidateStream has received the expected false
    expect(await bLoC.isValidateStream.first, false);
  });
}
