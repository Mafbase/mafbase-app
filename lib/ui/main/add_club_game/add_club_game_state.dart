import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';

part 'add_club_game_state.freezed.dart';

@freezed
class AddClubGameState with _$AddClubGameState {
  const factory AddClubGameState({
    @Default(true) bool isLoading,
    @Default([]) List<PlayerModel> players,
  }) = _AddClubGameState;
}
