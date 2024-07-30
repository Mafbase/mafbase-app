import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';

part 'seating_page_dialog_state.freezed.dart';

@freezed
class SeatingPageDialogState with _$SeatingPageDialogState {
  const factory SeatingPageDialogState({
    @Default(true) bool loading,
    String? incorrectPlayer,
    required List<String> notFound,
    @Default([]) List<PlayerModel> players,
  }) = _SeatingPageDialogState;
}
