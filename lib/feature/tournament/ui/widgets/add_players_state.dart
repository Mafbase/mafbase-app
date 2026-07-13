import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';

part 'add_players_state.freezed.dart';

@freezed
abstract class AddPlayersState with _$AddPlayersState {
  const factory AddPlayersState({
    @Default([]) List<PlayerModel> staged,
    @Default(false) bool isSubmitting,
  }) = _AddPlayersState;
}
