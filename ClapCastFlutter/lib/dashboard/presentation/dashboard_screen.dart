import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/widgets/base_layout.dart';
import '../../generated/assets.dart';
import '../../ressources/app_dimens.dart';
import '../../ressources/app_color.dart';
import '../domain/dashboard_notifier.dart';
import '../../app/widgets/background.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Wait a frame to call data fetchings
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardNotifier>().getMovies();
      context.read<DashboardNotifier>().getPeople();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeNotifier = context.watch<DashboardNotifier>();
    final movies = homeNotifier.movies;
    final people = homeNotifier.people;
    var name = homeNotifier.name;

    return BaseLayout(
      currentIndex: 0,
      child: AppMenuBackground(
        child: SafeArea(
          child: Column(
            children: [
              Image.asset(Assets.assetsIcLogo),
              Text("Welcome to dashboard screen, i'm $name"),
              FilledButton(
                onPressed: homeNotifier.changeName,
                child: const Text("changer le nom"),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white.withOpacity(0.8),
                child: Column(
                  children: [
                    Text(
                      "First Movie : ${movies?.isNotEmpty == true ? movies!.first.title : 'No movie data'}",
                      style: const TextStyle(color: Colors.black),
                    ),
                    Text(
                      "Actor : ${people?.isNotEmpty == true ? people!.first.name : 'No actor data'}",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}