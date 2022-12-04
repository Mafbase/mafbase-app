import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/utils.dart';

void main() {
  test('test sentry url', () {
    expect(
      sentryUrl,
      "https://9d5e563b2cf94d10b64bff4708a169dc@o4503907503570944.ingest.sentry.io/4503907504685056",
    );
  });
}
