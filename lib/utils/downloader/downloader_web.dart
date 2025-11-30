import 'dart:typed_data';
import 'package:web/web.dart' as web;

Future<void> downloadFile({
  required Uint8List bytes,
  required String fileName,
}) async =>
    web.HTMLAnchorElement()
      ..href = Uri.dataFromBytes(bytes).toString()
      ..download = fileName
      ..click();
