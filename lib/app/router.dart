import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/widgets/fade_transition_page.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/login/login_body/login_body.dart';
import 'package:seating_generator_web/ui/login/login_page.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_bloc.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_page_body.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_page_body.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/ui/main/add_tournament/add_tournament_page.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_page.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_page.dart';
import 'package:seating_generator_web/ui/main/profile_settings/profile_settings_page.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';
import 'package:seating_generator_web/ui/main/regulations_page/regulations_page.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_bloc.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_page.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_page.dart';
import 'package:seating_generator_web/ui/temp/temp_page.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_page.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_page.dart';

class AppRouter {
  final router = GoRouter(
    redirect: (context, state) async {
      if (!state.location.endsWith('/')) {
        return null;
      }
      try {
        final response = await getIt<MyHttpClient>().get("/api/auth");
        if (response.statusCode == 200) {
          return null;
        }
      } catch (_) {}
      return '/login';
    },
    routes: [
      TempPage.route,
      TranslationContentPage.route,
      TranslationControlPage.route,
      GoRoute(
        path: '/',
        redirect: (_, state) => state.location == '/' ? '/tournament' : null,
        builder: (context, state) => const Placeholder(),
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final height = max(constraints.maxHeight, 720.0);
                  final width = max(constraints.maxWidth, 1280.0);
                  final mainChild = Container(
                    constraints: BoxConstraints(
                      maxWidth: width,
                      maxHeight: height,
                    ),
                    child: child,
                  );
                  if (defaultTargetPlatform == TargetPlatform.android ||
                      defaultTargetPlatform == TargetPlatform.iOS) {
                    return InteractiveViewer(
                      constrained: false,
                      minScale: 0.5,
                      child: mainChild,
                    );
                  }
                  return SingleChildScrollView(
                    primary: true,
                    physics: const ClampingScrollPhysics(),
                    child: SingleChildScrollView(
                      primary: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: mainChild,
                    ),
                  );
                },
              );
            },
            routes: [
              LoginPage.route,
              ShellRoute(
                builder: (context, state, child) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<MainBloc>(
                        key: const Key("MainBlocProvider"),
                        create: (context) =>
                            getIt.get<MainBloc>(param1: context),
                      ),
                      BlocProvider<TournamentsBloc>(
                        key: const Key("TournamentsBlocProvider"),
                        create: (context) =>
                            getIt<TournamentsBloc>(param1: context),
                      ),
                    ],
                    child: MainPage(
                      hasBackButton: !state.location.endsWith('/'),
                      child: child,
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'tournament',
                    routes: [
                      TournamentPage.createRoute(),
                    ],
                    pageBuilder: (context, state) => const NoTransitionPage(
                      child: TournamentsPage(),
                    ),
                  ),
                  ClubsPage.route,
                ],
              ),
            ],
          )
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

  AppRouter();

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
