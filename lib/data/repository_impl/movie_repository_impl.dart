import 'package:flutter_movie_app/data/dto/movie_dto.dart';
import 'package:flutter_movie_app/data/source/local/data_storage.dart';
import 'package:flutter_movie_app/data/source/network/api_service.dart';
import 'package:flutter_movie_app/domain/entity/movie.dart';
import 'package:flutter_movie_app/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final ApiService _apiService;
  final DataStorage _dataStorage;

  MovieRepositoryImpl({
    required ApiService apiService,
    required DataStorage dataStorage,
  })  : _apiService = apiService,
        _dataStorage = dataStorage;

  @override
  Future<List<Movie>> fetchMovieList() async {
    final cachedList = await _dataStorage.getMovieList();
    if (cachedList.isNotEmpty) {
      return cachedList.map((dto) => Movie.fromDto(dto)).toList();
    }
    final fetchedList = await _apiService.fetchMovieList();
    await _dataStorage.saveMovieList(fetchedList);
    return fetchedList.map((dto) => Movie.fromDto(dto)).toList();
  }

  @override
  Future<bool> saveMovie(Movie movie) async {
    var movieDto = MovieDto.fromMovie(movie);
    return _dataStorage.saveMovie(movieDto);
  }

  @override
  Future<bool> unSaveMovie(String movieId) async {
    return _dataStorage.unSaveMovie(movieId);
  }

  @override
  Future<bool> isSaved(String movieId) async {
    var savedList = await _dataStorage.getMovieListSaved();
    return savedList.map((e) => e.id).contains(movieId);
  }
}
