import 'package:auto_route/auto_route.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/utils/splash_manager.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthNotifier _authNotifier;
  final DependencyScope _scope;

  AuthGuard(this._authNotifier, this._scope);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // Bootstrap auth state on first navigation
    print('test25: start auth guard');
    if (_authNotifier.value is AuthNotifierLoadingModel) {
      try {
        final authRepository = _scope.repositoryFactory.authRepository;
        final pushTokenService = _scope.serviceProvider.pushTokenService;

        final fcmToken = await pushTokenService.getFcmToken();
        final deviceId = await pushTokenService.getDeviceId();

        final userId = await authRepository.auth(
          pushToken: fcmToken,
          deviceId: deviceId,
        );

        if (userId != null) {
          final value = await _scope.storageFactory.credentialStorage.read();

          Sentry.configureScope(
            (p0) => p0.setUser(SentryUser(email: value?.login)),
          );

          _authNotifier.value = AuthNotifierModel.authorized(
            userId: userId,
            hideBilling: LoginInteractor.hideBillEmails.contains(value?.login),
          );
        } else {
          _authNotifier.value = const AuthNotifierModel.unauthorized();
        }
      } catch (_) {
        _authNotifier.value = const AuthNotifierModel.unauthorized();
      }
    }

    print('test25: removeSplash');

    SplashManager.removeSplash();

    // Always allow navigation — no redirects
    resolver.next(true);
  }
}
