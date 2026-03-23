import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class DeleteCannotMeetRequest extends BaseRequest<void> {
  DeleteCannotMeetRequest({
    required int tournamentId,
    required CannotMeetEditionEvent event,
  }) : super('/api/tournament/$tournamentId/deleteSeparation', data: event);

  @override
  void parse(List<int> bytes) {}
}
