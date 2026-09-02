import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetClubStreamsAdminRequest extends BaseRequest<GetStreamsAdminOut> {
  GetClubStreamsAdminRequest({required int clubId}) : super('/api/admin/club/$clubId/streams');

  @override
  FutureOr<GetStreamsAdminOut> parse(List<int> bytes) => compute(GetStreamsAdminOut.fromBuffer, bytes);
}
