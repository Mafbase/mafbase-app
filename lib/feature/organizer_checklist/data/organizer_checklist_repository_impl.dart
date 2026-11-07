import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/feature/organizer_checklist/data/requests/get_checklist_request.dart';
import 'package:seating_generator_web/feature/organizer_checklist/data/requests/get_notification_coverage_request.dart';
import 'package:seating_generator_web/feature/organizer_checklist/data/requests/set_checklist_dismissed_request.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/notification_coverage_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class OrganizerChecklistRepositoryImpl extends BaseRepository implements OrganizerChecklistRepository {
  OrganizerChecklistRepositoryImpl(super.client);

  @override
  Future<OrganizerChecklistModel> getChecklist(int tournamentId) =>
      GetChecklistRequest(tournamentId: tournamentId).execute(client).then(OrganizerChecklistModel.fromProto);

  @override
  Future<OrganizerChecklistModel> setDismissed(
    int tournamentId, {
    required List<ChecklistKey> keys,
    required bool dismissed,
  }) =>
      SetChecklistDismissedRequest(
        tournamentId: tournamentId,
        body: SetChecklistDismissedEvent(
          keys: keys.map((key) => key.proto),
          dismissed: dismissed,
        ),
      ).execute(client).then(OrganizerChecklistModel.fromProto);

  @override
  Future<NotificationCoverageModel> getNotificationCoverage(int tournamentId) =>
      GetNotificationCoverageRequest(tournamentId: tournamentId)
          .execute(client)
          .then(NotificationCoverageModel.fromProto);
}
