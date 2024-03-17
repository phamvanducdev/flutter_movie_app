import 'package:flutter/material.dart';
import 'package:flutter_movie_app/domain/entity/movie.dart';
import 'package:flutter_movie_app/shared/helpers/movie_helper.dart';
import 'package:flutter_movie_app/shared/widgets/app_network_image.dart';
import 'package:flutter_svg/svg.dart';

class ItemMovie extends StatelessWidget {
  final Movie movie;
  final Function() onItemPressed;

  const ItemMovie({
    super.key,
    required this.movie,
    required this.onItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onItemPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize.width * 0.25,
              child: AspectRatio(
                aspectRatio: 85 / 125,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: AppNetworkImage(imageUrl: movie.posterUrl),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    movie.storyLine,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
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
                  const SizedBox(height: 4.0),
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
                  const SizedBox(height: 4.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/ic_duration.svg'),
                        const SizedBox(width: 4.0),
                        Text(
                          MovieHelper.formatDuration(movie.duration),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
