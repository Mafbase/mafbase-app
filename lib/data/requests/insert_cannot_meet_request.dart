import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class InsertCannotMeetRequest extends BaseRequest<void> {
  InsertCannotMeetRequest({
    required int tournamentId,
    required CannotMeetEditionEvent event,
  }) : super('/api/tournament/$tournamentId/separate', data: event);

  @override
  void parse(List<int> bytes) {}
}
