import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';

sealed class OrganizerChecklistEvent {
  const OrganizerChecklistEvent();
}

/// Частые загрузки схлопываются в одну.
final class OrganizerChecklistEventLoad extends OrganizerChecklistEvent {
  const OrganizerChecklistEventLoad();
}

/// Изменения скрытых пунктов выполняются по очереди.
sealed class OrganizerChecklistMutationEvent extends OrganizerChecklistEvent {
  const OrganizerChecklistMutationEvent();
}

final class OrganizerChecklistEventSetDismissed extends OrganizerChecklistMutationEvent {
  final List<ChecklistKey> keys;
  final bool dismissed;

  const OrganizerChecklistEventSetDismissed({
    required this.keys,
    required this.dismissed,
  });
}

/// Скрывает пункты другого способа и возвращает пункты выбранного.
final class OrganizerChecklistEventSelectStreamMethod extends OrganizerChecklistMutationEvent {
  final ChecklistStreamMethod method;

  const OrganizerChecklistEventSelectStreamMethod(this.method);
}

final class OrganizerChecklistEventHideBanner extends OrganizerChecklistEvent {
  const OrganizerChecklistEventHideBanner();
}
