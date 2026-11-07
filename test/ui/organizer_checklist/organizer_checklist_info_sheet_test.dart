@Timeout(Duration(seconds: 10))
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_help_image.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_info_sheet.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

const _body = 'Пояснение к пункту';
const _asset = 'assets/checklist/obs_browser_source_size.png';

Widget _app(Widget home) => MaterialApp(
      theme: AppTheme.light(isMobile: false),
      locale: const Locale('ru'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    );

/// Открывает лист по кнопке «open» и возвращает, сколько раз сработала каждая кнопка.
Future<Map<String, int>> _pumpAndOpen(
  WidgetTester tester, {
  bool withPrimary = true,
  bool withSecondary = true,
}) async {
  final taps = {'primary': 0, 'secondary': 0};
  await tester.pumpWidget(
    _app(
      Scaffold(
        body: Builder(
          builder: (context) => TextButton(
            onPressed: () => OrganizerChecklistInfoSheet.show(
              context,
              title: 'Заголовок',
              body: const [Text(_body)],
              primaryAction: withPrimary
                  ? OrganizerChecklistInfoSheetAction(
                      text: 'Сделать',
                      onTap: () => taps.update('primary', (count) => count + 1),
                    )
                  : null,
              secondaryAction: withSecondary
                  ? OrganizerChecklistInfoSheetAction(
                      text: 'Не нужно',
                      onTap: () => taps.update('secondary', (count) => count + 1),
                    )
                  : null,
            ),
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return taps;
}

/// Пустая страница; [nested] кладёт её во вложенный навигатор, как в приложении.
Future<BuildContext> _pumpPage(WidgetTester tester, {bool nested = false}) async {
  const page = Scaffold();
  await tester.pumpWidget(
    _app(nested ? Navigator(onGenerateRoute: (_) => MaterialPageRoute<void>(builder: (_) => page)) : page),
  );
  return tester.element(find.byType(Scaffold));
}

/// Лист с [body] и обеими кнопками действий.
Future<void> _openSheet(WidgetTester tester, BuildContext context, List<Widget> body) async {
  OrganizerChecklistInfoSheet.show(
    context,
    title: 'Заголовок',
    body: body,
    primaryAction: OrganizerChecklistInfoSheetAction(text: 'Сделать', onTap: () {}),
    secondaryAction: OrganizerChecklistInfoSheetAction(text: 'Не нужно', onTap: () {}),
  );
  await tester.pumpAndSettle();
}

void _setScreenHeight(WidgetTester tester, double height) {
  tester.view.physicalSize = Size(800, height);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

ScrollPosition _sheetScroll(WidgetTester tester) => tester
    .state<ScrollableState>(
      find.descendant(of: find.byType(OrganizerChecklistInfoSheet), matching: find.byType(Scrollable)),
    )
    .position;

/// Каждая сторона [actual] лежит строго между теми же сторонами [from] и [to].
void _expectBetween(Rect actual, Rect from, Rect to) {
  List<double> sides(Rect rect) => [rect.left, rect.top, rect.right, rect.bottom];
  for (final (index, value) in sides(actual).indexed) {
    final (a, b) = (sides(from)[index], sides(to)[index]);
    expect(value, inExclusiveRange(math.min(a, b), math.max(a, b)), reason: 'side $index of $actual: $from → $to');
  }
}

void main() {
  testWidgets('primary action closes the sheet and runs once', (tester) async {
    final taps = await _pumpAndOpen(tester);

    await tester.tap(find.text('Сделать'));
    await tester.pumpAndSettle();

    expect(find.text(_body), findsNothing);
    expect(taps, {'primary': 1, 'secondary': 0});
  });

  testWidgets('secondary action closes the sheet and runs once', (tester) async {
    final taps = await _pumpAndOpen(tester);

    await tester.tap(find.text('Не нужно'));
    await tester.pumpAndSettle();

    expect(find.text(_body), findsNothing);
    expect(taps, {'primary': 0, 'secondary': 1});
  });

  testWidgets('without actions only the question link stays, close runs nothing', (tester) async {
    final taps = await _pumpAndOpen(tester, withPrimary: false, withSecondary: false);

    expect(find.byType(ElevatedButton), findsNothing);
    expect(find.text('Задать вопрос'), findsOneWidget);

    await tester.tap(find.byType(CloseButton));
    await tester.pumpAndSettle();

    expect(find.text(_body), findsNothing);
    expect(taps, {'primary': 0, 'secondary': 0});
  });

  testWidgets('the barrier, Escape and a drag down close the sheet and complete show', (tester) async {
    final context = await _pumpPage(tester);
    var closed = 0;
    Future<void> open() async {
      OrganizerChecklistInfoSheet.show(context, title: 'Заголовок', body: const [Text(_body)]).then((_) => closed++);
      await tester.pumpAndSettle();
    }

    await open();
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(closed, 1);

    await open();
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(closed, 2);

    await open();
    final gesture = await tester.startGesture(tester.getCenter(find.text('Заголовок')));
    await gesture.moveBy(const Offset(0, 40));
    await tester.pump();
    final top = tester.getTopLeft(find.byType(OrganizerChecklistInfoSheet)).dy;
    await gesture.moveBy(const Offset(0, 40));
    await tester.pump();
    expect(tester.getTopLeft(find.byType(OrganizerChecklistInfoSheet)).dy, moreOrLessEquals(top + 40));
    await gesture.moveBy(const Offset(0, 200));
    await gesture.up();
    await tester.pumpAndSettle();
    expect(closed, 3);
    expect(find.text(_body), findsNothing);
  });

  testWidgets('a short sheet is as tall as its content and does not scroll', (tester) async {
    _setScreenHeight(tester, 1000);
    await _openSheet(tester, await _pumpPage(tester), const [Text(_body)]);

    expect(tester.getSize(find.byType(OrganizerChecklistInfoSheet)).height, lessThan(500));
    expect(_sheetScroll(tester).maxScrollExtent, 0);
  });

  testWidgets('a long sheet stops at 90% of the screen and scrolls between the title and the buttons', (tester) async {
    _setScreenHeight(tester, 1000);
    await _openSheet(tester, await _pumpPage(tester), [for (var i = 1; i <= 40; i++) Text('Абзац $i')]);

    expect(tester.getSize(find.byType(OrganizerChecklistInfoSheet)).height, moreOrLessEquals(900));
    expect(find.text('Задать вопрос').hitTestable(), findsOneWidget);
    final title = tester.getRect(find.text('Заголовок'));
    final button = tester.getRect(find.text('Сделать'));

    await tester.drag(find.text('Абзац 2'), const Offset(0, -300));
    await tester.pumpAndSettle();

    expect(_sheetScroll(tester).pixels, greaterThan(0));
    expect(tester.getRect(find.text('Заголовок')), title);
    expect(tester.getRect(find.text('Сделать')), button);
  });

  for (final nested in [false, true]) {
    testWidgets('the screenshot flies to the full screen from a sheet in the ${nested ? 'nested' : 'root'} navigator',
        (tester) async {
      final context = await _pumpPage(tester, nested: nested);
      await _openSheet(tester, context, const [OrganizerChecklistHelpImage(asset: _asset)]);
      // Картинка декодируется движком вне fake async теста.
      await tester.runAsync(() => precacheImage(const AssetImage(_asset), context));
      await tester.pump();
      // На время полёта Hero прячет RawImage превью и просмотра: на экране остаётся только летящая копия.
      final picture = find.byType(RawImage);
      final preview = tester.getRect(picture);

      await tester.tap(find.byType(OrganizerChecklistHelpImage));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 150));
      expect(picture, findsOneWidget);
      final flight = tester.getRect(picture);
      await tester.pumpAndSettle();

      _expectBetween(flight, preview, tester.getRect(picture));
    });
  }
}
