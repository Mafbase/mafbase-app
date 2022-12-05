import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/main/seating_page/widgets/separation_dialog.dart';
import 'package:seating_generator_web/utils.dart';

abstract class SeatingPageRouter {
  Future<Pair<PlayerModel, PlayerModel>?> openSeparationDialog({
    required List<PlayerModel> availablePlayers,
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
}
