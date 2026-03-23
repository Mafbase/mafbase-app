import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetTournamentRequest extends BaseRequest<Tournament> {
  GetTournamentRequest({required int id}) : super('/api/tournaments/$id');

  @override
  FutureOr<Tournament> parse(List<int> bytes) {
    return compute(Tournament.fromBuffer, bytes);
  }
}
