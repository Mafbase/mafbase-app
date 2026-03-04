import 'package:seating_generator_web/feature/player_statistics/domain/model/player_statistics_model.dart';

abstract class PlayerStatisticsRepository {
  Future<PlayerStatisticsModel> getPlayerStatistics(int playerId);
}
