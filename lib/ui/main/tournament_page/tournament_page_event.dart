import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/models/tournament_settings_model.dart';

part 'tournament_page_event.freezed.dart';

@freezed
class TournamentPageEvent with _$TournamentPageEvent {
  const factory TournamentPageEvent.backButtonPressed() =
      TournamentPageBackButtonPreesedEvent;

  const factory TournamentPageEvent.playersListTapped() =
      TournamentPageEventPlayersListTapped;

  const factory TournamentPageEvent.updateSettings({
    required TournamentSettingsModel settings,
  }) = TournamentPageEventUpdateSettings;

  const factory TournamentPageEvent.openRating() =
      TournamentPageEventOpenRating;

  const factory TournamentPageEvent.playersListOpened() =
      TournamentPagePlayerListOpenedEvent;

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

  const factory TournamentPageEvent.bill({
    required int playersCount,
    required bool billedTranlsation,
  }) = TournamentPageEventBill;

  const factory TournamentPageEvent.pageOpened() =
      TournamentPageEventPageOpened;
}
