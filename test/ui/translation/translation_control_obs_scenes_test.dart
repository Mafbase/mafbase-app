@Timeout(Duration(seconds: 10))
library;

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/domain/repositories/club_translation_repository.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/photo_theme_repository.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_state.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/club_translation_control_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/club_translation_control_event.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_event.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/widgets/translation_control_obs_section.dart';

class _RequestFailed implements Exception {}

/// Запросы на сохранение сопоставления висят, пока тест не завершит их сам — это «нет эха из сокета».
class _PendingObsRequests {
  final requests = <ObsSceneMapping>[];
  final _completers = <Completer<void>>[];

  Future<void> add(ObsSceneMapping mapping) {
    requests.add(mapping);
    final completer = Completer<void>();
    _completers.add(completer);
    return completer.future;
  }

  void completeAll() {
    for (final c in _completers.where((c) => !c.isCompleted)) {
      c.complete();
    }
  }

  void failAll() {
    for (final c in _completers.where((c) => !c.isCompleted)) {
      c.completeError(_RequestFailed());
    }
  }
}

class _FakeTranslationRepository extends Fake implements TranslationRepository {
  final obsRequests = _PendingObsRequests();

  @override
  Future changeObsScenes({
    required ObsSceneMapping mapping,
    required int table,
    required int tournamentId,
    required String key,
  }) =>
      obsRequests.add(mapping);
}

class _FakeClubTranslationRepository extends Fake implements ClubTranslationRepository {
  final obsRequests = _PendingObsRequests();

  @override
  Future<void> changeObsScenes({
    required ObsSceneMapping mapping,
    required int clubId,
    required int table,
    required String key,
  }) =>
      obsRequests.add(mapping);
}

class _UnusedClubRepository extends Fake implements ClubRepository {}

class _UnusedPhotoThemeRepository extends Fake implements PhotoThemeRepository {}

TranslationControlBloc _tournamentBloc(_FakeTranslationRepository repository) => TranslationControlBloc(
      params: TranslationContentBlocParams(tournamentId: 1, table: 1, key: 'key'),
      repository: repository,
    );

ClubTranslationControlBloc _clubBloc(_FakeClubTranslationRepository repository) => ClubTranslationControlBloc(
      params: ClubTranslationControlBlocParams(clubId: 1, table: 1, key: 'key'),
      repository: repository,
      clubRepository: _UnusedClubRepository(),
      photoThemeRepository: _UnusedPhotoThemeRepository(),
    );

final _readyObs = ObsState(connected: true, controlLevel: 4, scenes: ['Стол', 'Ночной план', 'Заставка']);

final _saved = ObsSceneMapping(day: 'Стол');
final _changed = ObsSceneMapping(day: 'Стол', night: 'Ночной план');
final _fromSocket = ObsSceneMapping(breakPhase: 'Заставка');
final _stale = ObsSceneMapping(night: 'Заставка');

/// BLoC пробрасывает ошибку обработчика в зону, где он создан; blocTest в этом случае не проверяет `expect`,
/// поэтому сценарии с ошибкой запроса идут в своей зоне, которая собирает такие ошибки.
Future<List<Object>> _runCollectingErrors(Future<void> Function() body) {
  final errors = <Object>[];
  final done = Completer<List<Object>>();
  runZonedGuarded(
    () async {
      try {
        await body();
        done.complete(errors);
      } catch (error, stackTrace) {
        done.completeError(error, stackTrace);
      }
    },
    (error, _) => errors.add(error),
  );
  return done.future;
}

Matcher _withObsScenes(ObsSceneMapping? mapping) =>
    isA<TranslationContentState>().having((s) => s.obsScenes, 'obsScenes', mapping);

/// Секция OBS, подключённая к BLoC так же, как на странице управления.
Widget _obsSectionFor<B extends StateStreamable<TranslationContentState>>(
  B bloc,
  void Function(ObsSceneMapping mapping) onChanged,
) =>
    MaterialApp(
      theme: AppTheme.light(isMobile: false),
      locale: const Locale('ru'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocBuilder<B, TranslationContentState>(
          bloc: bloc,
          builder: (context, state) => TranslationControlObsSection(
            obs: _readyObs,
            mapping: state.obsScenes,
            onMappingChanged: onChanged,
            rowBuilder: (obsHeader) => Row(children: [const Expanded(child: SizedBox(height: 52)), obsHeader]),
          ),
        ),
      ),
    );

Future<void> _expandObsPanel(WidgetTester tester) async {
  await tester.tap(find.text('OBS'));
  await tester.pumpAndSettle();
}

Future<void> _select(WidgetTester tester, {required int row, required String item}) async {
  await tester.tap(find.byType(DropdownButton<String>).at(row));
  await tester.pumpAndSettle();
  // DropdownButton держит все пункты в IndexedStack кнопки, пункт открытого меню — последний в дереве.
  await tester.tap(find.text(item).last);
  await tester.pumpAndSettle();
}

void main() {
  group('TranslationControlBloc changeObsScenes', () {
    late _FakeTranslationRepository repository;

    setUp(() => repository = _FakeTranslationRepository());
    tearDown(() => repository.obsRequests.completeAll());

    testWidgets('quick selections without socket echo keep both phases', (tester) async {
      final bloc = _tournamentBloc(repository);
      await tester.pumpWidget(
        _obsSectionFor(bloc, (mapping) => bloc.add(TranslationControlEvent.changeObsScenes(mapping: mapping))),
      );
      await _expandObsPanel(tester);

      await _select(tester, row: 0, item: 'Стол');
      await _select(tester, row: 1, item: 'Ночной план');

      expect(repository.obsRequests.requests, [_saved, _changed]);
      repository.obsRequests.completeAll();
      await tester.pump();
      // Внутри FakeAsync-зоны testWidgets bloc.close() не завершается, закрываем в реальной зоне.
      await tester.runAsync(bloc.close);
    });

    testWidgets('stale socket content during the save keeps the choice', (tester) async {
      final bloc = _tournamentBloc(repository);
      await tester.pumpWidget(
        _obsSectionFor(bloc, (mapping) => bloc.add(TranslationControlEvent.changeObsScenes(mapping: mapping))),
      );
      await _expandObsPanel(tester);

      await _select(tester, row: 0, item: 'Стол');
      bloc.add(TranslationControlEvent.stateReceived(event: SeatingContent(obsScenes: _stale)));
      await tester.pumpAndSettle();
      expect(bloc.state.obsScenes, _saved);

      await _select(tester, row: 1, item: 'Ночной план');

      expect(repository.obsRequests.requests, [_saved, _changed]);
      repository.obsRequests.completeAll();
      await tester.pump();
      await tester.runAsync(bloc.close);
    });

    blocTest<TranslationControlBloc, TranslationContentState>(
      'applies the mapping before the request completes',
      build: () => _tournamentBloc(repository),
      act: (bloc) async {
        bloc.add(TranslationControlEvent.changeObsScenes(mapping: _changed));
        await pumpEventQueue();
        repository.obsRequests.completeAll();
      },
      expect: () => [_withObsScenes(_changed)],
      verify: (_) => expect(repository.obsRequests.requests, [_changed]),
    );

    test('rolls back to the previous mapping when the request fails', () async {
      final states = <TranslationContentState>[];
      final errors = await _runCollectingErrors(() async {
        final bloc = _tournamentBloc(repository)
          ..add(TranslationControlEvent.stateReceived(event: SeatingContent(obsScenes: _saved)));
        await pumpEventQueue();
        final subscription = bloc.stream.listen(states.add);
        bloc.add(TranslationControlEvent.changeObsScenes(mapping: _changed));
        await pumpEventQueue();
        repository.obsRequests.failAll();
        await pumpEventQueue();
        await bloc.close();
        await subscription.cancel();
      });

      expect(states, [_withObsScenes(_changed), _withObsScenes(_saved)]);
      expect(errors, [isA<_RequestFailed>()]);
    });

    test('falls back to the latest mapping from the socket when the request fails', () async {
      final states = <TranslationContentState>[];
      final errors = await _runCollectingErrors(() async {
        final bloc = _tournamentBloc(repository)
          ..add(TranslationControlEvent.stateReceived(event: SeatingContent(obsScenes: _saved)));
        await pumpEventQueue();
        final subscription = bloc.stream.listen(states.add);
        bloc.add(TranslationControlEvent.changeObsScenes(mapping: _changed));
        await pumpEventQueue();
        bloc.add(TranslationControlEvent.stateReceived(event: SeatingContent(obsScenes: _fromSocket)));
        await pumpEventQueue();
        expect(bloc.state.obsScenes, _changed);
        repository.obsRequests.failAll();
        await pumpEventQueue();
        await bloc.close();
        await subscription.cancel();
      });

      expect(states, [_withObsScenes(_changed), _withObsScenes(_fromSocket)]);
      expect(errors, [isA<_RequestFailed>()]);
    });
  });

  group('ClubTranslationControlBloc changeObsScenes', () {
    late _FakeClubTranslationRepository repository;

    setUp(() => repository = _FakeClubTranslationRepository());
    tearDown(() => repository.obsRequests.completeAll());

    testWidgets('quick selections without socket echo keep both phases', (tester) async {
      final bloc = _clubBloc(repository);
      await tester.pumpWidget(
        _obsSectionFor(bloc, (mapping) => bloc.add(ClubTranslationControlEvent.changeObsScenes(mapping: mapping))),
      );
      await _expandObsPanel(tester);

      await _select(tester, row: 0, item: 'Стол');
      await _select(tester, row: 1, item: 'Ночной план');

      expect(repository.obsRequests.requests, [_saved, _changed]);
      repository.obsRequests.completeAll();
      await tester.pump();
      // Внутри FakeAsync-зоны testWidgets bloc.close() не завершается, закрываем в реальной зоне.
      await tester.runAsync(bloc.close);
    });

    testWidgets('stale socket content during the save keeps the choice', (tester) async {
      final bloc = _clubBloc(repository);
      await tester.pumpWidget(
        _obsSectionFor(bloc, (mapping) => bloc.add(ClubTranslationControlEvent.changeObsScenes(mapping: mapping))),
      );
      await _expandObsPanel(tester);

      await _select(tester, row: 0, item: 'Стол');
      bloc.add(ClubTranslationControlEvent.stateReceived(content: ClubSeatingContent(obsScenes: _stale)));
      await tester.pumpAndSettle();
      expect(bloc.state.obsScenes, _saved);

      await _select(tester, row: 1, item: 'Ночной план');

      expect(repository.obsRequests.requests, [_saved, _changed]);
      repository.obsRequests.completeAll();
      await tester.pump();
      await tester.runAsync(bloc.close);
    });

    blocTest<ClubTranslationControlBloc, TranslationContentState>(
      'applies the mapping before the request completes',
      build: () => _clubBloc(repository),
      act: (bloc) async {
        bloc.add(ClubTranslationControlEvent.changeObsScenes(mapping: _changed));
        await pumpEventQueue();
        repository.obsRequests.completeAll();
      },
      expect: () => [_withObsScenes(_changed)],
      verify: (_) => expect(repository.obsRequests.requests, [_changed]),
    );

    test('rolls back to the previous mapping when the request fails', () async {
      final states = <TranslationContentState>[];
      final errors = await _runCollectingErrors(() async {
        final bloc = _clubBloc(repository)
          ..add(ClubTranslationControlEvent.stateReceived(content: ClubSeatingContent(obsScenes: _saved)));
        await pumpEventQueue();
        final subscription = bloc.stream.listen(states.add);
        bloc.add(ClubTranslationControlEvent.changeObsScenes(mapping: _changed));
        await pumpEventQueue();
        repository.obsRequests.failAll();
        await pumpEventQueue();
        await bloc.close();
        await subscription.cancel();
      });

      expect(states, [_withObsScenes(_changed), _withObsScenes(_saved)]);
      expect(errors, [isA<_RequestFailed>()]);
    });

    test('falls back to the latest mapping from the socket when the request fails', () async {
      final states = <TranslationContentState>[];
      final errors = await _runCollectingErrors(() async {
        final bloc = _clubBloc(repository)
          ..add(ClubTranslationControlEvent.stateReceived(content: ClubSeatingContent(obsScenes: _saved)));
        await pumpEventQueue();
        final subscription = bloc.stream.listen(states.add);
        bloc.add(ClubTranslationControlEvent.changeObsScenes(mapping: _changed));
        await pumpEventQueue();
        bloc.add(ClubTranslationControlEvent.stateReceived(content: ClubSeatingContent(obsScenes: _fromSocket)));
        await pumpEventQueue();
        expect(bloc.state.obsScenes, _changed);
        repository.obsRequests.failAll();
        await pumpEventQueue();
        await bloc.close();
        await subscription.cancel();
      });

      expect(states, [_withObsScenes(_changed), _withObsScenes(_fromSocket)]);
      expect(errors, [isA<_RequestFailed>()]);
    });
  });
}
