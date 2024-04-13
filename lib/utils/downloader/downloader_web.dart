import 'dart:html' show AnchorElement;
import 'dart:typed_data';

Future<void> downloadFile({
  required Uint8List bytes,
  required String fileName,
}) async =>
    AnchorElement()
      ..href = Uri.dataFromBytes(bytes).toString()
      ..download = fileName
      ..click();
