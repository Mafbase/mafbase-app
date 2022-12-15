import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';
import 'package:seating_generator_web/ui/main/rating_page/widgets/rating_table.dart';

abstract class RatingRouter {
  void changeRange(DateTimeRange range, int clubId,RatingTableStyle style);

  void openGame(int clubId, int gameId);
}

class RatingRouterImpl implements RatingRouter {
  final BuildContext context;

  RatingRouterImpl(this.context);

  @override
  void changeRange(DateTimeRange range, int clubId, RatingTableStyle style) {
    final location = RatingPage.createLocation(
      range: range,
      clubId: clubId,
      context: context,
      tableStyle: style,
    );
    context.go(location);
  }

  @override
  void openGame(int clubId, int gameId) {
    context.go(AddClubGamePage.createViewLocation(context, clubId, gameId));
  }
}
