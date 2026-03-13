import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';

class CreateSeatingRequest extends BaseRequest<void> {
  CreateSeatingRequest({required int tournamentId}) : super('/api/tournament/$tournamentId/createSeating');

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
