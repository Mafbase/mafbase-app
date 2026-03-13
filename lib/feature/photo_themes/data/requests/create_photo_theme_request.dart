import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class CreatePhotoThemeRequest extends BaseRequest<CreatePhotoThemeEventOut> {
  CreatePhotoThemeRequest({required String name})
      : super(
          '/api/photoThemes',
          data: CreatePhotoThemeEvent(name: name),
        );

  @override
  FutureOr<CreatePhotoThemeEventOut> parse(List<int> bytes) => compute(CreatePhotoThemeEventOut.fromBuffer, bytes);
}
