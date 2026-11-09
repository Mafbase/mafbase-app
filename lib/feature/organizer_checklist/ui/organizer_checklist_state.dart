import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';

part 'organizer_checklist_state.freezed.dart';

/// [checklist] сбрасывается при ошибке загрузки; [isUpdating] — сохраняется скрытие или возврат пунктов.
@freezed
abstract class OrganizerChecklistState with _$OrganizerChecklistState {
  const factory OrganizerChecklistState({
    OrganizerChecklistModel? checklist,
    @Default(false) bool hasError,
    @Default(false) bool isUpdating,
    @Default(false) bool isBannerHidden,
  }) = _OrganizerChecklistState;
}
