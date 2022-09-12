import 'package:flutter/material.dart';

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    CurveTween curveTween = CurveTween(curve: Curves.easeIn);
    final tween =
        Tween(begin: const Offset(0.0, 0.0), end: const Offset(-1.0, 0.0))
            .chain(curveTween);
    return SlideTransition(
      position: animation.drive(tween),
    );
  }
}
