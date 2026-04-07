import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

final rootNavigationKey = GlobalKey<NavigatorState>();

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    final navigatorContext = rootNavigationKey.currentContext;
    if (navigatorContext == null) return;

    try {
      if (error is RequestError) {
        AppRouter.showErrorDialog(
          navigatorContext,
          error.message ?? '',
        );
      } else if (error is UnauthenticatedError) {
        navigatorContext.router.pushNamed('/auth');

        AppRouter.showErrorDialog(
          navigatorContext,
          error.message ?? '',
        );
      } else {
        AppRouter.showErrorDialog(
          navigatorContext,
          navigatorContext.locale.unknownError(error.toString()),
        );
      }
    } catch (e) {
      debugPrint('Error showing error dialog: $e');
    }

    debugPrint(error.toString());
    debugPrint(stackTrace.toString());
    Sentry.captureException(error, stackTrace: stackTrace);
  }
}
