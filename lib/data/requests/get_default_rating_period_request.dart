import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetDefaultRatingPeriodRequest extends BaseRequest<ClubDefaultRatingPeriod> {
  GetDefaultRatingPeriodRequest(String clubId) : super('/api/club/$clubId/default-rating-period');

  @override
  FutureOr<ClubDefaultRatingPeriod> parse(List<int> bytes) => compute(ClubDefaultRatingPeriod.fromBuffer, bytes);
}
