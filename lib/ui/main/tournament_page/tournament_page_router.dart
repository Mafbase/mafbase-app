import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/add_player_dialog.dart';

abstract class TournamentPageRouter {
  Future<PlayerModel?> showAddPlayerDialog({
    required List<PlayerModel> availablePlayers,
  });
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
    ).then((value) {
      debugPrint(value.toString());
      return value;
    });
  }
}
