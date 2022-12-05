import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class DeleteSeparationRequest extends BaseRequest<void> {
  DeleteSeparationRequest({
    required int tournamentId,
    required Player first,
    required Player second,
  }) : super(
          "/api/tournament/$tournamentId/deleteSeparation",
          data: CannotMeetEditionEvent(
            player1: first,
            player2: second,
          ),
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
