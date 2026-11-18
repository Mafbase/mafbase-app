import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/feature/player_statistics/data/repository/player_statistics_repository_impl.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/repository/player_statistics_repository.dart';

extension PlayerStatisticsDependencies on DependencyScope {
  PlayerStatisticsRepository get playerStatisticsRepository =>
      resolve<PlayerStatisticsRepository>(() => PlayerStatisticsRepositoryImpl(client));
}
