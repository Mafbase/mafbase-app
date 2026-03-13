import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class BillTournamentRequest extends BaseRequest<BillTournamentEventOut> {
  BillTournamentRequest({
    required int tournamentId,
    required int billedCount,
    required bool billedTranslation,
    required String redirectPath,
  }) : super(
          '/api/tournament/$tournamentId/bill',
          data: BillTournamentEvent(
            hasTranslation: billedTranslation,
            players: billedCount,
            redirectPath: redirectPath,
          ),
        );

  @override
  FutureOr<BillTournamentEventOut> parse(List<int> bytes) {
    return compute(BillTournamentEventOut.fromBuffer, bytes);
  }
}
