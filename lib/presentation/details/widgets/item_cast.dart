import 'package:flutter/material.dart';
import 'package:flutter_movie_app/shared/widgets/app_network_image.dart';

class ItemCast extends StatelessWidget {
  final String name;
  final String avatar;

  const ItemCast({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.25,
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: AppNetworkImage(imageUrl: avatar),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            name,
            style: const TextStyle(color: Colors.black, fontSize: 12.0),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
