import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isolated_worker/js_isolated_worker.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

class GetClubRatingRequest extends BaseRequest<ClubRatingEventOut> {
  GetClubRatingRequest({
    required DateTimeRange range,
    required int clubId,
  }) : super(
          "/api/club/$clubId/rating?date-start=${dateFormatForRequests.format(range.start)}&date-end=${dateFormatForRequests.format(range.end)}",
        );

  @override
  Future<ClubRatingEventOut> parse(List<int> bytes) {
    return compute(ClubRatingEventOut.fromBuffer, bytes);
    // final worker = JsIsolatedWorker()..importScripts(["main.dart.js"]);
    // return worker.run(
    //   functionName: [ClubRatingEventOut.getDefault().runtimeType.toString(), "fromBuffer"],
    //   arguments: bytes,
    //   fallback: () async {
    //     debugPrint("some fail");
    //     return null;
    //   },
    // ).then((value) {
    //   if (value is ClubRatingEventOut) {
    //     debugPrint("some success");
    //     return value;
    //   } else {
    //     debugPrint("some error");
    //     throw Error();
    //   }
    // }).timeout(Duration(seconds: 2));
  }
}
