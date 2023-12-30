import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class CreateSwissGameRequest extends BaseRequest<bool> {
  CreateSwissGameRequest({
    required int tournamentId,
    required int game,
  }) : super(
          '/api/tournament/$tournamentId/createSwissGame',
          data: CreateSwissRound(game: game),
        );

  @override
  FutureOr<bool> parse(List<int> bytes) {
    return true;
  }
}
