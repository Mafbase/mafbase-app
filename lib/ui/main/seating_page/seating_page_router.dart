import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/ui/main/seating_page/widgets/separation_dialog.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_page.dart';
import 'package:seating_generator_web/utils.dart';

abstract class SeatingPageRouter {
  Future<Pair<PlayerModel, PlayerModel>?> openSeparationDialog({
    required List<PlayerModel> availablePlayers,
  });

  void openFsmSeatingPage({required int id});

  Future openGameEditing({
    required int gameId,
    required int tournamentId,
  });
}

class SeatingPageRouterImpl implements SeatingPageRouter {
  final BuildContext context;

  SeatingPageRouterImpl(this.context);

  @override
  Future<Pair<PlayerModel, PlayerModel>?> openSeparationDialog({
    required List<PlayerModel> availablePlayers,
  }) {
    return SeparationDialog.open(context, availablePlayers);
  }

  @override
  void openFsmSeatingPage({required int id}) {
    context.go(SeatingInsertingPage.createLocation(context, id));
  }

  @override
  Future openGameEditing({
    required int gameId,
    required int tournamentId,
  }) {
    return context.push(
      AddClubGamePage.createTournamentEditLocation(
        context: context,
        tournamentId: tournamentId,
        gameId: gameId,
        edit: context.read<TournamentPageBloc>().state.isMyTournament,
      ),
    );
  }
}
