import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/game_result_model.dart';

part 'club_games_state.freezed.dart';

@freezed
abstract class ClubGamesState with _$ClubGamesState {
  const factory ClubGamesState({
    @Default([]) List<GameResultModel> games,
    @Default(true) bool loading,
    @Default('desc') String sort,
  }) = _ClubGamesState;
}
