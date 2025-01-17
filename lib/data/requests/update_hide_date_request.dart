import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart'
    as proto;
import 'package:seating_generator_web/utils.dart';

class UpdateHideDateRequest extends BaseRequest<bool> {
  UpdateHideDateRequest({required String clubId, required DateTime? dateTime})
      : super(
          "/api/club/$clubId/hide-date",
          data: proto.UpdateHideDateRequest(
            date:
                dateTime == null ? "" : dateFormatForRequests.format(dateTime),
          ),
        );

  @override
  FutureOr<bool> parse(List<int> bytes) => true;
}
