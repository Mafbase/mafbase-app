import 'dart:async';

import 'package:seating_generator_web/core/network/base_request.dart';

class DeleteTournamentRequest extends BaseRequest<void> {
  DeleteTournamentRequest({required int tournamentId})
      : super(
          '/api/tournaments/$tournamentId',
          methodType: Method.delete,
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
