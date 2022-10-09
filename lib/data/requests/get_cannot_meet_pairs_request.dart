import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetCannotMeetPairsRequest extends BaseRequest<CannotMeetEventOut> {
  GetCannotMeetPairsRequest({required int tournamentId})
      : super("/api/tournament/$tournamentId/cannotMeet");

  @override
  CannotMeetEventOut parse(List<int> bytes) {
    return CannotMeetEventOut.fromBuffer(bytes);
  }
}
