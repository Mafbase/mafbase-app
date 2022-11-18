import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_event.freezed.dart';

@freezed
class RatingEvent with _$RatingEvent {
  const factory RatingEvent.playerSelected({required int playerId}) =
      RatingEventPlayerSelected;

  const factory RatingEvent.gameSelected({required int gameId}) =
      RatingEventGameSelected;

  const factory RatingEvent.pageOpened({
    required DateTimeRange range,
    required int clubId,
  }) = RatingEventPageOpened;

  const factory RatingEvent.rangeChanged({required DateTimeRange range, required int clubId}) =
      RatingEventRangeChanged;
}
