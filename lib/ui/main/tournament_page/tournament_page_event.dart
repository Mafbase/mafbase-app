import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_page_event.freezed.dart';

@freezed
class TournamentPageEvent with _$TournamentPageEvent {
  const factory TournamentPageEvent.backButtonPressed() =
      TournamentPageBackButtonPreesedEvent;

  const factory TournamentPageEvent.playersListOpened() =
      TournamentPagePlayerListOpenedEvent;

  const factory TournamentPageEvent.addPlayerTapped() =
      TournamentPageEventAddPlayer;

  const factory TournamentPageEvent.editTournamentSettings() =
      TournamentPageEventEditSettings;

  const factory TournamentPageEvent.addPhoto({
    required int playerId,
    required String filename,
    required Uint8List bytes,
  }) = TournamentPageEventAddPhoto;
}
