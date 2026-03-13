import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class AddClubGameRequest extends BaseRequest<AddGameEventOut> {
  AddClubGameRequest({
    required int clubId,
    required ClubGameResult result,
  }) : super('/api/club/$clubId/addGame', data: result);

  @override
  FutureOr<AddGameEventOut> parse(List<int> bytes) {
    return compute(AddGameEventOut.fromBuffer, bytes);
  }
}
