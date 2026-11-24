import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_ui/material_ui.dart';

part 'club_games_event.freezed.dart';

@freezed
abstract class ClubGamesEvent with _$ClubGamesEvent {
  const factory ClubGamesEvent.init({required int clubId, required DateTimeRange range, @Default('asc') String sort}) =
      ClubGamesEventInit;
}
