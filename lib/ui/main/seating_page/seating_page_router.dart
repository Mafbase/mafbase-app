import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/ui/main/seating_page/widgets/separation_dialog.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/utils.dart';

abstract class SeatingPageRouter {
  Future<Pair<PlayerModel, PlayerModel>?> openSeparationDialog({
    required List<PlayerModel> availablePlayers,
  });

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
