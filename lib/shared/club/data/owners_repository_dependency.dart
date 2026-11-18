import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/shared/club/data/owners_repository_impl.dart';
import 'package:seating_generator_web/shared/club/domain/owners_repository.dart';

extension OwnersRepositoryDependency on DependencyScope {
  OwnersRepository get ownersRepository => resolve<OwnersRepository>(() => OwnersRepositoryImpl(client));
}
