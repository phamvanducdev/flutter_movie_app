import 'package:flutter_movie_app/domain/entity/movie.dart';
import 'package:flutter_movie_app/domain/entity/user_info.dart';
import 'package:flutter_movie_app/domain/repository/auth_repository.dart';
import 'package:flutter_movie_app/domain/repository/movie_repository.dart';
import 'package:flutter_movie_app/presentation/home/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mock_value.dart';
import 'home_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository, MovieRepository])
void main() {
  late HomeBLoC bLoC;
  late AuthRepository authRepository;
  late MovieRepository movieRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    movieRepository = MockMovieRepository();
    bLoC = HomeBLoC(
      authRepository: authRepository,
      movieRepository: movieRepository,
    );
  });

  test('Test fetchUserLogged success', () async {
    // Define the expected
    final UserInfo userInfo = UserInfo(uid: 'user_001');

    // Mock the behavior of getUserLogged method
    when(authRepository.getUserLogged()).thenAnswer((realInvocation) => Future.value(userInfo));

    /// Call the method test
    bLoC.fetchUserLogged();

    /// Expect that the userLoggedStream has received the expected userInfo
    expect(await bLoC.userLoggedStream.first, userInfo);
  });

  test('Test fetchUserLogged fail', () async {
    // Define the expected

    // Mock the behavior of fetchUserLogged method
    when(authRepository.getUserLogged()).thenAnswer((realInvocation) => Future.error('Error message!'));

    /// Call the method test
    bLoC.fetchUserLogged();

    /// Expect that the userLoggedStream has received the expected null
    expect(await bLoC.userLoggedStream.first, null);
  });

  test('Test fetchMovieList success', () async {
    // Define the expected
    final List<Movie> movies = movieListMock;

    // Mock the behavior of fetchMovieList method
    when(movieRepository.fetchMovieList()).thenAnswer((realInvocation) => Future.value(movies));

    /// Call the method test
    bLoC.fetchMovieList();

    /// Expect that the movieListStream has received the expected movies
    expect(await bLoC.movieListStream.first, movies);
  });

  test('Test fetchMovieList fail', () async {
    // Define the expected

    // Mock the behavior of fetchMovieList method
    when(movieRepository.fetchMovieList()).thenAnswer((realInvocation) => Future.error('Error messages!'));

    /// Call the method test
    bLoC.fetchMovieList();

    /// Expect that the movieListStream has received the expected empty movies
    expect(await bLoC.movieListStream.first, []);
  });
}
