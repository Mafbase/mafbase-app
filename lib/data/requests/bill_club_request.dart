import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class BillClubRequest extends BaseRequest<BillTournamentEventOut> {
  BillClubRequest({
    required int clubId,
    required String redirectPath,
    required int days,
  }) : super(
          "/api/club/$clubId/bill",
          data: BillClubEvent(
            redirectPath: redirectPath,
            days: days,
          ),
        );

  @override
  FutureOr<BillTournamentEventOut> parse(List<int> bytes) {
    return compute(BillTournamentEventOut.fromBuffer, bytes);
  }
}
