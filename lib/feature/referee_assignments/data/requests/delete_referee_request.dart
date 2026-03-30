import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class DeleteRefereeRequest extends BaseRequest<void> {
  DeleteRefereeRequest({required int tournamentId, required DeleteRefereeEvent body})
      : super('/api/tournament/$tournamentId/deleteReferee', data: body);

  @override
  FutureOr<void> parse(List<int> bytes) {
    return null;
  }
}
