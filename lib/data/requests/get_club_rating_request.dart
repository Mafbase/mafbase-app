import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

class GetClubRatingRequest extends BaseRequest<ClubRatingEventOut> {
  GetClubRatingRequest({
    required DateTimeRange? range,
    required int clubId,
  }) : super(_buildPath(clubId: clubId, range: range));

  // Без явного диапазона дат бэкенд сам применяет стандартный период клуба
  // (ClubDefaultRatingPeriod), а при его отсутствии — текущий месяц, и
  // возвращает фактический период в полях dateStart/dateEnd ответа.
  static String _buildPath({required int clubId, required DateTimeRange? range}) {
    if (range == null) {
      return '/api/club/$clubId/rating';
    }
    final start = dateFormatForRequests.format(range.start);
    final end = dateFormatForRequests.format(range.end);
    return '/api/club/$clubId/rating?date-start=$start&date-end=$end';
  }

  @override
  Future<ClubRatingEventOut> parse(List<int> bytes) {
    return compute(ClubRatingEventOut.fromBuffer, bytes);
  }
}
