import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/data/repositories/club_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';

extension ClubRepositoryDependency on DependencyScope {
  ClubRepository get clubRepository => resolve<ClubRepository>(() => ClubRepositoryImpl(client));
}
