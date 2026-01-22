import 'package:clapcastflutter/ressources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:clapcastflutter/dashboard/presentation/dashboard_screen.dart';

import '../../generated/assets.dart';
import '../../ressources/app_dimens.dart';

// Navigation Handler
class NavigationBarHandler extends StatefulWidget {
  const NavigationBarHandler({super.key});

  @override
  State<NavigationBarHandler> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<NavigationBarHandler> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const Center(child: Text("Page Search")),
    const Center(child: Text("Page Favorite")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBarFooter(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// UI - Navigation Bar
class NavigationBarFooter extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const NavigationBarFooter({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,

      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(color: AppColor.appContrast, fontSize: AppText.medium_12),
      ),

      destinations: [
        NavigationDestination(
          icon: Image.asset(
            Assets.assetsIcMovie,
            width: AppImageSize.medium,
            height: AppImageSize.medium,
            color: AppColor.appContrast,
          ),

          selectedIcon: Image.asset(
            Assets.assetsIcMovie,
            width: AppImageSize.medium,
            height: AppImageSize.medium,
            color: AppColor.black,
          ),

          label: 'Explore',
        ),

        NavigationDestination(
          icon: Image.asset(
            Assets.assetsIcActionKey,
            width: AppImageSize.medium,
            height: AppImageSize.medium,
            color: AppColor.appContrast,
          ),

          selectedIcon: Image.asset(
            Assets.assetsIcSearch,
            width: AppImageSize.medium,
            height: AppImageSize.medium,
            color: AppColor.black,
          ),

          label: 'Search',
        ),

        NavigationDestination(
          icon: Image.asset(
            Assets.assetsIcStarShine,
            width: AppImageSize.medium,
            height: AppImageSize.medium,
            color: AppColor.appContrast,
          ),

          selectedIcon: Image.asset(
            Assets.assetsIcStarShine,
            width: AppImageSize.medium,
            height: AppImageSize.medium,
            color: AppColor.black,
          ),

          label: 'Favorite',
        )

      ],
        backgroundColor: AppColor.black,
        indicatorColor: AppColor.appContrast
    );
  }
}