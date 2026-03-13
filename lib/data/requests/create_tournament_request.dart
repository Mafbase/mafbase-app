import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

class CreateTournamentRequest extends BaseRequest<CreateTournamentEventOut> {
  CreateTournamentRequest({
    required String name,
    required DateTimeRange dateTimeRange,
  }) : super(
          '/api/createTournament',
          data: CreateTournamentEvent(
            name: name,
            dateStart: dateFormatForRequests.format(dateTimeRange.start),
            dateEnd: dateFormatForRequests.format(dateTimeRange.end),
          ),
        );

  @override
  FutureOr<CreateTournamentEventOut> parse(List<int> bytes) {
    return compute(CreateTournamentEventOut.fromBuffer, bytes);
  }
}
