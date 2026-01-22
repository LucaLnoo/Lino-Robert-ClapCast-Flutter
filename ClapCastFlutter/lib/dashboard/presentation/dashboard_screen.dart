import 'package:clapcastflutter/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    });
  }

  @override
  Widget build(BuildContext context) {

    final homeNotifier = context.watch<DashboardNotifier>();
    final movies = homeNotifier.movies;
    var name = homeNotifier.name;

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Image.asset(Assets.assetsIcLogo),
              Text("Welcome to dashboard screen, i'm $name"),
              FilledButton(
                  onPressed: homeNotifier.changeName,
                  child: Text("changer le nom")
              ),
            ],
          ),
          bottomNavigationBar: Text(movies?.first.title ?? "no name"),
        )
    );
  }
}