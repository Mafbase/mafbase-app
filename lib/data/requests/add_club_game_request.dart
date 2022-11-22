import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class AddClubGameRequest extends BaseRequest<void> {
  AddClubGameRequest({
    required int clubId,
    required ClubGameResult result,
  }) : super("/api/club/$clubId/addGame", result);

  @override
  void parse(List<int> bytes) {}
}
