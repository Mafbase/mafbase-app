import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class EditPlayerRequest extends BaseRequest<void> {
  EditPlayerRequest(Player player) : super("/api/editPlayer", data: player);

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
