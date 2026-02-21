import 'package:flutter/material.dart';
import '../../ressources/app_color.dart';
import '../../ressources/app_dimens.dart';
import 'imageApi.dart';

class MediaCardButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onClick;

  const MediaCardButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    // GestureDetector allow to intercept tactil touch
    return GestureDetector(
      onTap: onClick,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.small),
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              height: AppOffersSize.mediumHeight,
              width: double.infinity,
              child: ImageApi(
                imagePath: imagePath,
                width: 500,
              ),
            ),
          ),

          const SizedBox(height: AppCircleSize.tiny),

          Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 2,
            // Add "..." at the end of the text if it overflows
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: AppText.medium_12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ToggleButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final ValueChanged<bool> onCheckedChange;
  final double scale;

  const ToggleButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.onCheckedChange,
    this.scale = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onCheckedChange(!isActive),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppMargin.small,
              vertical: AppMargin.tiny
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: AppColor.appContrast,
                  fontSize: AppText.medium,
                ),
              ),

              Transform.scale(
                scale: scale,
                child: Switch(
                  value: isActive,
                  onChanged: onCheckedChange,
                  thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColor.btnPrimary;
                    }
                    return Colors.grey;
                  }),

                  trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColor.btnPrimary.withOpacity(0.5);
                    }
                    return null;
                  }),

                  trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
                    return Colors.transparent;
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}