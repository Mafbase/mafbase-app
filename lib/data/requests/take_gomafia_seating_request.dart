import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class TakeGomafiaSeatingRequest extends BaseRequest<void> {
  TakeGomafiaSeatingRequest({
    required int tournamentId,
    required int gomafiaId,
  }) : super(
          '/api/takeGomafiaSeating/$tournamentId',
          data: TakeGomafiaSeatingEvent(id: gomafiaId),
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
