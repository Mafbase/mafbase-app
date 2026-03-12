import 'package:flutter/material.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_page.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_page.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_drawer.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_router.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_router.dart';
import 'package:seating_generator_web/feature/administration_page/administration_page.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_effect.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/players_list_body.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_builder.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_page.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class TournamentPage extends StatefulWidget {
  final Widget child;
  final int tournamentId;

  const TournamentPage({
    super.key,
    required this.child,
    required this.tournamentId,
  });

  @override
  State<TournamentPage> createState() => _TournamentPageState();

  static String createLocation({
    required BuildContext context,
    required int tournamentId,
  }) {
    return context.namedLocation(
      "tournament_page",
      pathParameters: {
        "id": "$tournamentId",
      },
    );
  }

  static RouteBase createRoute() => ShellRoute(
        routes: [
          GoRoute(
            name: "tournament_page",
            path: "/tournament/:id",
            routes: [
              SeatingPage.route,
              SeatingInsertingPage.route,
              AddClubGamePage.tournamentEditRoute,
              RatingPage.tournamentRoute,
              AdministrationPage.tournamentRoute,
              FantasyPage.tournamentRoute,
              PhotoThemesPage.tournamentRoute,
            ],
            builder: (context, state) {
              return PlayersListBody(
                tournamentId: int.parse(state.pathParameters["id"] ?? ""),
              );
            },
          ),
        ],
        builder: (context, state, child) {
          final tournamentId = int.parse(state.pathParameters["id"] ?? "");
          return MultiBlocProvider(
            providers: [
              BlocProvider<TournamentPageBloc>(
                key: const Key("TournamentPageBloc"),
                create: (context) {
                  final repos = RepositoryFactory.of(context);
                  return TournamentPageBloc(
                    repos: repos,
                    router: TournamentPageRouterImpl(context),
                    tournamentId: tournamentId,
                    context: context,
                  )
                    ..add(const TournamentPageEvent.pageOpened())
                    ..add(const TournamentPageEvent.playersListOpened());
                },
              ),
              BlocProvider<SeatingPageBloc>(
                key: const Key("SeatingPageBloc"),
                create: (context) {
                  final repos = RepositoryFactory.of(context);
                  return SeatingPageBloc(
                    repos: repos,
                    router: SeatingPageRouterImpl(context),
                  )..add(
                      SeatingPageEvent.pageOpened(
                        tournamentId: tournamentId,
                      ),
                    );
                },
              ),
            ],
            child: TournamentPage(
              tournamentId: int.parse(state.pathParameters["id"] ?? ""),
              child: child,
            ),
          );
        },
      );
}

class _TournamentPageState extends CustomState<TournamentPage>
    with EffectListener<TournamentPageEffect, TournamentPageState, TournamentPageBloc, TournamentPage> {
  @override
  Widget? buildMobile(BuildContext context) {
    return Scaffold(
      endDrawer: TournamentMenuDrawer(tournamentId: widget.tournamentId),
      body: widget.child,
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return Row(
      children: [
        Expanded(child: widget.child),
        BlocBuilder<TournamentPageBloc, TournamentPageState>(
          builder: (context, state) {
            context.watch<SeatingPageBloc>();
            final sections = TournamentMenuBuilder.buildSections(
              context,
              state,
              widget.tournamentId,
            );
            return TournamentMenu(
              sections: sections,
            );
          },
        ),
      ],
    );
  }

  @override
  void registerEffectHandlers(Function<T>(EffectHandler<T> handler) on) {
    on<TournamentPageEffectUpdateSettingsSuccess>(onShowSuccessUpdate);
    super.registerEffectHandlers(on);
  }

  onShowSuccessUpdate(TournamentPageEffectUpdateSettingsSuccess effect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.locale.tournamentSettingsUpdateSuccess),
      ),
    );
  }
}
