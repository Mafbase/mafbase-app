import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({Key? key}) : super(key: key);

  @override
  State<ClubPage> createState() => _ClubPageState();

  static void open({
    required BuildContext context,
    required int id,
    ClubModel? cachedModel,
  }) {
    context.goNamed(
      'club',
      params: {"clubId": id.toString()},
      extra: cachedModel,
    );
  }

  static final route = GoRoute(
    name: 'club',
    path: ':clubId',
    builder: (context, state) => const ClubPage(),
    routes: [
      ...AddClubGamePage.routes,
      RatingPage.route,
    ],
  );
}

class _ClubPageState extends State<ClubPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
