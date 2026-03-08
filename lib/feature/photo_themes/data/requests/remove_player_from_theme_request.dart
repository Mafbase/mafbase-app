import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';

class RemovePlayerFromThemeRequest extends BaseRequest<void> {
  RemovePlayerFromThemeRequest({
    required int themeId,
    required int playerId,
  }) : super(
          '/api/photoThemes/$themeId/players/$playerId',
          methodType: Method.delete,
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
