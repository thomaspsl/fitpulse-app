// lib/transitions.dart
import 'package:flutter/material.dart';

Widget bookTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    Widget exit,
    double x) {
  return Stack(
    children: <Widget>[
      SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0),
          end: Offset(-x, 0),
        ).animate(animation),
        child: exit,
      ),
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset(x, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    ],
  );
}
