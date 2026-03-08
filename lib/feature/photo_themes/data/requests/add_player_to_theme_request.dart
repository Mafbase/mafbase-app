import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class AddPlayerToThemeRequest extends BaseRequest<void> {
  AddPlayerToThemeRequest({required int themeId, required int playerId})
      : super(
          '/api/photoThemes/$themeId/players',
          data: AddPlayerToThemeEvent(playerId: playerId),
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
