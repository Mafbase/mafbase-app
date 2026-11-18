import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/shared/tournament/data/tournaments_repository_impl.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournaments_repository.dart';

extension TournamentsRepositoryDependency on DependencyScope {
  TournamentsRepository get tournamentsRepository =>
      resolve<TournamentsRepository>(() => TournamentsRepositoryImpl(client));
}
