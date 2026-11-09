@Timeout(Duration(seconds: 10))
library;

import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/domain/models/translation_key_model.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/translation_panel.dart';
import 'package:seating_generator_web/feature/translation_links/translation_table_links.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';

class _MockSeatingPageBloc extends MockBloc<SeatingPageEvent, SeatingPageState> implements SeatingPageBloc {}

class _FakeTranslationRepository implements TranslationRepository {
  @override
  Future<TranslationKeyModel> getKey({required int tournamentId}) => Future.value(
        const TranslationKeyModel(
          key: 'tournament-key',
          designs: [DesignModel(designKey: 'mafbase', title: 'Mafbase', preview: '')],
        ),
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeRepositoryFactory implements RepositoryFactory {
  @override
  final TranslationRepository translationRepository = _FakeTranslationRepository();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeDependencyScope implements DependencyScope {
  @override
  final RepositoryFactory repositoryFactory = _FakeRepositoryFactory();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _TestRouter extends RootStackRouter {
  _TestRouter(this.page);

  final Widget page;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: PageInfo('PlayersRoute', builder: (_) => page), path: '/'),
        AutoRoute(page: PageInfo(SeatingRoute.name, builder: (_) => page), path: '/tournament/:id/editSeating'),
      ];
}

TextStyle _testFont({double? fontSize, FontWeight? fontWeight, Color? color}) =>
    TextStyle(fontFamily: 'Roboto', fontSize: fontSize, fontWeight: fontWeight, color: color);

Future<_TestRouter> _pumpPanel(WidgetTester tester, {required int tablesCount, bool hasSeating = true}) async {
  final seatingBloc = _MockSeatingPageBloc();
  whenListen(
    seatingBloc,
    const Stream<SeatingPageState>.empty(),
    initialState: SeatingPageState(isLoading: false, games: hasSeating ? [[]] : []),
  );
  addTearDown(seatingBloc.close);

  final router = _TestRouter(
    BlocProvider<SeatingPageBloc>.value(
      value: seatingBloc,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: 268,
            child: TranslationPanel(tournamentId: 1, tablesCount: tablesCount, font: _testFont),
          ),
        ),
      ),
    ),
  );
  await tester.pumpWidget(
    DependencyScopeWidget(
      scope: _FakeDependencyScope(),
      child: MaterialApp.router(
        theme: AppTheme.light(isMobile: false),
        locale: const Locale('ru'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router.config(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return router;
}

void main() {
  testWidgets('shows both links for every table', (tester) async {
    await _pumpPanel(tester, tablesCount: 3);

    for (var table = 1; table <= 3; table++) {
      expect(find.text('Стол $table'), findsOneWidget);
    }
    expect(find.text('Ссылки по столам'), findsNothing);
    expect(find.text('Управление'), findsNWidgets(3));
    expect(find.text('Ссылка для OBS'), findsNWidgets(3));
  });

  testWidgets('more than four tables are collapsed under a header', (tester) async {
    await _pumpPanel(tester, tablesCount: 6);
    expect(find.text('Стол 1'), findsNothing);

    await tester.tap(find.text('Ссылки по столам'));
    await tester.pumpAndSettle();

    expect(find.text('Стол 1'), findsOneWidget);
    expect(find.text('Стол 6'), findsOneWidget);
  });

  testWidgets('copy all keeps the previous clipboard text', (tester) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') copied = (call.arguments as Map)['text'] as String?;
      return null;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));
    await _pumpPanel(tester, tablesCount: 2);

    await tester.tap(find.text('Скопировать ссылки для всех столов'));
    await tester.pump();

    final expected = translationLinksClipboardText(lookupAppLocalizations(const Locale('ru')), [
      for (var table = 1; table <= 2; table++)
        TranslationTableLinks.tournament(tournamentId: 1, table: table, key: 'tournament-key', designKey: 'mafbase'),
    ]);
    expect(copied, expected);
  });

  testWidgets('without tables copying is disabled and the list is empty', (tester) async {
    await _pumpPanel(tester, tablesCount: 0);

    final button = tester.widget<OutlinedButton>(
      find.ancestor(of: find.text('Скопировать ссылки для всех столов'), matching: find.bySubtype<OutlinedButton>()),
    );
    expect(button.onPressed, isNull);
    expect(find.text('Управление'), findsNothing);
  });

  testWidgets('go to seating does not open the seating page twice', (tester) async {
    final router = await _pumpPanel(tester, tablesCount: 0, hasSeating: false);

    await tester.tap(find.text('К рассадке'));
    await tester.pumpAndSettle();
    expect(router.stack.map((page) => page.name), ['PlayersRoute', SeatingRoute.name]);

    await tester.tap(find.text('К рассадке').last);
    await tester.pumpAndSettle();
    expect(router.stack.map((page) => page.name), ['PlayersRoute', SeatingRoute.name]);
  });
}
