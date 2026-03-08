import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';

class DeletePhotoThemeRequest extends BaseRequest<void> {
  DeletePhotoThemeRequest({required int themeId})
      : super(
          '/api/photoThemes/$themeId',
          methodType: Method.delete,
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
