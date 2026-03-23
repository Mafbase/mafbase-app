import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetPhotoThemesRequest extends BaseRequest<GetPhotoThemesEventOut> {
  GetPhotoThemesRequest() : super('/api/photoThemes');

  @override
  FutureOr<GetPhotoThemesEventOut> parse(List<int> bytes) => compute(GetPhotoThemesEventOut.fromBuffer, bytes);
}
