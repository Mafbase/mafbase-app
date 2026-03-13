import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

class ClubTablesRatingRequest extends BaseRequest<SeatingEventOut> {
  ClubTablesRatingRequest({
    required DateTimeRange range,
    required int clubId,
  }) : super(
          '/api/club/$clubId/tables-rating?date-start=${dateFormatForRequests.format(range.start)}&date-end=${dateFormatForRequests.format(range.end)}',
        );

  @override
  Future<SeatingEventOut> parse(List<int> bytes) {
    return compute(SeatingEventOut.fromBuffer, bytes);
  }
}
