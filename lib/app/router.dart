import 'package:collection/collection.dart';
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
import 'package:seating_generator_web/ui/main/add_tournament/add_tournament_page.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_page.dart';
import 'package:seating_generator_web/ui/main/profile_settings/profile_settings_page.dart';
import 'package:seating_generator_web/ui/main/regulations_page/regulations_page.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_bloc.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_page.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_bloc.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_page.dart';

class AppRouter {
  final router = GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(
                key: const Key("LoginBlocProvider"),
                create: (context) => getIt.get<LoginBloc>(param1: context),
              ),
              BlocProvider<SignUpBloc>(
                key: const Key('SignUpBlocProvider'),
                create: (context) => getIt.get<SignUpBloc>(param1: context),
              )
            ],
            child: LoginPage(
              child: child,
            ),
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.loginPageRoute,
            pageBuilder: (context, state) => FadeTransitionPage(child: const LoginPageBody()),
          ),
          GoRoute(
            path: AppRoutes.signUpRoute,
            pageBuilder: (context, state) => FadeTransitionPage(child: const SignUpPageBody()),
          )
        ],
      ),
      GoRoute(
        path: AppRoutes.translationRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt.get<SeatingInsertingBloc>(param1: context),
          child: const SeatingInsertingPage(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<MainBloc>(
                key: const Key("MainBlocProvider"),
                create: (context) => getIt.get<MainBloc>(param1: context),
              ),
              BlocProvider<TournamentsBloc>(
                key: const Key("TournamentsBlocProvider"),
                create: (context) => getIt<TournamentsBloc>(param1: context),
              ),
            ],
            child: MainPage(
              tab: MainPageTab.values.firstWhereOrNull(
                (element) => state.location.contains(element.name),
              ),
              child: child,
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: TournamentsPage()),
            redirect: (context, state) async {
              try {
                final response = await getIt<MyHttpClient>().get("/api/auth");
                print(response.statusCode);
                if (response.statusCode == 200) {
                  return null;
                }
              } catch (_) {}
              return AppRoutes.loginPageRoute;
            },
          ),
          GoRoute(
            path: AppRoutes.routeFromTab(MainPageTab.addTournament),
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: AddTournamentPage()),
          ),
          GoRoute(
            path: AppRoutes.routeFromTab(MainPageTab.regulations),
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: RegulationsPage()),
          ),
          GoRoute(
            path: AppRoutes.routeFromTab(MainPageTab.profileSettings),
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfileSettingsPage()),
          ),
          TournamentPage.createRoute(),
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

class AppRoutes {
  AppRoutes._();

  static const loginPageRoute = '/login';
  static const translationRoute = '/translation';
  static const signUpRoute = '/signUp';
  static const tournamentPlayersListRoute = '/tournament/:id';

  static String tournamentPlayersListRouteWithId(int tournamentId) => '/tournament/$tournamentId';

  static String routeFromTab(MainPageTab tab) => "/${tab.name}";
}

enum MainPageTab { regulations, profileSettings, addTournament }
