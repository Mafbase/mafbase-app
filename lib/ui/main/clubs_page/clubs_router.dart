import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/ui/main/club_page/club_page.dart';

abstract class ClubsRouter {
  void openClubPage({required int id, ClubModel? cachedModel});
}

class ClubsRouterImpl implements ClubsRouter {
  final BuildContext context;

  ClubsRouterImpl(this.context);

  @override
  void openClubPage({required int id, ClubModel? cachedModel}) {
    ClubPage.open(context: context, id: id, cachedModel: cachedModel);
  }
}
