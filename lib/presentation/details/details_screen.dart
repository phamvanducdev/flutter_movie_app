import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie_app/domain/entity/movie.dart';
import 'package:flutter_movie_app/domain/repository/movie_repository.dart';
import 'package:flutter_movie_app/presentation/details/details_bloc.dart';
import 'package:flutter_movie_app/presentation/details/widgets/about_info.dart';
import 'package:flutter_movie_app/presentation/details/widgets/item_cast.dart';
import 'package:flutter_movie_app/shared/helpers/movie_helper.dart';
import 'package:flutter_movie_app/shared/widgets/app_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  final Movie movie;

  const DetailsScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ProxyProvider<MovieRepository, DetailsBLoC>(
          update: (context, repository, previous) => previous ?? DetailsBLoC(repository),
          dispose: (_, bLoC) => bLoC.dispose(),
        ),
      ],
      child: DetailsPage(movie: movie),
    );
  }
}

class DetailsPage extends StatefulWidget {
  final Movie movie;

  const DetailsPage({
    super.key,
    required this.movie,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late DetailsBLoC _bLoC;

  @override
  void initState() {
    super.initState();
    _bLoC = context.read<DetailsBLoC>();
    _bLoC.initializer(widget.movie);
  }

  @override
  Widget build(BuildContext context) {
    final Movie movie = widget.movie;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset('assets/icons/ic_back.svg'),
        ),
        actions: [
          StreamBuilder<bool>(
            stream: _bLoC.isSavedStream,
            builder: (context, snapshot) {
              final isSaved = snapshot.data ?? false;
              return IconButton(
                onPressed: () => isSaved ? _bLoC.onUnaveMovie(movie) : _bLoC.onSaveMovie(movie),
                icon: SvgPicture.asset(
                  'assets/icons/ic_save.svg',
                  colorFilter: ColorFilter.mode(
                    isSaved ? Colors.red : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            SizedBox(
              height: 320,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: AppNetworkImage(imageUrl: movie.posterUrl, boxFit: BoxFit.cover),
                  ),
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: AppNetworkImage(imageUrl: movie.posterUrl, boxFit: BoxFit.fitHeight),
                  ),
                  Container(
                    height: 16.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Information about
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/ic_star.svg'),
                      const SizedBox(width: 4.0),
                      Text(
                        movie.imdbRating != 0 ? '${movie.imdbRating}/10 IMDb' : 'N/A IMDb',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: movie.genres.map(
                      (genre) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                          decoration: BoxDecoration(color: const Color(0xFFDBE3FF), borderRadius: BorderRadius.circular(12.0)),
                          child: Text(
                            genre,
                            style: const TextStyle(color: Color(0xFF88A4E8), fontSize: 12.0),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: AboutInfo(
                          title: 'Release date',
                          description: movie.releaseDate,
                        ),
                      ),
                      Expanded(
                        child: AboutInfo(
                          title: 'Length',
                          description: MovieHelper.formatDuration(movie.duration),
                        ),
                      ),
                      Expanded(
                        child: AboutInfo(
                          title: 'Rating',
                          description: movie.contentRating.isNotEmpty ? movie.contentRating : 'N/A',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontFamily: 'Merriweather',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    movie.storyLine,
                    style: const TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Cast',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontFamily: 'Merriweather',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: movie.actors
                    .map(
                      (actor) => ItemCast(
                        name: actor,
                        avatar: 'https://xsgames.co/randomusers/assets/avatars/male/${Random().nextInt(10)}.jpg',
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
