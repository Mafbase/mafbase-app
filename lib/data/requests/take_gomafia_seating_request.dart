import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class TakeGomafiaSeatingRequest
    extends BaseRequest<TakeGomafiaSeatingEventOut> {
  TakeGomafiaSeatingRequest({
    required int tournamentId,
    required int gomafiaId,
  }) : super(
          '/api/takeGomafiaSeating/$tournamentId',
          data: TakeGomafiaSeatingEvent(id: gomafiaId),
        );

  @override
  FutureOr<TakeGomafiaSeatingEventOut> parse(List<int> bytes) => compute(
        TakeGomafiaSeatingEventOut.fromBuffer,
        bytes,
      );
}
