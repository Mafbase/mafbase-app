import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetTableDescriptionRequest extends BaseRequest<TableInfoEvent> {
  GetTableDescriptionRequest({required String tournamentId}) : super('/api/tournament/$tournamentId/tablesInfo');

  @override
  FutureOr<TableInfoEvent> parse(List<int> bytes) => compute(TableInfoEvent.fromBuffer, bytes);
}
