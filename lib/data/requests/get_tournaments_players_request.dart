import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetTournamentsPlayersRequest
    extends BaseRequest<GetAvailablePlayerEventOut> {
  GetTournamentsPlayersRequest({required int tournamentId})
      : super("/api/tournament/$tournamentId/players");

  @override
  GetAvailablePlayerEventOut parse(List<int> bytes) {
    return GetAvailablePlayerEventOut.fromBuffer(bytes);
  }
}
