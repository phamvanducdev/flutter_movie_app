import 'package:flutter_movie_app/domain/entity/movie.dart';
import 'package:flutter_movie_app/domain/repository/movie_repository.dart';
import 'package:flutter_movie_app/shared/base_bloc.dart';
import 'package:rxdart/subjects.dart';

class HomeBLoC implements BaseBLoC {
  final MovieRepository _movieRepository;

  HomeBLoC(this._movieRepository);

  final _movieListObject = BehaviorSubject<List<Movie>>();
  Stream<List<Movie>> get movieListStream => _movieListObject.stream;

  Future<void> initializer() async {
    _movieListObject.add(await _movieRepository.fetchMovieList());
  }

  @override
  void dispose() {
    _movieListObject.close();
  }
}
