import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';

abstract class AddClubRouter {
  void openClubPage(ClubModel club);
}

class AddClubRouterImpl implements AddClubRouter {
  final BuildContext context;

  AddClubRouterImpl(this.context);

  @override
  void openClubPage(ClubModel club) {
    context.router.replace(ClubRoute(clubId: club.id, cachedModel: club));
  }
}
