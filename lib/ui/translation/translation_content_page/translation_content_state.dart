import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';

part 'translation_content_state.freezed.dart';

@freezed
class TranslationContentState with _$TranslationContentState {
  const factory TranslationContentState({
    List<PlayerRole>? roles,
    List<PlayerStatus>? statuses,
    List<String>? images,
    List<String>? nicknames,
    @Default(0) int game,
    @Default(0) int totalGames,
  }) = _TranslationContentState;
}

extension TranslationContentStateExt on TranslationContentState {
  bool isNotEmpty() {
    return roles != null && statuses != null && images != null && nicknames != null;
  }
}
