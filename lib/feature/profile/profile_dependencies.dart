import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/feature/profile/data/repository/profile_repository_impl.dart';
import 'package:seating_generator_web/feature/profile/domain/repository/profile_repository.dart';

extension ProfileDependencies on DependencyScope {
  ProfileRepository get profileRepository => resolve<ProfileRepository>(() => ProfileRepositoryImpl(client));
}
