import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/game_result_model.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/utils.dart';

part 'seating_page_state.freezed.dart';

@freezed
class SeatingPageState with _$SeatingPageState {
  const factory SeatingPageState({
    @Default([]) List<Pair<PlayerModel, PlayerModel>> cannotMeet,
    @Default(true) bool isLoading,
    @Default([]) List<List<GameResultModel>> games,
  }) = _SeatingPageState;
}
