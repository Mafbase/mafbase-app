import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetStreamsAdminRequest extends BaseRequest<GetStreamsAdminOut> {
  GetStreamsAdminRequest({required int tournamentId}) : super('/api/admin/tournament/$tournamentId/streams');

  @override
  FutureOr<GetStreamsAdminOut> parse(List<int> bytes) => compute(GetStreamsAdminOut.fromBuffer, bytes);
}
