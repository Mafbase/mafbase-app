import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetPlayerStatisticsRequest extends BaseRequest<PlayerStatisticsEventOut> {
  GetPlayerStatisticsRequest({required int playerId}) : super('/api/player/$playerId/statistics');

  @override
  PlayerStatisticsEventOut parse(List<int> bytes) {
    return PlayerStatisticsEventOut.fromBuffer(bytes);
  }
}
