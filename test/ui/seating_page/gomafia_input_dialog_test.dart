@Timeout(Duration(seconds: 10))
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/ui/main/seating_page/widgets/gomafia_input_dialog.dart';

Widget _app(Widget child) => MaterialApp(
      theme: AppTheme.light(isMobile: false),
      locale: const Locale('ru'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );

void main() {
  testWidgets('warns that the current participants will be replaced', (tester) async {
    await tester.pumpWidget(_app(const GomafiaInputDialog(playersCount: 20)));

    expect(find.text('Текущий список участников (20) будет заменён участниками с GoMafia'), findsOneWidget);
    expect(find.text('Укажите ссылку на турнир'), findsOneWidget);
    expect(find.text('Подтвердить'), findsOneWidget);
  });

  testWidgets('has no warning when the tournament has no participants', (tester) async {
    await tester.pumpWidget(_app(const GomafiaInputDialog()));

    expect(find.textContaining('будет заменён'), findsNothing);
    expect(find.text('Укажите ссылку на турнир'), findsOneWidget);
  });
}
