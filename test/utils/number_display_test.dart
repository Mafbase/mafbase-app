import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/utils/number_display.dart';

void main() {
  group('NumDisplayExt.toDisplayString', () {
    test('drops .0 from whole doubles', () {
      expect(2.0.toDisplayString(), '2');
      expect(0.0.toDisplayString(), '0');
      expect((-3.0).toDisplayString(), '-3');
      expect((100 / 100).toDisplayString(), '1');
      expect(1e20.toDisplayString(), '100000000000000000000');
    });

    test('keeps fractional doubles as is', () {
      expect(0.5.toDisplayString(), '0.5');
      expect((-1.25).toDisplayString(), '-1.25');
      expect((7 / 2).toDisplayString(), '3.5');
      expect((1 / 3).toDisplayString(), '0.3333333333333333');
      expect((0.1 + 0.2).toDisplayString(), '0.30000000000000004');
    });

    test('matches dart2js for special values', () {
      expect((-0.0).toDisplayString(), '-0.0');
      expect(1e21.toDisplayString(), '1e+21');
      expect(1e-7.toDisplayString(), '1e-7');
      expect(double.nan.toDisplayString(), 'NaN');
      expect(double.infinity.toDisplayString(), 'Infinity');
    });

    test('leaves ints unchanged', () {
      expect(2.toDisplayString(), '2');
      expect((-15).toDisplayString(), '-15');
      expect(0.toDisplayString(), '0');
    });
  });
}
