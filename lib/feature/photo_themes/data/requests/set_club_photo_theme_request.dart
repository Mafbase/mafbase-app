import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SetClubPhotoThemeRequest extends BaseRequest<void> {
  SetClubPhotoThemeRequest({required int clubId, int? themeId})
      : super(
          '/api/club/$clubId/photoTheme',
          data: SetClubPhotoThemeEvent(themeId: themeId),
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
