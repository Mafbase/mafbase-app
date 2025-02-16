import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';

part 'seating_page_event.freezed.dart';

@freezed
class SeatingPageEvent with _$SeatingPageEvent {
  const factory SeatingPageEvent.addPair() = SeatingPageEventAddPair;

  const factory SeatingPageEvent.createSeating() =
      SeatingPageEventCreateSeating;

  const factory SeatingPageEvent.fsmSeatingTapped() =
      SeatingPageEventFsmSeatingTapped;

  const factory SeatingPageEvent.autoFsmSeating(
    int gomafiaId, {
    Completer? completer,
  }) = SeatingPageEventAutoFsmSeating;

  const factory SeatingPageEvent.deletePair({
    required PlayerModel first,
    required PlayerModel second,
  }) = SeatingPageEventDeletePair;

  const factory SeatingPageEvent.pageOpened({required int tournamentId}) =
      SeatingPageEventPageOpened;

  const factory SeatingPageEvent.openGameEditing({required int gameId}) =
      SeatingPageEventGameEditing;

  const factory SeatingPageEvent.createFinalSeating() =
      SeatingPageEventCreateFinalSeating;

  const factory SeatingPageEvent.createSwissGame({required int game}) =
      SeatingPageEventCreateSwissGame;

  const factory SeatingPageEvent.getPlayersSeating() =
      SeatingPageEventGetPlayersSeating;

  const factory SeatingPageEvent.getTablesSeating() =
      SeatingPageEventGetTablesSeating;

  const factory SeatingPageEvent.getCrossStats() =
      SeatingPageEventGetCrossStats;
}
