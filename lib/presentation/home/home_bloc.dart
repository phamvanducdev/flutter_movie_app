import 'package:flutter_movie_app/domain/entity/movie.dart';
import 'package:flutter_movie_app/domain/entity/user_info.dart';
import 'package:flutter_movie_app/domain/repository/auth_repository.dart';
import 'package:flutter_movie_app/domain/repository/movie_repository.dart';
import 'package:flutter_movie_app/shared/base_bloc.dart';
import 'package:rxdart/subjects.dart';

class HomeBLoC implements BaseBLoC {
  final AuthRepository _authRepository;
  final MovieRepository _movieRepository;

  HomeBLoC({
    required AuthRepository authRepository,
    required MovieRepository movieRepository,
  })  : _authRepository = authRepository,
        _movieRepository = movieRepository;

  final _movieListObject = BehaviorSubject<List<Movie>>();
  Stream<List<Movie>> get movieListStream => _movieListObject.stream;

  final _userLoggedObject = BehaviorSubject<UserInfo?>();
  Stream<UserInfo?> get userLoggedStream => _userLoggedObject.stream;

  Future<void> initializer() async {
    await fetchMovieList();
    await fetchUserLogged();
  }

  Future<void> fetchUserLogged() async {
    try {
      _userLoggedObject.add(await _authRepository.getUserLogged());
    } catch (e) {
      _userLoggedObject.add(null);
    }
  }

  Future<void> fetchMovieList() async {
    try {
      _movieListObject.add(await _movieRepository.fetchMovieList());
    } catch (e) {
      _movieListObject.add([]);
    }
  }

  Future<void> requestLogout() async {
    await _authRepository.onLogout();
    _userLoggedObject.add(null);
  }

  @override
  void dispose() {
    _movieListObject.close();
  }
}
