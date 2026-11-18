import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/data/repositories/tournament_result_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/tournament_result_repository.dart';

extension TournamentResultRepositoryDependency on DependencyScope {
  TournamentResultRepository get tournamentResultRepository =>
      resolve<TournamentResultRepository>(() => TournamentResultRepositoryImpl(client));
}
