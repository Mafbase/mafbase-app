@Timeout(Duration(seconds: 10))
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_info_sheet.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

const _body = 'Пояснение к пункту';

/// Открывает лист по кнопке «open» и возвращает, сколько раз сработала каждая кнопка.
Future<Map<String, int>> _pumpAndOpen(
  WidgetTester tester, {
  bool withPrimary = true,
  bool withSecondary = true,
}) async {
  final taps = {'primary': 0, 'secondary': 0};
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(isMobile: false),
      locale: const Locale('ru'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
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
}
