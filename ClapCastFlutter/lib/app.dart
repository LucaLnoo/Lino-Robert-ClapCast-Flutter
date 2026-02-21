import 'package:clapcastflutter/detailed/domain/detailed_notifier.dart';
import 'package:clapcastflutter/ressources/app_color.dart';
import 'package:clapcastflutter/ressources/app_theme.dart';
import 'package:clapcastflutter/search/domain/search_notifier.dart';
import 'package:clapcastflutter/search/presentation/category_screen.dart';
import 'package:clapcastflutter/search/presentation/search_screen.dart';
import 'package:clapcastflutter/starting/domain/starting_notifier.dart';
import 'package:clapcastflutter/starting/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'dashboard/presentation/dashboard_screen.dart';
import 'detailed/presentation/detailed_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StartingNotifier()),
        ChangeNotifierProvider(create: (context) => SearchNotifier()),
        ChangeNotifierProvider(create: (context) => DetailedNotifier()),

      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate, // Nos traductions
          GlobalMaterialLocalizations.delegate, // Traduit les éléments de base d'Android
          GlobalWidgetsLocalizations.delegate, // Gère le sens de lecture (gauche à droite)
          GlobalCupertinoLocalizations.delegate, // Traduit les éléments de base d'iOS
        ],
        supportedLocales: const [
          Locale('en', ''), // Anglais (par défaut)
          Locale('fr', ''), // Français
        ],
        initialRoute: "/",
        routes: {
          "/": (context) => const SplashScreen(),
          "/dashboard_screen": (context) => const DashboardScreen(),
          "/search_screen": (context) => const SearchScreen(),
          "/category_screen": (context) => const CategoryScreen(people: [], movies: [], categoryTitle: '',),
          "/detail_screen": (context) => const DetailedScreen(),
        },
        title: 'ClapCast',
        theme: AppTheme.themeData,
      ),
    );
  }
}
