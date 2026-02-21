import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/assets.dart';
import '../../ressources/app_color.dart';

class QrCodeClapCast extends StatelessWidget {
  final String url;
  const QrCodeClapCast({super.key, required this.url});

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Cannot launch this url : $url");
    }
  }

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(

      onTap: (){
        debugPrint("Opening : $url");
        _launchURL();
      },
      child: Column(
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
            l10n.clickOrScan,
            style: const TextStyle(
              color: AppColor.white,
              fontSize: 14.0,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      )
    );
  }
}