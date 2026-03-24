import 'package:freezed_annotation/freezed_annotation.dart';
part 'tournament_page_effect.freezed.dart';

@freezed
abstract class TournamentPageEffect with _$TournamentPageEffect {
  const factory TournamentPageEffect.showUpdateSettingsSuccess() = TournamentPageEffectUpdateSettingsSuccess;
  const factory TournamentPageEffect.showNotificationSentSuccess() = TournamentPageEffectNotificationSentSuccess;
}
