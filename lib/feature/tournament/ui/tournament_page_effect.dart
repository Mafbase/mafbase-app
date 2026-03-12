import 'package:freezed_annotation/freezed_annotation.dart';
part 'tournament_page_effect.freezed.dart';
@freezed
class TournamentPageEffect with _$TournamentPageEffect {
  const factory TournamentPageEffect.showUpdateSettingsSuccess() =
      TournamentPageEffectUpdateSettingsSuccess;
}
