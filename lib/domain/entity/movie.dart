import 'package:flutter_movie_app/data/dto/movie_dto.dart';

class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final String storyLine;
  final String duration;
  final String year;
  final String releaseDate;
  final double imdbRating;

  final double averageRating;
  final String contentRating;
  final List<String> genres;
  final List<String> actors;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.storyLine,
    required this.duration,
    required this.year,
    required this.releaseDate,
    required this.imdbRating,
    required this.averageRating,
    required this.contentRating,
    required this.genres,
    required this.actors,
  });

  factory Movie.fromDto(MovieDto dto) => Movie(
        id: dto.id,
        title: dto.title,
        posterUrl: dto.posterUrl,
        storyLine: dto.storyLine,
        duration: dto.duration,
        year: dto.year,
        releaseDate: dto.releaseDate,
        imdbRating: dto.imdbRating,
        averageRating: dto.averageRating,
        contentRating: dto.contentRating,
        genres: dto.genres,
        actors: dto.actors,
      );
}
