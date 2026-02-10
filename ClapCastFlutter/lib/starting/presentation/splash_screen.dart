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
    final startingNotifier = context.watch<StartingNotifier>();
    final movies = startingNotifier.movies;
    final people = startingNotifier.people;

    if (movies != null && people != null) {

      WidgetsBinding.instance.addPostFrameCallback((_) {
        // pushReplacementNamed pour qu'on ne puisse pas revenir au Splash avec "Retour"
        Navigator.of(context).pushReplacementNamed("/dashboard_screen");
      });
    }

    return AppLoginBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      )
    );
  }
}