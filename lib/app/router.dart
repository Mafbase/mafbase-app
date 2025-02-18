import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/feature/webview/web_view_screen.dart';
import 'package:seating_generator_web/ui/contacts/contacts_page.dart';
import 'package:seating_generator_web/ui/login/login_body/login_body.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_page.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_page.dart';
import 'package:seating_generator_web/ui/rail_wrapper/rail_wrapper.dart';
import 'package:seating_generator_web/ui/temp/temp_page.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_page.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_page.dart';
import 'package:seating_generator_web/utils/splash_manager.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppRouter {
  final String initLocation;
  late final router = GoRouter(
    observers: [
      SentryNavigatorObserver(),
    ],
    initialLocation: initLocation,
    redirect: (context, state) {
      return Future<String?>.microtask(() async {
        final authNotifier = context.read<AuthNotifier>();
        if (authNotifier.value is AuthNotifierLoadingModel) {
          try {
            final response = await getIt<MyHttpClient>().get("/api/auth");
            if (response.statusCode == 200) {
              final value = await getIt<CredentialStorage>().read();

              Sentry.configureScope(
                (p0) => p0.setUser(
                  SentryUser(email: value?.login),
                ),
              );

              authNotifier.value = AuthNotifierModel.authorized(
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
      TranslationContentPage.route,
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
          return BlocProvider(
            key: const Key("MainBlocProvider"),
            create: (context) => getIt.get<MainBloc>(
              param1: context,
              param2: state.uri.toString().startsWith('/club')
                  ? MainPageTab.clubs
                  : MainPageTab.tournaments,
            ),
            child: MainPage(child: child),
          );
        },
        routes: [
          RailWrapper.route,
          LoginPageBody.route,
          ProfilePage.route,
          ContactsPage.route,
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

  AppRouter(this.initLocation);

  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}

enum MainPageTab { clubs, tournaments }
