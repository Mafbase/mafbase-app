import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/login/login_page.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_page.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_bloc.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_page.dart';

class AppRouter {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.loginPageRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt.get<LoginBloc>(param1: context),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.translationRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt.get<SeatingInsertingBloc>(param1: context),
          child: const SeatingInsertingPage(),
        ),
      ),
      GoRoute(
        path: '/',
        routes: [
          GoRoute(
            path: AppRoutes.mainPageTabRoute,
            pageBuilder: (context, state) {
              final tab = MainPageTab.values.firstWhere(
                (element) => element.name == state.params["tab"],
              );
              return NoTransitionPage(
                child: BlocProvider(
                  create: (context) => getIt.get<MainBloc>(param1: context),
                  child: MainPage(
                    tab: tab,
                  ),
                ),
              );
            },
          ),
        ],
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: BlocProvider(
              create: (context) => getIt.get<MainBloc>(param1: context),
              child: const MainPage(),
            ),
          );
        },
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
}

class AppRoutes {
  AppRoutes._();

  static const loginPageRoute = '/login';
  static const translationRoute = '/translation';
  static const mainPageTabRoute = ':tab';
}

enum MainPageTab { regulations, profileSettings, addTournament }
