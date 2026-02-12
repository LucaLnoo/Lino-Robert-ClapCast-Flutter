import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../generated/assets.dart';
import '../../ressources/app_color.dart';

class QrCodeClapCast extends StatelessWidget {
  final String url;
  const QrCodeClapCast({super.key, required this.url});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        QrImageView(
          data: url,
          version: QrVersions.auto,
          size: 200.0,

          eyeStyle: const QrEyeStyle(
            eyeShape: QrEyeShape.square,
            color: AppColor.appContrast,
          ),

          dataModuleStyle: const QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.circle,
            color: AppColor.appContrast,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Click or Scan",
          style: const TextStyle(
            color: AppColor.white,
            fontSize: 14.0,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}