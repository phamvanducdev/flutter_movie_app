import 'package:flutter_movie_app/domain/entity/movie.dart';
import 'package:flutter_movie_app/domain/repository/movie_repository.dart';
import 'package:flutter_movie_app/shared/base_bloc.dart';
import 'package:rxdart/subjects.dart';

class DetailsBLoC implements BaseBLoC {
  final MovieRepository _movieRepository;

  DetailsBLoC(this._movieRepository);

  final _isSavedObject = BehaviorSubject<bool>();
  Stream<bool> get isSavedStream => _isSavedObject.stream;

  Future<void> initializer(Movie movie) async {
    _isSavedObject.add(await _movieRepository.isSaved(movie.id));
  }

  Future<void> onSaveMovie(Movie movie) async {
    await _movieRepository.saveMovie(movie);
    _isSavedObject.add(!_isSavedObject.value);
  }

  Future<void> onUnaveMovie(Movie movie) async {
    await _movieRepository.unSaveMovie(movie.id);
    _isSavedObject.add(!_isSavedObject.value);
  }

  @override
  void dispose() {
    _isSavedObject.close();
  }
}
