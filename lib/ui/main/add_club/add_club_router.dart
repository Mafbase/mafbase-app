import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

abstract class AddClubRouter {
  void openClubsPage();
}

class AddClubRouterImpl implements AddClubRouter {
  final BuildContext context;

  AddClubRouterImpl(this.context);

  @override
  void openClubsPage() {
    context.router.pop();
  }
}
