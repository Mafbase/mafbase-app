import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/common/widgets/side_status_bar_adapter.dart';

const _screenSize = Size(951, 669);
const _probeKey = Key('probe');
const _duoRightPadding = EdgeInsets.fromLTRB(0, 0, 84, 34);
const _topInset = SideStatusBarAdapter.topInset;

final _ios = TargetPlatformVariant.only(TargetPlatform.iOS);

late MediaQueryData _probeMediaQuery;
bool? _probeCenterTitle;
var _probeInitCount = 0;

class _Probe extends StatefulWidget {
  const _Probe() : super(key: _probeKey);

  @override
  State<_Probe> createState() => _ProbeState();
}

class _ProbeState extends State<_Probe> {
  @override
  void initState() {
    super.initState();
    _probeInitCount++;
  }

  @override
  Widget build(BuildContext context) {
    _probeMediaQuery = MediaQuery.of(context);
    _probeCenterTitle = Theme.of(context).appBarTheme.centerTitle;
    return const SizedBox.expand();
  }
}

Future<void> _pump(WidgetTester tester, EdgeInsets padding) async {
  tester.view.physicalSize = _screenSize * 3;
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(size: _screenSize, devicePixelRatio: 3, padding: padding, viewPadding: padding),
      child: Theme(
        data: ThemeData(appBarTheme: const AppBarTheme(centerTitle: true)),
        child: const SideStatusBarAdapter(child: _Probe()),
      ),
    ),
  );
}

Finder _inAdapter(Type type) => find.descendant(of: find.byType(SideStatusBarAdapter), matching: find.byType(type));

void _expectFullScreen(WidgetTester tester) {
  expect(_probeMediaQuery.size, _screenSize);
  expect(tester.getRect(find.byKey(_probeKey)), Offset.zero & _screenSize);
  expect(_inAdapter(Row), findsNothing);
  expect(_inAdapter(ColoredBox), findsNothing);
}

void _expectUnchanged(WidgetTester tester, EdgeInsets padding) {
  expect(_probeMediaQuery.padding, padding);
  expect(_probeMediaQuery.viewPadding, padding);
  expect(_probeCenterTitle, isTrue);
  _expectFullScreen(tester);
}

void main() {
  setUp(() => _probeInitCount = 0);

  testWidgets(
    'капсула справа: отступ справа сохраняется, сверху добавляется отступ, заголовок слева',
    (tester) async {
      await _pump(tester, _duoRightPadding);

      const expectedPadding = EdgeInsets.fromLTRB(0, _topInset, 84, 34);
      expect(_probeMediaQuery.padding, expectedPadding);
      expect(_probeMediaQuery.viewPadding, expectedPadding);
      expect(_probeCenterTitle, isFalse);
      _expectFullScreen(tester);
    },
    variant: _ios,
  );

  testWidgets(
    'капсула слева: отступ слева сохраняется, сверху добавляется отступ',
    (tester) async {
      await _pump(tester, const EdgeInsets.fromLTRB(84, 0, 0, 34));

      const expectedPadding = EdgeInsets.fromLTRB(84, _topInset, 0, 34);
      expect(_probeMediaQuery.padding, expectedPadding);
      expect(_probeMediaQuery.viewPadding, expectedPadding);
      expect(_probeCenterTitle, isFalse);
      _expectFullScreen(tester);
    },
    variant: _ios,
  );

  testWidgets(
    'другие раскладки iOS не меняет',
    (tester) async {
      for (final padding in const [
        EdgeInsets.fromLTRB(59, 0, 59, 21),
        EdgeInsets.fromLTRB(0, 59, 0, 34),
        EdgeInsets.fromLTRB(0, 24, 84, 20),
        EdgeInsets.zero,
      ]) {
        await _pump(tester, padding);
        _expectUnchanged(tester, padding);
      }
    },
    variant: _ios,
  );

  testWidgets(
    'на Android ничего не меняет и не добавляет виджетов',
    (tester) async {
      await _pump(tester, _duoRightPadding);

      _expectUnchanged(tester, _duoRightPadding);
      expect(_inAdapter(MediaQuery), findsNothing);
      expect(_inAdapter(Theme), findsNothing);
    },
    variant: TargetPlatformVariant.only(TargetPlatform.android),
  );

  testWidgets(
    'смена раскладки пересчитывает отступы и сохраняет состояние приложения',
    (tester) async {
      await _pump(tester, _duoRightPadding);
      expect(_probeMediaQuery.padding.top, _topInset);

      const symmetric = EdgeInsets.fromLTRB(59, 0, 59, 21);
      await _pump(tester, symmetric);
      _expectUnchanged(tester, symmetric);

      await _pump(tester, _duoRightPadding);
      expect(_probeMediaQuery.padding.top, _topInset);
      expect(_probeCenterTitle, isFalse);
      expect(_probeInitCount, 1);
    },
    variant: _ios,
  );
}
