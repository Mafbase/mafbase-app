import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';

part 'tournament_page_event.freezed.dart';

@freezed
class TournamentPageEvent with _$TournamentPageEvent {
  const factory TournamentPageEvent.backButtonPressed() =
      TournamentPageBackButtonPreesedEvent;

  const factory TournamentPageEvent.playersListTapped() =
      TournamentPageEventPlayersListTapped;

  const factory TournamentPageEvent.playersListOpened(
      {required int tournamentId}) = TournamentPagePlayerListOpenedEvent;

  const factory TournamentPageEvent.addPlayerTapped() =
      TournamentPageEventAddPlayer;

  const factory TournamentPageEvent.editTournamentSettings() =
      TournamentPageEventEditSettings;

  const factory TournamentPageEvent.deletePlayer({
    required PlayerModel player,
  }) = TournamentPageEventDeletePlayer;

  const factory TournamentPageEvent.openProfileDialog({
    required PlayerModel player,
  }) = TournamentPageEventOpenProfileDialog;

  const factory TournamentPageEvent.openSeatingPage() =
      TournamentPageEventOpenSeatingPage;
}
