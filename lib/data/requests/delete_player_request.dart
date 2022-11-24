import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class DeletePlayerRequest extends BaseRequest<void> {
  DeletePlayerRequest({
    required int tournamentId,
    required AddPlayerEvent event,
  }) : super("/api/tournament/$tournamentId/deletePlayer", data: event);

  @override
  void parse(List<int> bytes) {}
}
