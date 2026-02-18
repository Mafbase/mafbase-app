import 'dart:async';
import 'dart:typed_data';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/data/http_client.dart';

class EditClubDescriptionPhotoRequest extends BaseRequest<void> {
  final Uint8List bytes;
  final String filename;

  EditClubDescriptionPhotoRequest({
    required int clubId,
    required this.bytes,
    required this.filename,
  }) : super('/api/club/$clubId/club-description/editPhoto');

  @override
  FutureOr<void> parse(List<int> bytes) {}

  @override
  Future<void> execute(MyHttpClient client) async {
    await client.putFile(method, bytes, filename);
  }
}
