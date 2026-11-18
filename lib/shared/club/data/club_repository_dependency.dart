import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/shared/club/data/club_repository_impl.dart';
import 'package:seating_generator_web/shared/club/domain/club_repository.dart';

extension ClubRepositoryDependency on DependencyScope {
  ClubRepository get clubRepository => resolve<ClubRepository>(() => ClubRepositoryImpl(client));
}
