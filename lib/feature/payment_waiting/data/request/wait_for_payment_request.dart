import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class WaitForPaymentRequest extends BaseRequest<WaitForPaymentResponse> {
  WaitForPaymentRequest({required int purchaseId}) : super('/api/purchase/$purchaseId/waitForPayment');

  @override
  FutureOr<WaitForPaymentResponse> parse(List<int> bytes) {
    return compute(WaitForPaymentResponse.fromBuffer, bytes);
  }
}
