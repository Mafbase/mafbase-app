import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/add_player_dialog.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/substitute_player_dialog.dart';
import 'package:seating_generator_web/ui/profile_dialog/profile_dialog.dart';

abstract class TournamentPageRouter {
  Future<PlayerModel?> showAddPlayerDialog();

  Future<bool> showPlayerProfileDialog({required PlayerModel player});

  void openSeatingPage({required int tournamentId});

  void openPlayersList({required int tournamentId});

  void openRating({required int tournamentId});

  void openWebView(String url);

  Future<({int newPlayerId, List<int> games})?> openSubstituteDialog({
    required PlayerModel oldPlayer,
    required List<int> gameNumbers,
  });
}

class TournamentPageRouterImpl implements TournamentPageRouter {
  final BuildContext _context;

  TournamentPageRouterImpl(this._context);

  @override
  Future<PlayerModel?> showAddPlayerDialog() async {
    return AddPlayerDialog.open(
      context: _context,
    );
  }

  @override
  Future<bool> showPlayerProfileDialog({required PlayerModel player}) {
    return ProfileDialog.open(_context, player).then((value) => value ?? false);
  }

  @override
  void openSeatingPage({required int tournamentId}) {
    _context.router.push(SeatingRoute(tournamentId: tournamentId));
  }

  @override
  void openPlayersList({required int tournamentId}) {
    _context.router.push(TournamentRoute(tournamentId: tournamentId));
  }

  @override
  void openRating({required int tournamentId}) {
    _context.router.push(TournamentRatingRoute(tournamentId: tournamentId));
  }

  @override
  Future<({int newPlayerId, List<int> games})?> openSubstituteDialog({
    required PlayerModel oldPlayer,
    required List<int> gameNumbers,
  }) {
    return SubstitutePlayerDialog.show(
      context: _context,
      oldPlayer: oldPlayer,
      gameNumbers: gameNumbers,
    );
  }

  @override
  void openWebView(String url) {
    _context.router.push(
      WebViewRoute(url: url, title: _context.locale.payment),
    );
  }
}
