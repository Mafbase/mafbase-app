import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/shared/stream/data/stream_repository_impl.dart';
import 'package:seating_generator_web/shared/stream/domain/stream_repository.dart';

extension StreamRepositoryDependency on DependencyScope {
  StreamRepository get streamRepository => resolve<StreamRepository>(() => StreamRepositoryImpl(client));
}
