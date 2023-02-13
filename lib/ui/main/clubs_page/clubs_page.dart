import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({Key? key}) : super(key: key);

  @override
  State<ClubsPage> createState() => _ClubsPageState();

  static String createLocation(BuildContext context) {
    return context.namedLocation('club');
  }

  static final GoRoute route = GoRoute(
    path: 'club',
    name: 'club',
    builder: (context, state) => const Placeholder(),
    routes: [
      AddClubGamePage.route,
      RatingPage.route,
    ],
  );
}

class _ClubsPageState extends State<ClubsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
