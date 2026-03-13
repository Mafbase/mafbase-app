import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetClubGameRequest extends BaseRequest<ClubGameResult> {
  GetClubGameRequest({required int clubId, required int gameId}) : super('/api/club/$clubId/game/$gameId');

  @override
  ClubGameResult parse(List<int> bytes) {
    return ClubGameResult.fromBuffer(bytes);
  }
}
