import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/feature/referee_assignments/data/referee_repository_impl.dart';
import 'package:seating_generator_web/feature/referee_assignments/domain/referee_repository.dart';

extension RefereeAssignmentsDependencies on DependencyScope {
  RefereeRepository get refereeRepository => resolve<RefereeRepository>(() => RefereeRepositoryImpl(client));
}
