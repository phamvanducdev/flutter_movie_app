import 'package:flutter_movie_app/domain/entity/movie.dart';

class MovieDto {
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

  MovieDto({
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

  factory MovieDto.fromMap(Map<String, dynamic> json) {
    return MovieDto(
      id: json['id'],
      title: json['title'],
      posterUrl: json['posterurl'],
      storyLine: json['storyline'],
      duration: json['duration'],
      year: json['year'],
      releaseDate: json['releaseDate'],
      imdbRating: jsonToDouble(json['imdbRating']),
      averageRating: jsonToDouble(json['averageRating']),
      contentRating: json['contentRating'],
      genres: List<String>.from(json['genres']),
      actors: List<String>.from(json['actors']),
    );
  }

  factory MovieDto.fromMovie(Movie movie) {
    return MovieDto(
      id: movie.id,
      title: movie.title,
      posterUrl: movie.posterUrl,
      storyLine: movie.storyLine,
      duration: movie.duration,
      year: movie.year,
      releaseDate: movie.releaseDate,
      imdbRating: movie.imdbRating,
      averageRating: movie.averageRating,
      contentRating: movie.contentRating,
      genres: movie.genres,
      actors: movie.actors,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'posterurl': posterUrl,
        'storyline': storyLine,
        'duration': duration,
        'year': year,
        'releaseDate': releaseDate,
        'imdbRating': imdbRating,
        'averageRating': averageRating,
        'contentRating': contentRating,
        'genres': genres,
        'actors': actors,
      };
}

double jsonToDouble(dynamic json) {
  switch (json.runtimeType) {
    case String:
      return double.tryParse(json) ?? 0.0;
    case int:
      return json.toDouble();
    case double:
      return json;
    default:
      return 0.0;
  }
}
