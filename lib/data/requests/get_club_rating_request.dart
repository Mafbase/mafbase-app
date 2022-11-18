import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetClubRatingRequest extends BaseRequest<ClubRatingEventOut> {
  static final DateFormat _format = DateFormat("yyyy-MM-dd");
  GetClubRatingRequest({
    required DateTimeRange range,
    required int clubId,
  }) : super("/api/club/$clubId/rating?date-start=${_format.format(range.start)}&date-end=${_format.format(range.end)}");

  @override
  ClubRatingEventOut parse(List<int> bytes) {
    return ClubRatingEventOut.fromBuffer(bytes);
  }
}
