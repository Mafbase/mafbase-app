import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class CustomTextInfoRequest extends BaseRequest<bool> {
  CustomTextInfoRequest({required int tournamentId, required String text})
      : super(
          "/api/tournament/$tournamentId/customTextInfo",
          data: CustomTextInfoEvent(text: text),
        );

  @override
  FutureOr<bool> parse(List<int> bytes) {
    return true;
  }
}
