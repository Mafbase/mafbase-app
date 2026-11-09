import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/ui/main/widgets/create_tournament_dialog.dart';

abstract class TournamentsRouter {
  Future<CreateTournamentData?> openCreateTournamentDialog();

  /// [setup] — турнир только что создан: страница покажет мастер настройки.
  void openTournament(int id, {bool setup = false});
}

class TournamentsRouterImpl implements TournamentsRouter {
  final BuildContext context;

  TournamentsRouterImpl(this.context);

  @override
  Future<CreateTournamentData?> openCreateTournamentDialog() {
    return CreateTournamentDialog.open(context);
  }

  @override
  void openTournament(int id, {bool setup = false}) {
    context.router.push(TournamentRoute(tournamentId: id, setup: setup ? 1 : null));
  }
}
