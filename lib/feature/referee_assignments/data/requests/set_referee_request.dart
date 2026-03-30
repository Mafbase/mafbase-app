import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SetRefereeRequest extends BaseRequest<void> {
  SetRefereeRequest({required int tournamentId, required SetRefereeEvent body})
      : super('/api/tournament/$tournamentId/setReferee', data: body);

  @override
  FutureOr<void> parse(List<int> bytes) {
    return null;
  }
}
