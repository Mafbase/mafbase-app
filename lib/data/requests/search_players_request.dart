import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SearchPlayersRequest extends BaseRequest<GetAvailablePlayerEventOut> {
  SearchPlayersRequest({
    required String search,
    int limit = 5,
    int offset = 0,
  }) : super('/api/availablePlayers?search=$search&limit=$limit&offset=$offset');

  @override
  GetAvailablePlayerEventOut parse(List<int> bytes) {
    return GetAvailablePlayerEventOut.fromBuffer(bytes);
  }
}
