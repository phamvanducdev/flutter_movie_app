import 'package:flutter_movie_app/domain/entity/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovieList();
  Future<bool> saveMovie(Movie movie);
  Future<bool> unSaveMovie(String movieId);
  Future<bool> isSaved(String movieId);
}
