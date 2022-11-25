import 'dart:async';
import 'dart:typed_data';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/data/http_client.dart';

class AddPhotoRequest extends BaseRequest<void> {
  final Uint8List bytes;
  final String filename;

  AddPhotoRequest({
    required int playerId,
    required this.bytes,
    required this.filename,
  }) : super('/api/playerProfile/$playerId/addPhoto');

  @override
  FutureOr<void> parse(List<int> bytes) {}

  @override
  Future<bool> execute(MyHttpClient client) async {
    await client.putFile(method, bytes, filename);
    return true;
  }
}
