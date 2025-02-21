import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeTransitionPage extends CustomTransitionPage {
  FadeTransitionPage({required super.child})
      : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
