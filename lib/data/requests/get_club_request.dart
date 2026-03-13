import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetClubRequest extends BaseRequest<Club> {
  GetClubRequest({required int id}) : super('/api/club/$id');

  @override
  FutureOr<Club> parse(List<int> bytes) {
    return compute(Club.fromBuffer, bytes);
  }
}
