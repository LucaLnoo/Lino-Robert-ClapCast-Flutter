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
    return SizedBox(
      width: 125.0,
      height: 175.0,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.0),
        child: InkWell(
          onTap: onClick,
          borderRadius: BorderRadius.circular(16.0),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                Expanded(
                  child: ImageApi(
                    imagePath: imagePath,
                    borderRadius: 12.0,
                    width: 500,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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