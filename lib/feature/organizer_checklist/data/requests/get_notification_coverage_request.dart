import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetNotificationCoverageRequest extends BaseRequest<NotificationCoverageOut> {
  GetNotificationCoverageRequest({required int tournamentId})
      : super('/api/tournament/$tournamentId/notification-coverage');

  @override
  FutureOr<NotificationCoverageOut> parse(List<int> bytes) => compute(NotificationCoverageOut.fromBuffer, bytes);
}
