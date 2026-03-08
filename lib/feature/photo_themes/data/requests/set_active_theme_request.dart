import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SetActiveThemeRequest extends BaseRequest<void> {
  SetActiveThemeRequest({required int tournamentId, int? themeId})
      : super(
          '/api/tournament/$tournamentId/photoTheme',
          data: SetTournamentPhotoThemeEvent(themeId: themeId),
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
