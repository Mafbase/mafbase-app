@Timeout(Duration(seconds: 10))
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/domain/repositories/stream_repository.dart';
import 'package:seating_generator_web/feature/streams/ui/broadcast_page.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils/platform.dart';

const _appRequiredTitle = 'Трансляция запускается в приложении Mafbase на телефоне';

class _RecordingStreamRepository implements StreamRepository {
  int credentialsRequests = 0;

  @override
  Future<BroadcastCredentialsOut> getBroadcastCredentials({
    int? tournamentId,
    int? clubId,
    required int table,
    required String key,
  }) {
    credentialsRequests++;
    return Future.error(Exception('offline'));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeRepositoryFactory implements RepositoryFactory {
  _FakeRepositoryFactory(this.streamRepository);

  @override
  final StreamRepository streamRepository;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeDependencyScope implements DependencyScope {
  _FakeDependencyScope(this.repositoryFactory);

  @override
  final RepositoryFactory repositoryFactory;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<_RecordingStreamRepository> _pumpPage(WidgetTester tester, {required bool isWeb}) async {
  debugIsWebOverride = isWeb;
  addTearDown(() => debugIsWebOverride = null);

  final repository = _RecordingStreamRepository();
  await tester.pumpWidget(
    DependencyScopeWidget(
      scope: _FakeDependencyScope(_FakeRepositoryFactory(repository)),
      child: MaterialApp(
        theme: AppTheme.light(isMobile: true),
        locale: const Locale('ru'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const BroadcastPage(tournamentId: 7, table: 2, broadcastKey: 'operator-token'),
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
  return repository;
}

void main() {
  testWidgets('in a browser explains the app and never requests credentials', (tester) async {
    final repository = await _pumpPage(tester, isWeb: true);

    expect(find.text(_appRequiredTitle), findsOneWidget);
    expect(find.text('App Store'), findsOneWidget);
    expect(find.text('RuStore'), findsOneWidget);
    expect(repository.credentialsRequests, 0);
  });

  testWidgets('in a browser copies the current page address', (tester) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') copied = (call.arguments as Map)['text'] as String?;
      return null;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));
    await _pumpPage(tester, isWeb: true);

    await tester.tap(find.text('Скопировать ссылку'));
    await tester.pump();

    expect(copied, Uri.base.toString());
    expect(find.text('Ссылка скопирована'), findsOneWidget);
  });

  testWidgets('in the app requests credentials to open the stream screen', (tester) async {
    final repository = await _pumpPage(tester, isWeb: false);

    expect(repository.credentialsRequests, 1);
    expect(find.text(_appRequiredTitle), findsNothing);
  });
}
