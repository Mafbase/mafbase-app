import 'package:freezed_annotation/freezed_annotation.dart';

part 'organizer_setup_state.freezed.dart';

enum OrganizerSetupStep { fsm, gomafiaUrl, translation, done }

/// [isGomafiaUrlSaved] — ссылка GoMafia сохранена в этом мастере: в конце он предложит загрузить участников.
@freezed
abstract class OrganizerSetupState with _$OrganizerSetupState {
  const factory OrganizerSetupState({
    @Default(OrganizerSetupStep.fsm) OrganizerSetupStep step,
    @Default(false) bool isSaving,
    @Default(false) bool isGomafiaUrlSaved,
  }) = _OrganizerSetupState;
}
