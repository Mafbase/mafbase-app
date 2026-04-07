import 'package:flutter/material.dart';

/// A page that fades in. Currently unused after auto_route migration.
class FadeTransitionPage extends Page<void> {
  final Widget child;

  const FadeTransitionPage({required this.child});

  @override
  Route<void> createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
