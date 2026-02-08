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
