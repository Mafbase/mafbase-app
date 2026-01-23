import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SetFantasyPredictionRequest extends BaseRequest<void> {
  SetFantasyPredictionRequest({required int tournamentId, required GameWin prediction})
      : super(
          '/api/tournament/$tournamentId/fantasy/prediction',
          data: SetFantasyPredictionEvent(prediction: prediction),
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
