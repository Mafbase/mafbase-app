import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/data/repositories/stream_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/stream_repository.dart';

extension StreamRepositoryDependency on DependencyScope {
  StreamRepository get streamRepository => resolve<StreamRepository>(() => StreamRepositoryImpl(client));
}
