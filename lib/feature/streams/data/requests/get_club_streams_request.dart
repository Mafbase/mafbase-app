import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetClubStreamsRequest extends BaseRequest<GetStreamsOut> {
  GetClubStreamsRequest({required int clubId}) : super('/api/club/$clubId/streams');

  @override
  FutureOr<GetStreamsOut> parse(List<int> bytes) => compute(GetStreamsOut.fromBuffer, bytes);
}
