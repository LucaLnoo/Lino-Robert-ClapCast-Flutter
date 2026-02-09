import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/widgets/background.dart';
import '../domain/starting_notifier.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState()
  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      context.read<StartingNotifier>().fetchAllMovies();
      context.read<StartingNotifier>().fetchAllPeople();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeNotifier = context.watch<StartingNotifier>();
    final movies = homeNotifier.movies;
    final people = homeNotifier.people;

    return AppMenuBackground(
      child: Scaffold()
    );
  }
}