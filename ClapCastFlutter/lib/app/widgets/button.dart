import 'package:flutter/material.dart';
import '../../ressources/app_color.dart';
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
            borderRadius: BorderRadius.circular(12.0),
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              height: 130.0,
              width: double.infinity,
              child: ImageApi(
                imagePath: imagePath,
                width: 500,
              ),
            ),
          ),

          const SizedBox(height: 6.0),

          Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 2,
            // Add "..." at the end of the text if it overflows
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
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
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: AppColor.appContrast,
                  fontSize: 16.0,
                ),
              ),

              Transform.scale(
                scale: scale,
                child: Switch(
                  value: isActive,
                  onChanged: onCheckedChange,
                  activeColor: AppColor.btnPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}