import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class AddClubOwnerRequest extends BaseRequest<void> {
  AddClubOwnerRequest({required int clubId, required String email})
      : super(
          '/api/clubs/$clubId/owners',
          data: UpdateOwnerEvent(email: email),
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
