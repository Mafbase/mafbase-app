import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/feature/tournament/data/info_repository_impl.dart';
import 'package:seating_generator_web/feature/tournament/domain/info_repository.dart';

extension InfoRepositoryDependency on DependencyScope {
  InfoRepository get infoRepository => resolve<InfoRepository>(() => InfoRepositoryImpl(client));
}
