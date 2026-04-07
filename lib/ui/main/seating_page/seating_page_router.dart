import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/main/seating_page/widgets/separation_dialog.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';

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
    return context.router.push(
      AddClubGameRoute(
        tournamentId: tournamentId,
        gameId: gameId,
        editParam: context.read<TournamentPageBloc>().state.isMyTournament,
      ),
    );
  }
}
