import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_movie_app/data/dto/movie_dto.dart';

// ignore: constant_identifier_names
const API_URL = 'https://raw.githubusercontent.com/FEND16/movie-json-data/master/json/movies-coming-soon.json';

abstract class ApiService {
  Future<List<MovieDto>> fetchMovieList();
}

class ApiServiceImpl implements ApiService {
  final Dio dio = Dio();

  @override
  Future<List<MovieDto>> fetchMovieList() async {
    try {
      Response response = await dio.get(API_URL);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.data);
        List<MovieDto> movies = jsonData.map((json) => MovieDto.fromMap(json)).toList();
        return movies;
      } else {
        throw Exception('Failed to fetching movies: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching movies: $e');
      throw Exception('Failed to fetching movies');
    }
  }
}
