import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetTournamentsRequest extends BaseRequest<GetTournamentsEventOut> {
  GetTournamentsRequest({required int limit, required int offset, String? search})
      : super(
            '/api/tournaments?limit=$limit&offset=$offset${search != null && search.isNotEmpty ? '&search=$search' : ''}');

  @override
  FutureOr<GetTournamentsEventOut> parse(List<int> bytes) {
    return compute(GetTournamentsEventOut.fromBuffer, bytes);
  }
}
