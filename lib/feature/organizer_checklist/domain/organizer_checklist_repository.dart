import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/notification_coverage_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';

abstract interface class OrganizerChecklistRepository {
  Future<OrganizerChecklistModel> getChecklist(int tournamentId);

  /// Скрывает или возвращает пункты и отдаёт пересчитанный чеклист.
  Future<OrganizerChecklistModel> setDismissed(
    int tournamentId, {
    required List<ChecklistKey> keys,
    required bool dismissed,
  });

  Future<NotificationCoverageModel> getNotificationCoverage(int tournamentId);
}
