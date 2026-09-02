import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';

class StopClubStreamRequest extends BaseRequest<void> {
  StopClubStreamRequest({required int clubId, required int streamId})
      : super('/api/admin/club/$clubId/streams/$streamId', methodType: Method.delete);

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
