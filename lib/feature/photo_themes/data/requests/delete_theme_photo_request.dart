import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';

class DeleteThemePhotoRequest extends BaseRequest<void> {
  DeleteThemePhotoRequest({required int themeId, required int playerId})
      : super(
          '/api/photoThemes/$themeId/players/$playerId/photo',
          methodType: Method.delete,
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
