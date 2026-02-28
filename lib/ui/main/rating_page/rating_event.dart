import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/ui/main/rating_page/widgets/rating_table.dart';

part 'rating_event.freezed.dart';

@freezed
sealed class RatingEvent with _$RatingEvent {
  const factory RatingEvent.playerSelected({required int playerId}) =
      RatingEventPlayerSelected;

  const factory RatingEvent.downloadRating({
    required DateTimeRange range,
    required int clubId,
  }) = RatingEventDownload;

  const factory RatingEvent.downloadStats({
    required DateTimeRange range,
    required int clubId,
  }) = RatingEventDownloadStats;

  const factory RatingEvent.gameSelected({
    required int gameId,
    int? clubId,
    int? tournamentId,
  }) = RatingEventGameSelected;

  const factory RatingEvent.pageOpened({
    required DateTimeRange? range,
    required int? clubId,
    required int? tournamentId,
  }) = RatingEventPageOpened;

  const factory RatingEvent.rangeChanged({
    required DateTimeRange? range,
    required int? clubId,
    required int? tournamentId,
    required RatingTableStyle style,
    required RatingSort sort,
    required int gameFilter,
    @Default(0) int customSortColumnIndex,
  }) = RatingEventRangeChanged;
}
