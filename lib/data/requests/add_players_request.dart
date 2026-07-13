import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class AddPlayersRequest extends BaseRequest<AddPlayersEventOut> {
  AddPlayersRequest({required int tournamentId, required AddPlayersEvent event})
      : super('/api/tournament/$tournamentId/addPlayers', data: event);

  @override
  FutureOr<AddPlayersEventOut> parse(List<int> bytes) {
    return compute(AddPlayersEventOut.fromBuffer, bytes);
  }
}
