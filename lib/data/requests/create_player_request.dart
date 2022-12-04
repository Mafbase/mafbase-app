import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class CreatePlayerRequest extends BaseRequest<CreatePlayerEventOut> {
  CreatePlayerRequest({required Player player})
      : super(
          "/api/createPlayer",
          data: CreatePlayerEvent(player: player),
        );

  @override
  FutureOr<CreatePlayerEventOut> parse(List<int> bytes) {
    return compute(CreatePlayerEventOut.fromBuffer, bytes);
  }
}
