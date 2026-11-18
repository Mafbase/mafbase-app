import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/shared/tournament/data/tournament_edit_repository_impl.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournament_edit_repository.dart';

extension TournamentEditRepositoryDependency on DependencyScope {
  TournamentEditRepository get tournamentEditRepository =>
      resolve<TournamentEditRepository>(() => TournamentEditRepositoryImpl(client));
}
