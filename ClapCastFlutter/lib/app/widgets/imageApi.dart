import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../ressources/app_dimens.dart';

class ImageApi extends StatelessWidget {
  final String imagePath;
  final double borderRadius;
  final int width;
  final String? description;
  final double? height;

  const ImageApi({
    super.key,
    required this.imagePath,
    this.borderRadius = AppRadius.medium,
    this.width = 500,
    this.description,
    this.height,
  });

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;

    final imageUrl = "https://image.tmdb.org/t/p/w$width$imagePath";

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),

      child: Image.network(
        imageUrl,

        width: double.infinity,
        height: height,

        fit: BoxFit.cover,

        semanticLabel: description ?? l10n.movieImageFallback,

        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey[900],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: AppDimension.veryTiny),
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