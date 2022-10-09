import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class AddPlayerRequest extends BaseRequest<void> {
  AddPlayerRequest({required int tournamentId, required AddPlayerEvent event})
      : super("/api/tournament/$tournamentId/addPlayer", event);

  @override
  void parse(List<int> bytes) {}
}
