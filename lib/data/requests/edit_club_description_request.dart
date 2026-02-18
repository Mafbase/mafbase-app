import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class EditClubDescriptionRequest extends BaseRequest<void> {
  EditClubDescriptionRequest({
    required int clubId,
    required Club club,
  }) : super(
          '/api/club/$clubId/club-description/edit',
          data: club,
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
