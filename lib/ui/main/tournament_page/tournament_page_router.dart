import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/add_player_dialog.dart';
import 'package:seating_generator_web/ui/profile_dialog/profile_dialog.dart';

abstract class TournamentPageRouter {
  Future<PlayerModel?> showAddPlayerDialog({
    required List<PlayerModel> availablePlayers,
  });

  Future<bool> showPlayerProfileDialog({required PlayerModel player});

  void openSeatingPage({required int tournamentId});

  void openPlayersList({required int tournamentId});
}

class TournamentPageRouterImpl implements TournamentPageRouter {
  final BuildContext _context;

  TournamentPageRouterImpl(this._context);

  @override
  Future<PlayerModel?> showAddPlayerDialog({
    required List<PlayerModel> availablePlayers,
  }) async {
    return AddPlayerDialog.open(
      context: _context,
      availablePlayers: availablePlayers,
    );
  }

  @override
  Future<bool> showPlayerProfileDialog({required PlayerModel player}) {
    return ProfileDialog.open(_context, player).then((value) => value ?? false);
  }

  @override
  void openSeatingPage({required int tournamentId}) {
    _context.go(
      SeatingPage.createLocation(
        tournamentId: tournamentId,
        context: _context,
      ),
    );
  }

  @override
  void openPlayersList({required int tournamentId}) {
    _context.go(AppRoutes.tournamentPlayersListRouteWithId(tournamentId));
  }
}
