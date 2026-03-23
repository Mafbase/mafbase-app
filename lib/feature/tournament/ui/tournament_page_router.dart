import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/webview/web_view_screen.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/add_player_dialog.dart';
import 'package:seating_generator_web/ui/profile_dialog/profile_dialog.dart';

abstract class TournamentPageRouter {
  Future<PlayerModel?> showAddPlayerDialog();

  Future<bool> showPlayerProfileDialog({required PlayerModel player});

  void openSeatingPage({required int tournamentId});

  void openPlayersList({required int tournamentId});

  void openRating({required int tournamentId});

  void openWebView(String url);
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
    _context.pushReplacement(
      SeatingPage.createLocation(
        tournamentId: tournamentId,
        context: _context,
      ),
    );
  }

  @override
  void openPlayersList({required int tournamentId}) {
    _context.pushReplacement(
      TournamentPage.createLocation(
        context: _context,
        tournamentId: tournamentId,
      ),
    );
  }

  @override
  void openRating({required int tournamentId}) {
    _context.pushReplacement(
      RatingPage.createTournamentLocation(
        tournamentId: tournamentId,
        context: _context,
      ),
    );
  }

  @override
  void openWebView(String url) {
    _context.push(
      WebViewScreen.createLocation(
        url: url,
        title: _context.locale.payment,
        context: _context,
      ),
    );
  }
}
