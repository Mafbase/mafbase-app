import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/ui/login/login_body/login_body.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';

abstract class AddClubGameRouter {
  void editPage(int clubId, int gameId);

  void openGame(int clubId, int gameId);

  void pop();

  void openNewGame(int clubId);

  void openLoginPage();
}

class AddClubGameRouterImpl implements AddClubGameRouter {
  final BuildContext context;

  AddClubGameRouterImpl(this.context);

  @override
  void editPage(int clubId, int gameId) {
    context.go(
      AddClubGamePage.createViewLocation(
        context,
        clubId,
        gameId,
        canEdit: true,
      ),
    );
  }

  @override
  void openGame(int clubId, int gameId) {
    context.go(
      AddClubGamePage.createViewLocation(
        context,
        clubId,
        gameId,
        canEdit: false,
      ),
    );
  }

  @override
  void openNewGame(int clubId) {
    context.go(AddClubGamePage.createLocation(context, clubId));
  }

  @override
  void openLoginPage() {
    context.go(
      LoginPageBody.createLocation(
        context: context,
        nextPath: GoRouter.of(context).location,
      ),
    );
  }

  @override
  void pop() {
    context.pop();
  }
}
