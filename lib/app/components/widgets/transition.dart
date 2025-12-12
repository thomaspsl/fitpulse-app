import 'package:flutter/material.dart';

class Transition extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;
  final Widget exit;
  final double x;

  const Transition({
    super.key,
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
    required this.exit,
    required this.x
  });

  @override
  Widget build(BuildContext context) {
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
}
