import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'club_games_event.freezed.dart';

@freezed
abstract class ClubGamesEvent with _$ClubGamesEvent {
  const factory ClubGamesEvent.init({
    required int clubId,
    required DateTimeRange range,
    @Default('desc') String sort,
  }) = ClubGamesEventInit;
}
