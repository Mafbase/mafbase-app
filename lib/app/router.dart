import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/ui/login/login_page.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_page.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_page.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_bloc.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_page.dart';
import 'package:seating_generator_web/ui/temp/temp_page.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_page.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_page.dart';
import 'package:seating_generator_web/utils/splash_manager.dart';

class AppRouter {
  final String initLocation;
  late final router = GoRouter(
    initialLocation: initLocation,
    redirect: (context, state) {
      return Future<String?>.microtask(() async {
        final authNotifier = context.read<AuthNotifier>();
        if (authNotifier.value is AuthNotifierLoadingModel) {
          try {
            final response = await getIt<MyHttpClient>().get("/api/auth");
            if (response.statusCode == 200) {
              authNotifier.value = const AuthNotifierModel.authorized();
            }
          } catch (_) {
            authNotifier.value = const AuthNotifierModel.unauthorized();
          }
          return null;
        }
        return null;
      }).then((value) {
        return value;
      }).whenComplete(() => SplashManager.removeSplash());
    },
    routes: [
      TempPage.route,
      TranslationContentPage.route,
      TranslationControlPage.route,
      GoRoute(
        path: '/',
        redirect: (_, state) => state.location == '/' ? '/club' : null,
        builder: (context, state) => const Placeholder(),
        routes: [
          LoginPage.route,
          ShellRoute(
            builder: (context, state, child) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<MainBloc>(
                    key: const Key("MainBlocProvider"),
                    create: (context) => getIt.get<MainBloc>(
                      param1: context,
                      param2: state.location.startsWith('/club')
                          ? MainPageTab.clubs
                          : MainPageTab.tournaments,
                    ),
                  ),
                  BlocProvider<TournamentsBloc>(
                    key: const Key("TournamentsBlocProvider"),
                    create: (context) =>
                        getIt<TournamentsBloc>(param1: context),
                  ),
                ],
                child: MainPage(child: child),
              );
            },
            routes: [
              TournamentsPage.route,
              ClubsPage.route,
            ],
          ),
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
