import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SetTableDescriptionRequest extends BaseRequest<void> {
  SetTableDescriptionRequest({required String tournamentId, required TableInfoEvent body})
      : super('/api/tournament/$tournamentId/tablesInfo', data: body);

  @override
  FutureOr<void> parse(List<int> bytes) {
    return null;
  }
}
