import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/router.dart';
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
    context.router.push(TournamentRoute(tournamentId: id));
  }
}
