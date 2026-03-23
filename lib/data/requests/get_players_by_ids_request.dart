import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetPlayersByIdsRequest extends BaseRequest<GetAvailablePlayerEventOut> {
  GetPlayersByIdsRequest({
    required List<int> ids,
  }) : super('/api/playersByIds?ids=${ids.join(",")}');

  @override
  GetAvailablePlayerEventOut parse(List<int> bytes) {
    return GetAvailablePlayerEventOut.fromBuffer(bytes);
  }
}
