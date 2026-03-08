import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetThemePlayersRequest
    extends BaseRequest<GetPhotoThemePlayersEventOut> {
  GetThemePlayersRequest({required int themeId})
      : super('/api/photoThemes/$themeId/players');

  @override
  FutureOr<GetPhotoThemePlayersEventOut> parse(List<int> bytes) =>
      compute(GetPhotoThemePlayersEventOut.fromBuffer, bytes);
}
