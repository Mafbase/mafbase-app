@Timeout(Duration(seconds: 10))
library;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/feature/streams/ui/widgets/stream_operator_link_section.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils/platform.dart';

const _noRtmpHint = 'Для трансляции с телефона добавьте трансляцию этого стола с RTMP-сервером и ключом';
const _copyLabel = 'Ссылка оператора';
const _startLabel = 'Начать с этого телефона';

final _phoneStream = GameStreamAdmin(
  id: 1,
  tableNumber: 3,
  rtmpServerUrl: 'rtmp://ovsu.okcdn.ru/input/',
  rtmpKey: 'vk-stream-key',
  active: true,
  broadcastToken: 'operator-token',
);

final _noRtmpStream = GameStreamAdmin(id: 2, tableNumber: 3, active: true, broadcastToken: 'operator-token');

class _TestRouter extends RootStackRouter {
  _TestRouter(this.home);

  final Widget home;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: PageInfo('HomeRoute', builder: (_) => home), path: '/'),
        AutoRoute(
          page: PageInfo(
            BroadcastRoute.name,
            builder: (data) {
              final args = data.argsAs<BroadcastRouteArgs>();
              return Text('broadcast ${args.tournamentId}/${args.clubId}/${args.table}/${args.broadcastKey}');
            },
          ),
          path: '/broadcast',
        ),
      ];
}

Future<void> _pumpSection(WidgetTester tester, GameStreamAdmin stream, {bool isWeb = false, int? clubId}) async {
  debugIsWebOverride = isWeb;
  addTearDown(() => debugIsWebOverride = null);

  final router = _TestRouter(
    Scaffold(
      body: StreamOperatorLinkSection(
        tournamentId: clubId == null ? 42 : null,
        clubId: clubId,
        table: 3,
        stream: stream,
      ),
    ),
  );
  await tester.pumpWidget(
    MaterialApp.router(
      theme: AppTheme.light(isMobile: true),
      locale: const Locale('ru'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router.config(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('without RTMP server and key shows the hint instead of the operator link', (tester) async {
    await _pumpSection(tester, _noRtmpStream);

    expect(find.text(_noRtmpHint), findsOneWidget);
    expect(find.text(_copyLabel), findsNothing);
    expect(find.text(_startLabel), findsNothing);
  });

  testWidgets('in the app offers copy, share and start on this phone', (tester) async {
    await _pumpSection(tester, _phoneStream);

    expect(find.text(_copyLabel), findsOneWidget);
    expect(find.byTooltip('Поделиться'), findsOneWidget);
    expect(find.text(_startLabel), findsOneWidget);
  });

  testWidgets('in a browser offers only copy', (tester) async {
    await _pumpSection(tester, _phoneStream, isWeb: true);

    expect(find.text(_copyLabel), findsOneWidget);
    expect(find.byTooltip('Поделиться'), findsNothing);
    expect(find.text(_startLabel), findsNothing);
  });

  testWidgets('copy explains where the operator opens the link', (tester) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') copied = (call.arguments as Map)['text'] as String?;
      return null;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));
    await _pumpSection(tester, _phoneStream);

    await tester.tap(find.text(_copyLabel));
    await tester.pump();

    expect(copied, 'https://mafbase.ru/broadcast?tournamentId=42&table=3&key=operator-token');
    expect(
      find.text('Ссылка скопирована. Оператору нужно открыть её на телефоне с приложением Mafbase'),
      findsOneWidget,
    );
  });

  testWidgets('start on this phone opens the broadcast route of the table', (tester) async {
    await _pumpSection(tester, _phoneStream);

    await tester.tap(find.text(_startLabel));
    await tester.pumpAndSettle();

    expect(find.text('broadcast 42/0/3/operator-token'), findsOneWidget);
  });

  testWidgets('club table starts the broadcast with the club id', (tester) async {
    await _pumpSection(tester, _phoneStream, clubId: 7);

    await tester.tap(find.text(_startLabel));
    await tester.pumpAndSettle();

    expect(find.text('broadcast 0/7/3/operator-token'), findsOneWidget);
  });
}
