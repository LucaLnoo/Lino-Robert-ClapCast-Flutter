import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeClapCast extends StatelessWidget {
  final String url;
  const QrCodeClapCast({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: url,
      version: QrVersions.auto,
      size: 200.0,
      backgroundColor: Colors.white,
    );
  }
}