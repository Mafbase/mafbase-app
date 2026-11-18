import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/feature/fantasy/data/fantasy_repository_impl.dart';
import 'package:seating_generator_web/feature/fantasy/domain/fantasy_repository.dart';

extension FantasyDependencies on DependencyScope {
  FantasyRepository get fantasyRepository => resolve<FantasyRepository>(() => FantasyRepositoryImpl(client));
}
