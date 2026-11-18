import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/data/repositories/info_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/info_repository.dart';

extension InfoRepositoryDependency on DependencyScope {
  InfoRepository get infoRepository => resolve<InfoRepository>(() => InfoRepositoryImpl(client));
}
