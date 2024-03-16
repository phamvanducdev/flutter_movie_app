import 'package:flutter/cupertino.dart';
import 'package:flutter_movie_app/domain/entity/movie.dart';
import 'package:flutter_movie_app/presentation/details/details_screen.dart';
import 'package:flutter_movie_app/presentation/home/home_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return DetailsScreen(movie: state.extra as Movie);
          },
        ),
      ],
    ),
  ],
);
