import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/data/repository_impl/auth_repository_impl.dart';
import 'package:flutter_movie_app/data/repository_impl/movie_repository_impl.dart';
import 'package:flutter_movie_app/data/source/local/data_storage.dart';
import 'package:flutter_movie_app/data/source/network/api_service.dart';
import 'package:flutter_movie_app/domain/repository/auth_repository.dart';
import 'package:flutter_movie_app/domain/repository/movie_repository.dart';
import 'package:flutter_movie_app/firebase_options.dart';
import 'package:flutter_movie_app/presentation/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        Provider<FirebaseAuth>(
          create: (context) => FirebaseAuth.instance,
        ),
        ProxyProvider2<FirebaseAuth, DataStorage, AuthRepository>(
          update: (context, firebaseAuth, dataStorage, previous) =>
              previous ??
              AuthRepositoryImpl(
                firebaseAuth: firebaseAuth,
                dataStorage: dataStorage,
              ),
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
    return MaterialApp(
      title: 'Movies Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Mulish',
      ),
      home: const HomeScreen(),
    );
  }
}
