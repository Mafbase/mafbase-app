import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/feature/player_statistics/data/request/get_player_statistics_request.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/model/player_statistics_model.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/repository/player_statistics_repository.dart';

class PlayerStatisticsRepositoryImpl extends BaseRepository implements PlayerStatisticsRepository {
  PlayerStatisticsRepositoryImpl(super.client);

  @override
  Future<PlayerStatisticsModel> getPlayerStatistics(int playerId) async {
    final result = await GetPlayerStatisticsRequest(playerId: playerId).execute(client);
    return PlayerStatisticsModel.fromProto(result);
  }
}
