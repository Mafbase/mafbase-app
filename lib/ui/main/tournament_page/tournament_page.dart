import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_event.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/players_list_body.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/tournament_menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TournamentPage extends StatefulWidget {
  final Widget child;

  const TournamentPage({Key? key, required this.child}) : super(key: key);

  @override
  State<TournamentPage> createState() => _TournamentPageState();

  static GoRoute createRoute() => GoRoute(
    path: AppRoutes.tournamentPlayersListRoute,
    builder: (context, state) {
      final tournamentId = int.tryParse(state.params["id"] ?? "");
      if (tournamentId == null) {
        throw Exception("Invalid tournament id");
      }
      return BlocProvider<TournamentPageBloc>(
        key: Key("TournamentPageBloc$tournamentId"),
        create: (context) => getIt<TournamentPageBloc>(
          param1: context,
          param2: tournamentId,
        ),
        child: const TournamentPage(child: PlayersListBody()),
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
              text: AppLocalizations.of(context)!.addPlayer,
              onTap: () {
                context.read<TournamentPageBloc>().add(
                      const TournamentPageEvent.addPlayerTapped(),
                    );
              },
            ),
          ],
        ),
      ],
    );
  }
}
