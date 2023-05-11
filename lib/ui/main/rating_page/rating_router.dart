import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';
import 'package:seating_generator_web/ui/main/rating_page/widgets/rating_table.dart';

abstract class RatingRouter {
  void changeRange(
    DateTimeRange range,
    int? clubId,
    int? tournamentId,
    RatingTableStyle style,
    RatingSort sort,
    int gameFilter,
  );

  void openGame(int clubId, int gameId);
}

class RatingRouterImpl implements RatingRouter {
  final BuildContext context;

  RatingRouterImpl(this.context);

  @override
  void changeRange(
    DateTimeRange range,
    int? clubId,
    int? tournamentId,
    RatingTableStyle style,
    RatingSort sort,
    int gameFilter,
  ) {
    final String location;
    if (clubId != null) {
      location = RatingPage.createClubLocation(
        range: range,
        clubId: clubId,
        context: context,
        tableStyle: style,
        sort: sort,
        gameFilter: gameFilter,
      );
    } else if (tournamentId != null) {
      location = RatingPage.createTournamentLocation(
        context: context,
        tableStyle: style,
        sort: sort,
        tournamentId: tournamentId,
      );
    } else {
      throw ArgumentError();
    }
    context.go(location);
  }

  @override
  void openGame(int clubId, int gameId) {
    context.push(AddClubGamePage.createViewLocation(context, clubId, gameId));
  }
}
