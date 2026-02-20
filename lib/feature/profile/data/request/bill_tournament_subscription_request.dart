import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class BillTournamentSubscriptionRequest
    extends BaseRequest<BillTournamentEventOut> {
  BillTournamentSubscriptionRequest({
    required TournamentSubscriptionType subscriptionType,
    required int days,
    required String redirectPath,
  }) : super(
          '/api/subscription/tournament/bill',
          data: BillTournamentSubscriptionEvent(
            subscriptionType: subscriptionType,
            days: days,
            redirectPath: redirectPath,
          ),
        );

  @override
  FutureOr<BillTournamentEventOut> parse(List<int> bytes) {
    return compute(BillTournamentEventOut.fromBuffer, bytes);
  }
}
