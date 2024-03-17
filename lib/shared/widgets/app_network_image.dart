import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: boxFit,
      width: width,
      height: height,
      imageUrl: imageUrl,
      placeholder: (context, url) => Container(
        color: Colors.grey[200],
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2.0)),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[200],
        child: Center(child: Icon(Icons.error, color: Colors.red[400])),
      ),
    );
  }
}
