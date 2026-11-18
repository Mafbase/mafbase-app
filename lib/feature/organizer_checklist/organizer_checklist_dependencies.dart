import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/feature/organizer_checklist/data/checklist_banner_storage.dart';
import 'package:seating_generator_web/feature/organizer_checklist/data/organizer_checklist_repository_impl.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_repository.dart';

extension OrganizerChecklistDependencies on DependencyScope {
  OrganizerChecklistRepository get organizerChecklistRepository =>
      resolve<OrganizerChecklistRepository>(() => OrganizerChecklistRepositoryImpl(client));

  ChecklistBannerStorage get checklistBannerStorage =>
      resolve<ChecklistBannerStorage>(() => ChecklistBannerStorageImpl());
}
