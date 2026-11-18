import 'dart:async';

import 'package:seating_generator_web/core/network/base_request.dart';

class StopStreamRequest extends BaseRequest<void> {
  StopStreamRequest({required int tournamentId, required int streamId})
      : super('/api/admin/tournament/$tournamentId/streams/$streamId', methodType: Method.delete);

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
