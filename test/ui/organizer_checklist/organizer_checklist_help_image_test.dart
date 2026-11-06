@Timeout(Duration(seconds: 20))
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_help_image.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

const _asset = 'assets/checklist/obs_browser_source_size.png';

Future<void> _pumpLoadedImage(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(isMobile: false),
      locale: const Locale('ru'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(
        body: SizedBox(width: 400, child: OrganizerChecklistHelpImage(asset: _asset)),
      ),
    ),
  );
  // Картинка декодируется движком вне fake async теста.
  await tester.runAsync(() => precacheImage(const AssetImage(_asset), tester.element(find.byType(Scaffold))));
  await tester.pump();
}

void main() {
  testWidgets('a screenshot fits the width and keeps its proportions', (tester) async {
    await _pumpLoadedImage(tester);

    final size = tester.getSize(find.byType(Image));
    expect(size.width, 400);
    expect(size.height, closeTo(400 * 376 / 1536, 0.5));
  });

  testWidgets('a tap opens the screenshot full screen, the close button returns to the sheet', (tester) async {
    await _pumpLoadedImage(tester);

    await tester.tap(find.byType(OrganizerChecklistHelpImage));
    await tester.pumpAndSettle();
    expect(find.byType(InteractiveViewer), findsOneWidget);

    await tester.tap(find.byType(CloseButton));
    await tester.pumpAndSettle();
    expect(find.byType(InteractiveViewer), findsNothing);
    expect(find.byType(OrganizerChecklistHelpImage), findsOneWidget);
  });
}
