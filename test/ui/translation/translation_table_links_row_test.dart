@Timeout(Duration(seconds: 10))
library;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/feature/translation_links/translation_table_links.dart';
import 'package:seating_generator_web/feature/translation_links/widgets/translation_table_links_row.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/utils/platform.dart';

const _links = TranslationTableLinks.tournament(tournamentId: 42, table: 3, key: 'k', designKey: 'mafbase');

class _TestRouter extends RootStackRouter {
  _TestRouter(this.home);

  final Widget home;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: PageInfo('HomeRoute', builder: (_) => home), path: '/'),
        AutoRoute(
          page: PageInfo(
            TranslationControlRoute.name,
            builder: (data) {
              final args = data.argsAs<TranslationControlRouteArgs>();
              return Text('control ${args.tournamentId}/${args.clubId}/${args.table}/${args.translationKey}');
            },
          ),
          path: '/translationControl',
        ),
      ];
}

Future<void> _pumpRow(WidgetTester tester, {bool isWeb = false, double width = 600}) async {
  debugIsWebOverride = isWeb;
  addTearDown(() => debugIsWebOverride = null);

  final router = _TestRouter(
    Scaffold(
      body: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(width: width, child: const TranslationTableLinksRow(links: _links)),
      ),
    ),
  );
  await tester.pumpWidget(
    MaterialApp.router(
      theme: AppTheme.light(isMobile: false),
      locale: const Locale('ru'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router.config(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('in the app the OBS link can be shared but not opened', (tester) async {
    await _pumpRow(tester);

    expect(find.text('Стол 3'), findsOneWidget);
    expect(find.byTooltip('Открыть'), findsOneWidget);
    expect(find.byTooltip('Скопировать'), findsNWidgets(2));
    expect(find.byTooltip('Поделиться'), findsOneWidget);
  });

  testWidgets('in a browser the OBS link can be opened but not shared', (tester) async {
    await _pumpRow(tester, isWeb: true);

    expect(find.byTooltip('Открыть'), findsNWidgets(2));
    expect(find.byTooltip('Скопировать'), findsNWidgets(2));
    expect(find.byTooltip('Поделиться'), findsNothing);
  });

  testWidgets('in the app open shows the control page of the table inside the app', (tester) async {
    await _pumpRow(tester);

    await tester.tap(find.byTooltip('Открыть'));
    await tester.pumpAndSettle();

    expect(find.text('control 42/0/3/k'), findsOneWidget);
  });

  testWidgets('copy puts the control link to the clipboard', (tester) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') copied = (call.arguments as Map)['text'] as String?;
      return null;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));
    await _pumpRow(tester);

    await tester.tap(find.byTooltip('Скопировать').first);
    await tester.pump();

    expect(copied, _links.control);
    expect(find.text('Ссылка скопирована'), findsOneWidget);
  });

  testWidgets('fits one line when wide and stacks when narrow', (tester) async {
    await _pumpRow(tester, width: 600);
    expect(tester.getTopLeft(find.text('Управление')).dy, tester.getTopLeft(find.text('Ссылка для OBS')).dy);

    await _pumpRow(tester, width: 260);
    expect(
      tester.getTopLeft(find.text('Ссылка для OBS')).dy,
      greaterThan(tester.getTopLeft(find.text('Управление')).dy),
    );
    expect(tester.takeException(), isNull);
  });
}
