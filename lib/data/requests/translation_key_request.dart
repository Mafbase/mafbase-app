import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class TranslationKeyRequest extends BaseRequest<TranslationKeyEventOut> {
  TranslationKeyRequest({
    required int tournamentId,
  }) : super('/api/translation-key/$tournamentId');

  @override
  FutureOr<TranslationKeyEventOut> parse(List<int> bytes) => compute(TranslationKeyEventOut.fromBuffer, bytes);
}
