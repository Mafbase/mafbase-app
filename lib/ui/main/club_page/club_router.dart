import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/feature/webview/web_view_screen.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';

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
    context.go(
      RatingPage.createClubLocation(
        clubId: clubId,
        context: context,
      ),
    );
  }

  @override
  String getLocation() {
    return GoRouterState.of(context).uri.toString();
  }

  @override
  void openWebView(String url) {
    context.push(
      WebViewScreen.createLocation(
        url: url,
        title: 'Оплата',
      ),
    );
  }
}
