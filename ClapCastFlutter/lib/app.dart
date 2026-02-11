import 'package:clapcastflutter/ressources/app_color.dart';
import 'package:clapcastflutter/ressources/app_theme.dart';
import 'package:clapcastflutter/search/domain/search_notifier.dart';
import 'package:clapcastflutter/search/presentation/search_screen.dart';
import 'package:clapcastflutter/starting/domain/starting_notifier.dart';
import 'package:clapcastflutter/starting/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard/presentation/dashboard_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StartingNotifier()),
        ChangeNotifierProvider(create: (context) => SearchNotifier()),
      ],
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) => const SplashScreen(),
          "/dashboard_screen": (context) => const DashboardScreen(),
          "/search_screen": (context) => const SearchScreen(),
        },
        title: 'Flutter Demo',
        theme: AppTheme.themeData,
      ),
    );
  }
}
