import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';

class DeleteGameRequest extends BaseRequest<dynamic> {
  DeleteGameRequest({required int clubId, required int gameId})
      : super(
          '/api/club/$clubId/game/$gameId',
          methodType: Method.delete,
        );

  @override
  FutureOr parse(List<int> bytes) {
    return true;
  }
}
