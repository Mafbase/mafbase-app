import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_players_effect.freezed.dart';

@freezed
abstract class AddPlayersEffect with _$AddPlayersEffect {
  /// Показать снэкбар «уже добавлен».
  const factory AddPlayersEffect.showDuplicateWarning() = AddPlayersEffectShowDuplicateWarning;

  /// Диалог завершён: закрыть его и вернуть результат в родительский BLoC.
  const factory AddPlayersEffect.submitCompleted({required bool addedAny}) = AddPlayersEffectSubmitCompleted;
}
