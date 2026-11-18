import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/shared/player/data/players_repository_impl.dart';
import 'package:seating_generator_web/shared/player/domain/players_repository.dart';

extension PlayersRepositoryDependency on DependencyScope {
  PlayersRepository get playersRepository => resolve<PlayersRepository>(() => PlayersRepositoryImpl(client));
}
