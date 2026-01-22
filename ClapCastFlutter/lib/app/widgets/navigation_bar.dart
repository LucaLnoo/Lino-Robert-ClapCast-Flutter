import 'package:clapcastflutter/ressources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:clapcastflutter/dashboard/presentation/dashboard_screen.dart';

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
    const Center(child: Text("Page Profile")),
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

      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.movie, color: AppColor.appContrast),
            label: 'Explore',
            selectedIcon: Icon(Icons.movie, color: Colors.black),
        ),
        NavigationDestination(
            icon: Icon(Icons.manage_search, color: AppColor.appContrast),
            label: 'Search',
            selectedIcon: Icon(Icons.manage_search, color: Colors.black),
        ),
        NavigationDestination(
            icon: Icon(Icons.star, color: AppColor.appContrast),
            label: 'Favorite',
            selectedIcon: Icon(Icons.star, color: Colors.black),
        ),
        NavigationDestination(
            icon: Icon(Icons.person, color: AppColor.appContrast),
            label: 'Profile',
            selectedIcon: Icon(Icons.person, color: Colors.black),
        ),
      ],
        backgroundColor: AppColor.black,
        indicatorColor: AppColor.appContrast
    );
  }
}