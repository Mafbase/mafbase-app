import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/utils/splash_manager.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthNotifier _authNotifier;

  AuthGuard(this._authNotifier);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // Wait for auth state to initialize (removes splash)
    if (_authNotifier.value is AuthNotifierLoadingModel) {
      final completer = Completer<void>();

      void listener() {
        if (_authNotifier.value is! AuthNotifierLoadingModel) {
          completer.complete();
        }
      }

      _authNotifier.addListener(listener);
      await completer.future;
      _authNotifier.removeListener(listener);
    }

    // Mirrors the .whenComplete(() => SplashManager.removeSplash()) from router.dart
    SplashManager.removeSplash();

    // Always allow navigation — no redirects
    resolver.next(true);
  }
}
