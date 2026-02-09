import 'package:clapcastflutter/generated/assets.dart';
import 'package:clapcastflutter/ressources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/widgets/background.dart';
import '../../ressources/app_dimens.dart';
import '../domain/dashboard_notifier.dart';

class DashboardScreen extends StatefulWidget{
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState()
  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
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

    return AppMenuBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: SafeArea(
          child: Column(
            children: [
              Image.asset(Assets.assetsIcLogo),
              Text("Welcome to dashboard screen, i'm $name"),
              FilledButton(
                  onPressed: homeNotifier.changeName,
                  child: const Text("changer le nom")
              ),
            ],
          ),
        ),

        bottomNavigationBar:
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "First Movie : ${movies?.isNotEmpty == true ? movies!.first.title : 'No movie data'}",
                  style: TextStyle(
                    color: AppColor.appContrast,
                    fontSize: AppText.medium_12,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Actor : ${people?.isNotEmpty == true ? people!.first.name : 'No actor data'}",
                  style: TextStyle(
                    color: AppColor.appContrast,
                    fontSize: AppText.medium_12,
                  ),
                ),
              ],
            )
      ),
    );
  }
}