import 'package:flutter/material.dart';
import 'package:flutter_movie_app/data/repository_impl/movie_repository_impl.dart';
import 'package:flutter_movie_app/data/source/local/data_storage.dart';
import 'package:flutter_movie_app/data/source/network/api_service.dart';
import 'package:flutter_movie_app/domain/repository/movie_repository.dart';
import 'package:flutter_movie_app/shared/app_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPref = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiService>(
          create: (context) => ApiServiceImpl(),
        ),
        Provider<DataStorage>(
          create: (context) => DataStorageImpl(sharedPref: sharedPref),
        ),
        ProxyProvider2<ApiService, DataStorage, MovieRepository>(
          update: (context, apiService, dataStorage, previous) =>
              previous ??
              MovieRepositoryImpl(
                apiService: apiService,
                dataStorage: dataStorage,
              ),
        ),
      ],
      child: const MovieApp(),
    ),
  );
}

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Movies Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Mulish',
      ),
    );
  }
}
