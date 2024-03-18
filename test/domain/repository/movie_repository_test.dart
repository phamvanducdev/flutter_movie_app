import 'package:flutter_movie_app/data/dto/movie_dto.dart';
import 'package:flutter_movie_app/data/repository_impl/movie_repository_impl.dart';
import 'package:flutter_movie_app/data/source/local/data_storage.dart';
import 'package:flutter_movie_app/data/source/network/api_service.dart';
import 'package:flutter_movie_app/domain/repository/movie_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mock_value.dart';
import 'movie_repository_test.mocks.dart';

@GenerateMocks([ApiService, DataStorage])
void main() {
  late ApiService apiService;
  late DataStorage dataStorage;
  late MovieRepository repository;

  setUp(() {
    apiService = MockApiService();
    dataStorage = MockDataStorage();
    repository = MovieRepositoryImpl(
      apiService: apiService,
      dataStorage: dataStorage,
    );
  });

  test('Test fetchMovieList from cache', () async {
    // Define the expected
    var movies = movieListMock;
    var movieDtoList = movieListMock.map((movie) => MovieDto.fromMovie(movie)).toList();

    // Mock the behavior of fetchMovieList method
    when(dataStorage.getMovieList()).thenAnswer((realInvocation) => Future.value(movieDtoList));

    // Call the method
    var result = await repository.fetchMovieList();

    // Verify the result
    expect(result.length, movies.length);
  });

  test('Test fetchMovieList from service', () async {
    // Define the expected
    var movies = movieListMock;
    var movieDtoList = movieListMock.map((movie) => MovieDto.fromMovie(movie)).toList();

    // Mock the behavior of fetchMovieList method
    when(dataStorage.getMovieList()).thenAnswer((realInvocation) => Future.value([]));
    when(apiService.fetchMovieList()).thenAnswer((realInvocation) => Future.value(movieDtoList));
    when(dataStorage.saveMovieList(movieDtoList)).thenAnswer((realInvocation) => Future.value(true));

    // Call the method
    var result = await repository.fetchMovieList();

    // Verify the result
    expect(result.length, movies.length);
  });
}
