import 'package:flutter/material.dart';
import '../../ressources/app_color.dart';

class AppMenuBackground extends StatelessWidget{
  final Widget child;

  const AppMenuBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColor.appBackground,
      child: child
    );
  }
}

class AppLoginBackground extends StatelessWidget{
  final Widget child;

  const AppLoginBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,

          colors: [
            AppColor.btnPrimary,
            AppColor.appBackground,
            AppColor.appBackground,
          ],
          stops: [0.0, 0.27, 1.0],
        ),
      ),
      child: child,
    );
  }
}