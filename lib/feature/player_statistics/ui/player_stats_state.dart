import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/model/player_statistics_model.dart';

part 'player_stats_state.freezed.dart';

@freezed
class PlayerStatsState with _$PlayerStatsState {
  const factory PlayerStatsState({
    @Default(true) bool isLoading,
    @Default(false) bool hasError,
    PlayerStatisticsModel? statistics,
  }) = _PlayerStatsState;
}
