import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';

class GenerateFinalSeatingRequest extends BaseRequest<dynamic> {
  GenerateFinalSeatingRequest({required int tournamentId}) : super('/api/tournament/$tournamentId/createFinalSeating');

  @override
  FutureOr parse(List<int> bytes) {
    return null;
  }
}
