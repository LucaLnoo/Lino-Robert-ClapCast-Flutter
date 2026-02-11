import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/widgets/background.dart';
import '../../generated/assets.dart';
import '../../ressources/app_dimens.dart';
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

        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: AppDimension.xlarge),

                  Padding(
                    padding: const EdgeInsets.all(AppDimension.xlarge),
                    child: Image.asset(
                      Assets.assetsIcLoginLogo,
                      width: 300,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const Spacer(),

                  Image.asset(
                    Assets.assetsLoaderClapCast,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}