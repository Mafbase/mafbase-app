import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SetTranslationDesignRequest extends BaseRequest<void> {
  SetTranslationDesignRequest({required int tournamentId, String? designKey})
      : super(
          '/api/tournament/$tournamentId/translation-design',
          data: SetTournamentDesignEvent(designKey: designKey),
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
