import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageCached extends StatelessWidget {
  final String imageUrl;
  final BoxFit? boxFit;

  const NetworkImageCached({
    super.key,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Container(
        color: Colors.grey[200],
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2.0)),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[200],
        child: Center(child: Icon(Icons.error, color: Colors.red[400])),
      ),
      fit: boxFit,
    );
  }
}
