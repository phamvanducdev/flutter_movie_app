import 'package:flutter_movie_app/domain/entity/movie.dart';

List<Movie> movieListMock = [
  Movie(
    id: 'movie_001',
    title: 'movie_title_001',
    posterUrl: 'posterUrl_001',
    storyLine: 'storyLine_001',
    duration: 'duration_001',
    year: 'year_001',
    releaseDate: 'releaseDate_001',
    imdbRating: 10.0,
    averageRating: 10.0,
    contentRating: 'contentRating_001',
    genres: [],
    actors: [],
  ),
  Movie(
    id: 'movie_002',
    title: 'movie_title_002',
    posterUrl: 'posterUrl_002',
    storyLine: 'storyLine_002',
    duration: 'duration_002',
    year: 'year_002',
    releaseDate: 'releaseDate_002',
    imdbRating: 0.0,
    averageRating: 0.0,
    contentRating: 'contentRating_002',
    genres: [],
    actors: [],
  ),
];
