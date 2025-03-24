import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class AddOwnerRequest extends BaseRequest<void> {
  AddOwnerRequest({required int tournamentId, required String email})
      : super(
          '/api/tournaments/$tournamentId/owners',
          data: UpdateOwnerEvent(email: email),
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
