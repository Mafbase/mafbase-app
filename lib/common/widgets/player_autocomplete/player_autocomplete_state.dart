import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';

part 'player_autocomplete_state.freezed.dart';

@freezed
class PlayerAutoCompleteState with _$PlayerAutoCompleteState {
  const factory PlayerAutoCompleteState({
    @Default([]) List<PlayerModel> results,
    String? query,
  }) = _PlayerAutoCompleteState;
}
