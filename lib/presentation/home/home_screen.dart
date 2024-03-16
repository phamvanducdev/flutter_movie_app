import 'package:flutter/material.dart';
import 'package:flutter_movie_app/domain/entity/movie.dart';
import 'package:flutter_movie_app/domain/repository/movie_repository.dart';
import 'package:flutter_movie_app/presentation/home/home_bloc.dart';
import 'package:flutter_movie_app/presentation/home/widgets/item_movie.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ProxyProvider<MovieRepository, HomeBLoC>(
          update: (context, repository, previous) => previous ?? HomeBLoC(repository),
          dispose: (_, bLoC) => bLoC.dispose(),
        ),
      ],
      child: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBLoC _bLoC;

  @override
  void initState() {
    super.initState();
    _bLoC = context.read<HomeBLoC>();
    _bLoC.initializer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.1,
        title: const Text(
          'MovieApp',
          style: TextStyle(color: Colors.black, fontSize: 16.0, fontFamily: 'Merriweather'),
        ),
        leading: IconButton(icon: SvgPicture.asset('assets/icons/ic_menu.svg'), onPressed: null),
        actions: [
          IconButton(icon: SvgPicture.asset('assets/icons/ic_notification.svg'), onPressed: null),
        ],
      ),
      body: StreamBuilder<List<Movie>>(
        stream: _bLoC.movieListStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final movieList = snapshot.data ?? [];
          if (movieList.isEmpty) {
            return const Center(child: Text('Data not found!'));
          }
          return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: movieList.length,
              itemBuilder: (context, index) {
                return ItemMovie(
                  movie: movieList[index],
                  onItemPressed: () {
                    context.go('/details', extra: movieList[index]);
                  },
                );
              });
        },
      ),
    );
  }
}
