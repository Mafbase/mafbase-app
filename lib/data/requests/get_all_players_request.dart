import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetAllPlayersRequest extends BaseRequest<GetAvailablePlayerEventOut> {
  GetAllPlayersRequest() : super('/api/availablePlayers');

  @override
  GetAvailablePlayerEventOut parse(List<int> bytes) {
    return GetAvailablePlayerEventOut.fromBuffer(bytes);
  }
}
