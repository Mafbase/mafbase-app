import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page.dart';
import 'package:seating_generator_web/ui/main/widgets/create_tournament_dialog.dart';

abstract class TournamentsRouter {
  Future<CreateTournamentData?> openCreateTournamentDialog();

  void openTournament(int id);
}

class TournamentsRouterImpl implements TournamentsRouter {
  final BuildContext context;

  TournamentsRouterImpl(this.context);

  @override
  Future<CreateTournamentData?> openCreateTournamentDialog() {
    return CreateTournamentDialog.open(context);
  }

  @override
  void openTournament(int id) {
    GoRouter.of(context).go(
      TournamentPage.createLocation(
        context: context,
        tournamentId: id,
      ),
    );
  }
}
