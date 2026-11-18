import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/data/repositories/players_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';

extension PlayersRepositoryDependency on DependencyScope {
  PlayersRepository get playersRepository => resolve<PlayersRepository>(() => PlayersRepositoryImpl(client));
}
