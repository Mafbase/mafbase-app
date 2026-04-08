import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/router.dart';

abstract class AddClubGameRouter {
  void editPage(int? clubId, int? tournamentId, int gameId);

  void openGame(int clubId, int gameId);

  void pop();

  void openNewGame(int clubId, [DateTime? initDateTime]);

  void openLoginPage();
}

class AddClubGameRouterImpl implements AddClubGameRouter {
  final BuildContext context;

  AddClubGameRouterImpl(this.context);

  @override
  void editPage(int? clubId, int? tournamentId, int gameId) {
    if (clubId != null) {
      context.router.replace(
        ClubGameDetailRoute(clubId: clubId, gameId: gameId, editParam: true),
      );
    } else if (tournamentId != null) {
      context.router.replace(
        TournamentGameDetailRoute(tournamentId: tournamentId, gameId: gameId, editParam: true),
      );
    }
  }

  @override
  void openGame(int clubId, int gameId) {
    context.router.replace(
      ClubGameDetailRoute(clubId: clubId, gameId: gameId, editParam: false),
    );
  }

  @override
  void openNewGame(int clubId, [DateTime? initDateTime]) {
    context.router.replace(
      NewClubGameRoute(clubId: clubId, initDateTime: initDateTime),
    );
  }

  @override
  void openLoginPage() {
    context.router.push(const LoginPageRoute());
  }

  @override
  void pop() {
    context.router.pop();
  }
}
