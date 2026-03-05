import 'dart:io';

String goldenPath(String name) {
  final isCi = Platform.environment['CI'] == 'true';
  final suffix = isCi ? '_ci' : '';
  return 'goldens/$name$suffix.png';
}
