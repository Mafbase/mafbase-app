import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/data/repositories/owners_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/owners_repository.dart';

extension OwnersRepositoryDependency on DependencyScope {
  OwnersRepository get ownersRepository => resolve<OwnersRepository>(() => OwnersRepositoryImpl(client));
}
