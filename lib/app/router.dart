import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/feature/webview/web_view_screen.dart';
import 'package:seating_generator_web/ui/contacts/contacts_page.dart';
import 'package:seating_generator_web/ui/login/login_body/login_body.dart';
import 'package:seating_generator_web/ui/main/club_page/club_page.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/app_shell/app_shell.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_bloc.dart';
import 'package:seating_generator_web/domain/interactors/logout_interactor.dart';
import 'package:seating_generator_web/domain/interactors/create_player_interactor.dart';
import 'package:seating_generator_web/feature/profile/domain/interactor/delete_profile_interactor.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_page.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_page.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page.dart';
import 'package:seating_generator_web/ui/rail_wrapper/rail_wrapper.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_page.dart';
import 'package:seating_generator_web/ui/temp/temp_page.dart';
import 'package:seating_generator_web/app/bloc_observer.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_page.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/splash_manager.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppRouter {
  final String initLocation;
  final DependencyScope scope;
  late final router = GoRouter(
    navigatorKey: rootNavigationKey,
    observers: [
      SentryNavigatorObserver(),
    ],
    initialLocation: initLocation,
    redirect: (context, state) {
      return Future<String?>.microtask(() async {
        if (!context.mounted) return null;

        final authNotifier = context.read<AuthNotifier>();
        if (authNotifier.value is AuthNotifierLoadingModel) {
          try {
            final authRepository = scope.repositoryFactory.authRepository;
            final pushTokenService = scope.serviceProvider.pushTokenService;

            // Получаем FCM токен и deviceId если разрешение уже выдано
            final fcmToken = await pushTokenService.getFcmToken();
            final deviceId = await pushTokenService.getDeviceId();

            final userId = await authRepository.auth(
              pushToken: fcmToken,
              deviceId: deviceId,
            );

            if (userId != null) {
              final value = await scope.storageFactory.credentialStorage.read();

              Sentry.configureScope(
                (p0) => p0.setUser(
                  SentryUser(email: value?.login),
                ),
              );

              authNotifier.value = AuthNotifierModel.authorized(
                userId: userId,
                hideBilling: LoginInteractor.hideBillEmails.contains(
                  value?.login,
                ),
              );
            } else {
              authNotifier.value = const AuthNotifierModel.unauthorized();
            }
          } catch (_) {
            authNotifier.value = const AuthNotifierModel.unauthorized();
          }
        }
        return null;
      }).whenComplete(() => SplashManager.removeSplash());
    },
    routes: [
      TempPage.route,
      TranslationControlPage.route,
      WebViewScreen.route,
      GoRoute(
        path: '/',
        redirect: (_, state) {
          if (state.uri.hasFragment) {
            return state.uri.fragment;
          }

          return '/club';
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                key: const Key("MainBlocProvider"),
                create: (context) => MainBloc(
                  MainPageRouterImpl(context),
                ),
              ),
              BlocProvider<ProfileBloc>(
                create: (context) {
                  final scope = DependencyScope.of(context);
                  final logoutInteractor = LogoutInteractor(
                    scope.storageFactory.tokenStorage,
                    scope.authNotifier,
                    scope.storageFactory.credentialStorage,
                  );
                  return ProfileBloc(
                    logoutInteractor,
                    DeleteProfileInteractor(
                      logoutInteractor,
                      scope.repositoryFactory.profileRepository,
                    ),
                    scope.repositoryFactory.profileRepository,
                    CreatePlayerInteractor(scope.repositoryFactory.playersRepository),
                    scope.authNotifier,
                  );
                },
              ),
            ],
            child: AppShell(child: child),
          );
        },
        routes: [
          TournamentPage.createRoute(),
          ClubPage.route,
          RailWrapper.route,
          LoginPageBody.route,
          ProfilePage.route,
          ContactsPage.route,
          PlayerStatsPage.route,
          PhotoThemesPage.profileRoute,
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Text(
            "errorRoute: ${state.toString()}",
          ),
        ),
      );
    },
  );

  AppRouter(this.initLocation, this.scope);

  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.locale.error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(context.locale.cancel),
          ),
        ],
      ),
    );
  }
}

enum MainPageTab { clubs, tournaments }
