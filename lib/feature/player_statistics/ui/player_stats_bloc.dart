import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/repository/player_statistics_repository.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_event.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_state.dart';

class PlayerStatsBloc extends Bloc<PlayerStatsEvent, PlayerStatsState> {
  final PlayerStatisticsRepository _repository;

  PlayerStatsBloc(this._repository, {PlayerStatsState initialState = const PlayerStatsState()}) : super(initialState) {
    on<PlayerStatsEventPageOpened>(_onPageOpened);
  }

  Future<void> _onPageOpened(
    PlayerStatsEventPageOpened event,
    Emitter<PlayerStatsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, hasError: false));
    try {
      final statistics = await _repository.getPlayerStatistics(event.playerId);
      emit(state.copyWith(isLoading: false, statistics: statistics));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
