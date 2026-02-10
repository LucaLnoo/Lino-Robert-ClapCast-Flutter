import 'package:flutter/material.dart';

import 'navigation_bar.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const BaseLayout({
    super.key,
    required this.child,
    required this.currentIndex
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard_screen');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/search_screen');
        break;
      default:
        Navigator.pushReplacementNamed(context, '/dashboard_screen');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBarFooter(
        selectedIndex: currentIndex,
        newDestinationSelected: (index) => _onItemTapped(context, index),
      ),
    );
  }
}