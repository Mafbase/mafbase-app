import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_event.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/players_list_body.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/tournament_menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentPage extends StatefulWidget {
  final Widget child;

  const TournamentPage({Key? key, required this.child}) : super(key: key);

  @override
  State<TournamentPage> createState() => _TournamentPageState();

  static RouteBase createRoute() => ShellRoute(
        routes: [
          GoRoute(
            path: AppRoutes.tournamentPlayersListRoute,
            routes: [
              SeatingPage.route,
            ],
            builder: (context, state) {
              return PlayersListBody(
                tournamentId: int.parse(state.params["id"] ?? ""),
              );
            },
          )
        ],
        builder: (context, state, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TournamentPageBloc>(
                key: const Key("TournamentPageBloc"),
                create: (context) => getIt<TournamentPageBloc>(
                  param1: context,
                ),
              ),
              BlocProvider<SeatingPageBloc>(
                key: const Key("SeatingPageBloc"),
                create: (context) => getIt<SeatingPageBloc>(
                  param1: context,
                ),
              ),
            ],
            child: TournamentPage(child: child),
          );
        },
      );
}

class _TournamentPageState extends State<TournamentPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: widget.child),
        TournamentMenu(
          items: [
            MenuItemModel(
              text: context.locale.tournamentPageListOfPlayers,
              onTap: () {
                context
                    .read<TournamentPageBloc>()
                    .add(const TournamentPageEvent.playersListTapped());
              },
            ),
            MenuItemModel(
              text: AppLocalizations.of(context)!.addPlayer,
              onTap: () {
                context.read<TournamentPageBloc>().add(
                      const TournamentPageEvent.addPlayerTapped(),
                    );
              },
            ),
            MenuItemModel(
              text: context.locale.seating,
              onTap: () {
                context
                    .read<TournamentPageBloc>()
                    .add(const TournamentPageEvent.openSeatingPage());
              },
            ),
          ],
        ),
      ],
    );
  }
}
