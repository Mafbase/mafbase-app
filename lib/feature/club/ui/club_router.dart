import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/router.dart';

abstract class ClubRouter {
  void openRating({required int clubId});

  void openWebView(String url);

  String getLocation();
}

class ClubRouterImpl implements ClubRouter {
  final BuildContext context;

  ClubRouterImpl(this.context);

  @override
  void openRating({required int clubId}) {
    context.router.push(ClubRatingRoute(clubId: clubId));
  }

  @override
  String getLocation() {
    return context.router.currentUrl;
  }

  @override
  void openWebView(String url) {
    context.router.push(WebViewRoute(url: url, title: 'Оплата'));
  }
}
