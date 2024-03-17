// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter_movie_app/data/dto/movie_dto.dart';
import 'package:flutter_movie_app/data/dto/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

const USER_LOGGED_KEY = 'user-logged';
const MOVIE_LIST_KEY = 'movie-list';
const MOVIE_LIST_SAVED_KEY = 'movie-list-saved';

abstract class DataStorage {
  // Save user logged information
  Future<void> saveUserLogged(UserDto userLogged);
  Future<UserDto?> getUserLogged();
  Future<bool> removeUserLogged();

  // Save movies fetched
  Future<bool> saveMovieList(List<MovieDto> movies);
  Future<List<MovieDto>> getMovieList();

  // Save movies user saved
  Future<List<MovieDto>> getMovieListSaved();
  Future<bool> saveMovie(MovieDto movie);
  Future<bool> unSaveMovie(String movieId);
}

class DataStorageImpl implements DataStorage {
  final SharedPreferences _sharedPref;

  DataStorageImpl({
    required SharedPreferences sharedPref,
  }) : _sharedPref = sharedPref;

  @override
  Future<UserDto?> getUserLogged() async {
    final String? string = _sharedPref.getString(USER_LOGGED_KEY);
    if (string == null) {
      return null;
    }
    return UserDto.fromMap(json.decode(string));
  }

  @override
  Future<void> saveUserLogged(UserDto userLogged) async {
    await _sharedPref.setString(USER_LOGGED_KEY, jsonEncode(userLogged.toMap()));
  }

  @override
  Future<bool> removeUserLogged() async {
    return await _sharedPref.remove(USER_LOGGED_KEY);
  }

  @override
  Future<List<MovieDto>> getMovieList() async {
    final stringList = _sharedPref.getStringList(MOVIE_LIST_KEY);
    return stringList != null ? stringList.map((string) => MovieDto.fromMap(jsonDecode(string))).toList() : [];
  }

  @override
  Future<bool> saveMovieList(List<MovieDto> movies) async {
    final stringList = movies.map((movie) => jsonEncode(movie.toMap())).toList();
    return _sharedPref.setStringList(MOVIE_LIST_KEY, stringList);
  }

  @override
  Future<List<MovieDto>> getMovieListSaved() async {
    final stringList = _sharedPref.getStringList(MOVIE_LIST_SAVED_KEY);
    return stringList != null ? stringList.map((string) => MovieDto.fromMap(jsonDecode(string))).toList() : [];
  }

  @override
  Future<bool> saveMovie(MovieDto movie) async {
    final savedList = await getMovieListSaved();
    if (savedList.map((saved) => saved.id).contains(movie.id)) return false;
    savedList.add(movie);
    final stringList = savedList.map((movie) => jsonEncode(movie.toMap())).toList();
    return _sharedPref.setStringList(MOVIE_LIST_SAVED_KEY, stringList);
  }

  @override
  Future<bool> unSaveMovie(String movieId) async {
    final savedList = await getMovieListSaved();
    savedList.removeWhere((saved) => saved.id == movieId);
    final stringList = savedList.map((movie) => jsonEncode(movie.toMap())).toList();
    return _sharedPref.setStringList(MOVIE_LIST_SAVED_KEY, stringList);
  }
}
