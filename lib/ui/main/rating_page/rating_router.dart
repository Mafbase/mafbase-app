import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/ui/main/rating_page/widgets/rating_table.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/utils.dart';

abstract class RatingRouter {
  void changeRange(
    DateTimeRange? range,
    int? clubId,
    int? tournamentId,
    RatingTableStyle style,
    RatingSort sort,
    int gameFilter, {
    int customSortColumnIndex,
  });

  void openGame(int clubId, int gameId);

  void openTournamentGame(int tournamentId, int gameId);
}

class RatingRouterImpl implements RatingRouter {
  final BuildContext context;

  RatingRouterImpl(this.context);

  @override
  void changeRange(
    DateTimeRange? range,
    int? clubId,
    int? tournamentId,
    RatingTableStyle style,
    RatingSort sort,
    int gameFilter, {
    int customSortColumnIndex = 0,
  }) {
    if (clubId != null) {
      context.router.replace(
        ClubRatingRoute(
          clubId: clubId,
          dateStart: range == null ? null : dateFormatForRequests.format(range.start),
          dateEnd: range == null ? null : dateFormatForRequests.format(range.end),
          style: style.name,
          sort: sort.name,
          gameFilter: gameFilter,
          customSortColumnIndex: customSortColumnIndex > 0 ? customSortColumnIndex : null,
        ),
      );
    } else if (tournamentId != null) {
      context.router.replace(
        TournamentRatingRoute(
          tournamentId: tournamentId,
          style: style.name,
          sort: sort.name,
          gameFilter: gameFilter,
          customSortColumnIndex: customSortColumnIndex > 0 ? customSortColumnIndex : null,
        ),
      );
    } else {
      throw ArgumentError();
    }
  }

  @override
  void openGame(int clubId, int gameId) {
    context.router.push(
      ClubGameDetailRoute(clubId: clubId, gameId: gameId, editParam: false),
    );
  }

  @override
  void openTournamentGame(int tournamentId, int gameId) {
    context.router.push(
      TournamentGameDetailRoute(
        tournamentId: tournamentId,
        gameId: gameId,
        editParam: context.read<TournamentPageBloc>().state.isMyTournament,
      ),
    );
  }
}
