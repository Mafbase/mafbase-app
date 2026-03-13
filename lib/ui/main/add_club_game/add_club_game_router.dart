import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/ui/login/login_body/login_body.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';

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
      context.replace(
        AddClubGamePage.createViewLocation(
          context,
          clubId,
          gameId,
          canEdit: true,
        ),
      );
    } else if (tournamentId != null) {
      context.replace(
        AddClubGamePage.createTournamentEditLocation(
          context: context,
          tournamentId: tournamentId,
          gameId: gameId,
          edit: true,
        ),
      );
    }
  }

  @override
  void openGame(int clubId, int gameId) {
    context.replace(
      AddClubGamePage.createViewLocation(
        context,
        clubId,
        gameId,
        canEdit: false,
      ),
    );
  }

  @override
  void openNewGame(int clubId, [DateTime? initDateTime]) {
    context.replace(
      AddClubGamePage.createLocation(context, clubId),
      extra: initDateTime,
    );
  }

  @override
  void openLoginPage() {
    context.go(
      LoginPageBody.createLocation(
        context: context,
        nextPath: GoRouter.of(context).routeInformationProvider.value.uri.toString(),
      ),
    );
  }

  @override
  void pop() {
    context.pop();
  }
}
