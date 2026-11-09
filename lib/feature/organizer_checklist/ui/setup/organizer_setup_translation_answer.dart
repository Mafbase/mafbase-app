import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_event.dart';

/// Ответ на вопрос о трансляции с плашками. Отдельно он не хранится: это скрытие пунктов чеклиста.
enum OrganizerSetupTranslationAnswer {
  obs,
  phone,
  none,
  unknown;

  /// null — «Пока не знаю»: чеклист не меняется.
  OrganizerChecklistMutationEvent? get checklistEvent => switch (this) {
        obs => const OrganizerChecklistEventSelectStreamMethod(ChecklistStreamMethod.obs),
        phone => const OrganizerChecklistEventSelectStreamMethod(ChecklistStreamMethod.phone),
        none => OrganizerChecklistEventSetDismissed(keys: ChecklistGroup.translation.keys, dismissed: true),
        unknown => null,
      };
}
