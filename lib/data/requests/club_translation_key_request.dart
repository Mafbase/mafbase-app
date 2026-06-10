import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class ClubTranslationKeyRequest extends BaseRequest<ClubTranslationKeyEventOut> {
  ClubTranslationKeyRequest({required int clubId}) : super('/api/club-translation-key/$clubId');

  @override
  FutureOr<ClubTranslationKeyEventOut> parse(List<int> bytes) => compute(ClubTranslationKeyEventOut.fromBuffer, bytes);
}
