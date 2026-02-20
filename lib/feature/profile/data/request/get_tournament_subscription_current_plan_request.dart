import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetTournamentSubscriptionCurrentPlanRequest
    extends BaseRequest<TournamentSubscriptionPlanEventOut> {
  GetTournamentSubscriptionCurrentPlanRequest()
      : super('/api/subscription/tournament/currentPlan');

  @override
  FutureOr<TournamentSubscriptionPlanEventOut> parse(List<int> bytes) {
    return compute(TournamentSubscriptionPlanEventOut.fromBuffer, bytes);
  }
}
