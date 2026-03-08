import 'dart:async';
import 'dart:typed_data';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/data/http_client.dart';

class AddThemePhotoRequest extends BaseRequest<void> {
  final Uint8List bytes;
  final String filename;

  AddThemePhotoRequest({
    required int themeId,
    required int playerId,
    required this.bytes,
    required this.filename,
  }) : super('/api/photoThemes/$themeId/players/$playerId/photo');

  @override
  FutureOr<void> parse(List<int> bytes) {}

  @override
  Future<bool> execute(MyHttpClient client) async {
    await client.putFile(method, bytes, filename);
    return true;
  }
}
