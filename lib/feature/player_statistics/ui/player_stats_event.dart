import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_stats_event.freezed.dart';

@freezed
abstract class PlayerStatsEvent with _$PlayerStatsEvent {
  const factory PlayerStatsEvent.pageOpened({required int playerId}) = PlayerStatsEventPageOpened;
}
