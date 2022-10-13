import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_page_event.freezed.dart';
@freezed
class TournamentPageEvent with _$TournamentPageEvent {
  const factory TournamentPageEvent.backButtonPressed() = TournamentPageBackButtonPreesedEvent;

  const factory TournamentPageEvent.playersListOpened() = TournamentPagePlayerListOpenedEvent;

  const factory TournamentPageEvent.addPlayerTapped() = TournamentPageEventAddPlayer;

  const factory TournamentPageEvent.editTournamentSettings() = TournamentPageEventEditSettings;
}