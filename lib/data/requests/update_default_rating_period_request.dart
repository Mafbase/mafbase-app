import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

class UpdateDefaultRatingPeriodRequest extends BaseRequest<bool> {
  UpdateDefaultRatingPeriodRequest({required String clubId, required DateTimeRange? range})
      : super(
          '/api/club/$clubId/default-rating-period',
          forcePost: true,
          data: ClubDefaultRatingPeriod(
            dateStart: range == null ? '' : dateFormatForRequests.format(range.start),
            dateEnd: range == null ? '' : dateFormatForRequests.format(range.end),
          ),
        );

  @override
  FutureOr<bool> parse(List<int> bytes) => true;
}
