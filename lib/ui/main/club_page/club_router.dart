import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';

abstract class ClubRouter {
  void openRating({required int clubId});
}

class ClubRouterImpl implements ClubRouter {
  final BuildContext context;

  ClubRouterImpl(this.context);

  @override
  void openRating({required int clubId}) {
    context.go(
      RatingPage.createLocation(
        clubId: clubId,
        context: context,
      ),
    );
  }
}
