import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> downloadFile({
  required Uint8List bytes,
  required String fileName,
}) async {
  final directory = await getTemporaryDirectory();
  final tempFile = File(join(directory.path, fileName));
  try {
    await tempFile.create();
    await tempFile.writeAsBytes(bytes);
    await SharePlus.instance.share(ShareParams(files: [XFile(tempFile.path)]));
  } finally {
    tempFile.delete();
  }
}
