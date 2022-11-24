import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class EditClubGameRequest extends BaseRequest<void> {
  EditClubGameRequest({
    required int clubId,
    required int gameId,
    required ClubGameResult result,
  }) : super("/api/club/$clubId/editGame/$gameId", data: result);

  @override
  void parse(List<int> bytes) {}
}
