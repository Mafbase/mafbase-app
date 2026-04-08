import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';
import 'package:seating_generator_web/ui/main/rating_page/widgets/rating_table.dart';
import 'package:seating_generator_web/utils.dart';

/// /club/:clubId/rating
@RoutePage()
class ClubRatingPage extends StatelessWidget {
  final int? clubId;
  final String? dateStart;
  final String? dateEnd;
  final String? style;
  final String? sort;
  final int? gameFilter;
  final int? customSortColumnIndex;

  const ClubRatingPage({
    super.key,
    @PathParam('clubId') this.clubId,
    @QueryParam('date-start') this.dateStart,
    @QueryParam('date-end') this.dateEnd,
    @QueryParam('style') this.style,
    @QueryParam('sort') this.sort,
    @QueryParam('game-filter') this.gameFilter,
    @QueryParam('custom-sort-column') this.customSortColumnIndex,
  });

  @override
  Widget build(BuildContext context) {
    DateTimeRange? range;
    if (dateStart != null && dateEnd != null) {
      final start = dateFormatForRequests.tryParse(dateStart!);
      final end = dateFormatForRequests.tryParse(dateEnd!);
      if (start != null && end != null) {
        range = DateTimeRange(start: start, end: end);
      }
    }
    return RatingPage(
      clubId: clubId,
      range: range ??
          DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 30)),
            end: DateTime.now(),
          ),
      style: RatingTableStyle.values.firstWhereOrNull((e) => e.name == style) ?? RatingTableStyle.full,
      sort: RatingSort.values.firstWhereOrNull((e) => e.name == sort) ?? RatingSort.score,
      gameFilter: gameFilter ?? 0,
      customSortColumnIndex: customSortColumnIndex ?? 0,
    );
  }
}

/// /tournament/:id/rating
@RoutePage()
class TournamentRatingPage extends StatelessWidget {
  final int? tournamentId;
  final String? style;
  final String? sort;
  final int? gameFilter;
  final int? customSortColumnIndex;

  const TournamentRatingPage({
    super.key,
    @PathParam('id') this.tournamentId,
    @QueryParam('style') this.style,
    @QueryParam('sort') this.sort,
    @QueryParam('game-filter') this.gameFilter,
    @QueryParam('custom-sort-column') this.customSortColumnIndex,
  });

  @override
  Widget build(BuildContext context) {
    return RatingPage(
      tournamentId: tournamentId,
      style: RatingTableStyle.values.firstWhereOrNull((e) => e.name == style) ?? RatingTableStyle.full,
      sort: RatingSort.values.firstWhereOrNull((e) => e.name == sort) ?? RatingSort.score,
      gameFilter: gameFilter ?? 0,
      customSortColumnIndex: customSortColumnIndex ?? 0,
    );
  }
}
