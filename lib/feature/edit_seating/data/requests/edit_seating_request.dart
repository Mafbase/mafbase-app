import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class EditSeatingRequest extends BaseRequest<void> {
  EditSeatingRequest({
    required int tournamentId,
    required int game,
    required int table,
    required List<int> playerIds,
    required int refereeId,
  }) : super(
          '/api/tournament/$tournamentId/editSeating',
          data: EditSeatingEvent(
            game: game,
            table: table,
            players: playerIds,
            referee: refereeId,
          ),
          methodType: Method.put,
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
