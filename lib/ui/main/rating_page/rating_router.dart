import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';

abstract class RatingRouter {
  void changeRange(DateTimeRange range, int clubId);
}

class RatingRouterImpl implements RatingRouter {
  final BuildContext context;

  RatingRouterImpl(this.context);

  @override
  void changeRange(DateTimeRange range, int clubId) {
    final location = RatingPage.createLocation(
      range: range,
      clubId: clubId,
      context: context,
    );
    context.go(location);
  }
}
