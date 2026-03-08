import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class UpdatePhotoThemeRequest extends BaseRequest<void> {
  UpdatePhotoThemeRequest({required int themeId, required String name})
      : super(
          '/api/photoThemes/$themeId',
          data: UpdatePhotoThemeEvent(name: name),
          methodType: Method.put,
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
