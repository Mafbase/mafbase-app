import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SubstitutePlayerRequest extends BaseRequest<void> {
  SubstitutePlayerRequest({
    required int tournamentId,
    required int oldPlayerId,
    required int newPlayerId,
    required List<int> games,
  }) : super(
          '/api/tournaments/$tournamentId/substitutePlayer',
          data: SubstitutePlayerEvent(
            oldPlayerId: oldPlayerId,
            newPlayerId: newPlayerId,
            games: games,
          ),
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
