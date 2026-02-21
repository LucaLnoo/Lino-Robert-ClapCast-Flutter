import 'package:clapcastflutter/generated/assets.dart';
import 'package:clapcastflutter/ressources/app_color.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../ressources/app_dimens.dart';

class NavigationBarFooter extends StatelessWidget {
  final int selectedIndex;
  final Function(int) newDestinationSelected;

  const NavigationBarFooter({
    super.key,
    required this.selectedIndex,
    required this.newDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: newDestinationSelected,

        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(color: AppColor.appContrast, fontSize: AppText.medium_12),
        ),

        destinations: [
          NavigationDestination(
            icon: Image.asset(
              Assets.assetsIcMovie,
              width: AppIconSize.medium,
              height: AppIconSize.medium,
              color: AppColor.appContrast,
            ),
            selectedIcon: Image.asset(
              Assets.assetsIcMovie,
              width: AppIconSize.medium,
              height: AppIconSize.medium,
              color: AppColor.black,
            ),
            label: l10n.navExplore,
          ),

          NavigationDestination(
            icon: Image.asset(
              Assets.assetsIcActionKey,
              width: AppIconSize.medium,
              height: AppIconSize.medium,
              color: AppColor.appContrast,
            ),
            selectedIcon: Image.asset(
              Assets.assetsIcActionKey,
              width: AppIconSize.medium,
              height: AppIconSize.medium,
              color: AppColor.black,
            ),
            label: l10n.navSearch,
          )
        ],
        backgroundColor: AppColor.black,
        indicatorColor: AppColor.appContrast
    );
  }
}