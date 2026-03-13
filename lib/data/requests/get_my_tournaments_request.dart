import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetMyTournamentsRequest extends BaseRequest<GetTournamentsEventOut> {
  GetMyTournamentsRequest() : super('/api/tournaments');

  @override
  FutureOr<GetTournamentsEventOut> parse(List<int> bytes) {
    return compute(GetTournamentsEventOut.fromBuffer, bytes);
  }
}
