import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';

/// /club/:clubId/addGame
@RoutePage()
class NewClubGamePage extends StatelessWidget {
  final int? clubId;
  final DateTime? initDateTime;

  const NewClubGamePage({
    super.key,
    @PathParam('clubId') this.clubId,
    this.initDateTime,
  });

  @override
  Widget build(BuildContext context) {
    return AddClubGamePage(clubId: clubId, initDateTime: initDateTime);
  }
}

/// /club/:clubId/game/:gameId
@RoutePage()
class ClubGameDetailPage extends StatelessWidget {
  final int? clubId;
  final int? gameId;
  final bool? editParam;

  const ClubGameDetailPage({
    super.key,
    @PathParam('clubId') this.clubId,
    @PathParam('gameId') this.gameId,
    @QueryParam('edit') this.editParam,
  });

  @override
  Widget build(BuildContext context) {
    return AddClubGamePage(clubId: clubId, gameId: gameId, editParam: editParam);
  }
}

/// /tournament/:id/editGame/:gameId
@RoutePage()
class TournamentGameDetailPage extends StatelessWidget {
  final int? tournamentId;
  final int? gameId;
  final bool? editParam;

  const TournamentGameDetailPage({
    super.key,
    @PathParam('id') this.tournamentId,
    @PathParam('gameId') this.gameId,
    @QueryParam('edit') this.editParam,
  });

  @override
  Widget build(BuildContext context) {
    return AddClubGamePage(
      tournamentId: tournamentId,
      gameId: gameId,
      editParam: editParam,
    );
  }
}
