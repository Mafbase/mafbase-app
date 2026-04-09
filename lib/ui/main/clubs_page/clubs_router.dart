import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';

abstract class ClubsRouter {
  void openClubPage({required int id, ClubModel? cachedModel});
}

class ClubsRouterImpl implements ClubsRouter {
  final BuildContext context;

  ClubsRouterImpl(this.context);

  @override
  void openClubPage({required int id, ClubModel? cachedModel}) {
    context.router.push(ClubRoute(clubId: id, cachedModel: cachedModel));
  }
}
