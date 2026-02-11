import 'package:flutter/material.dart';

class ImageApi extends StatelessWidget {
  final String imagePath;
  final double borderRadius;
  final int width;
  final String? description;

  const ImageApi({
    super.key,
    required this.imagePath,
    this.borderRadius = 16.0,
    this.width = 500,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = "https://image.tmdb.org/t/p/w$width$imagePath";

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),

      child: Image.network(
        imageUrl,

        width: double.infinity,

        fit: BoxFit.cover,

        semanticLabel: description ?? "Image du film",

        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey[900],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },

        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[800],
            alignment: Alignment.center,
            child: const Icon(Icons.broken_image, color: Colors.white54),
          );
        },
      ),
    );
  }
}