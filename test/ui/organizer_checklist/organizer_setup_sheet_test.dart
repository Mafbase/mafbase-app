@Timeout(Duration(seconds: 30))
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_result.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_sheet.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

import '../../feature/organizer_checklist/organizer_checklist_fixtures.dart';

const _gomafiaUrl = 'https://gomafia.pro/tournament/42';

class _FakeRepositoryFactory implements RepositoryFactory {
  _FakeRepositoryFactory(this.tournamentEditRepository);

  @override
  final TournamentEditRepository tournamentEditRepository;

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

class _Harness {
  _Harness(this.repository, this.tournamentBloc, this.checklistBloc);

  final RecordingTournamentEditRepository repository;
  final RecordingTournamentPageBloc tournamentBloc;
  final RecordingOrganizerChecklistBloc checklistBloc;
  final results = <OrganizerSetupResult?>[];
}

Future<_Harness> _openWizard(WidgetTester tester) async {
  final harness = _Harness(
    RecordingTournamentEditRepository(),
    RecordingTournamentPageBloc(ownerTournament),
    RecordingOrganizerChecklistBloc(const OrganizerChecklistState()),
  );
  addTearDown(harness.tournamentBloc.close);
  addTearDown(harness.checklistBloc.close);

  await tester.pumpWidget(
    DependencyScopeWidget(
      scope: _FakeDependencyScope(_FakeRepositoryFactory(harness.repository)),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TournamentPageBloc>.value(value: harness.tournamentBloc),
          BlocProvider<OrganizerChecklistBloc>.value(value: harness.checklistBloc),
        ],
        child: MaterialApp(
          theme: AppTheme.light(isMobile: true),
          locale: const Locale('ru'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => OrganizerSetupSheet.show(context, tournamentId: 1).then(harness.results.add),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return harness;
}

Future<void> _tap(WidgetTester tester, String text) async {
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}

Future<void> _saveGomafiaUrl(WidgetTester tester) async {
  await _tap(tester, 'Да');
  await tester.enterText(find.byType(TextField), _gomafiaUrl);
  await tester.pump();
  await _tap(tester, 'Сохранить');
}

Future<void> _close(WidgetTester tester) async {
  await tester.tap(find.byType(CloseButton));
  await tester.pumpAndSettle();
}

CustomButton _button(WidgetTester tester, String text) => tester.widget<CustomButton>(
      find.ancestor(of: find.text(text), matching: find.byType(CustomButton)),
    );

void main() {
  testWidgets('each streaming answer sends its event to the checklist and leads to the end', (tester) async {
    final cases = <String, Matcher>{
      'Да, с компьютера через OBS': contains(
        isA<OrganizerChecklistEventSelectStreamMethod>().having((e) => e.method, 'method', ChecklistStreamMethod.obs),
      ),
      'Да, с телефона через приложение Mafbase': contains(
        isA<OrganizerChecklistEventSelectStreamMethod>().having((e) => e.method, 'method', ChecklistStreamMethod.phone),
      ),
      'Нет': contains(
        isA<OrganizerChecklistEventSetDismissed>()
            .having((e) => e.keys, 'keys', ChecklistGroup.translation.keys)
            .having((e) => e.dismissed, 'dismissed', true),
      ),
      'Пока не знаю': isEmpty,
    };

    for (final MapEntry(key: answer, value: events) in cases.entries) {
      final harness = await _openWizard(tester);
      await _tap(tester, 'Нет');
      expect(find.text('Будете вести трансляцию с плашками?'), findsOneWidget);

      await _tap(tester, answer);

      expect(harness.checklistBloc.added, events, reason: answer);
      expect(harness.checklistBloc.added, hasLength(lessThanOrEqualTo(1)), reason: answer);
      expect(find.text('Готово'), findsOneWidget, reason: answer);
      expect(find.text('Загрузить участников и рассадку с GoMafia'), findsNothing, reason: 'not an FSM tournament');
      await _tap(tester, 'Открыть чеклист');
      expect(harness.results, [OrganizerSetupResult.openChecklist]);

      await tester.pumpWidget(const SizedBox());
    }
  });

  testWidgets('an FSM tournament saves the link, reloads the tournament page and ends with the GoMafia import',
      (tester) async {
    final harness = await _openWizard(tester);

    await _saveGomafiaUrl(tester);
    expect(harness.repository.savedGomafiaUrls, [_gomafiaUrl]);
    expect(harness.tournamentBloc.added, [const TournamentPageEvent.pageOpened()]);
    expect(find.text('Настройка турнира · шаг 2 из 2'), findsOneWidget);

    await _tap(tester, 'Да, с компьютера через OBS');
    await _tap(tester, 'Загрузить участников и рассадку с GoMafia');

    expect(harness.results, [OrganizerSetupResult.importFromGomafia]);
  });

  testWidgets('the link is checked like in the import dialog, "Back" returns to the question', (tester) async {
    final harness = await _openWizard(tester);
    await _tap(tester, 'Да');
    expect(_button(tester, 'Сохранить').disabled, isTrue);

    await tester.enterText(find.byType(TextField), 'https://gomafia.pro/user/42');
    await tester.pump();
    expect(find.text('Нужна ссылка вида https://gomafia.pro/tournament/1'), findsOneWidget);
    expect(_button(tester, 'Сохранить').disabled, isTrue);

    await tester.enterText(find.byType(TextField), _gomafiaUrl);
    await tester.pump();
    expect(find.text('Нужна ссылка вида https://gomafia.pro/tournament/1'), findsNothing);
    expect(_button(tester, 'Сохранить').disabled, isFalse);

    await _tap(tester, 'Назад');
    expect(find.text('Турнир проходит на GoMafia (ФСМ)?'), findsOneWidget);
    expect(harness.repository.savedGomafiaUrls, isEmpty);
  });

  group('closing the wizard', () {
    testWidgets('on the first question changes nothing', (tester) async {
      final harness = await _openWizard(tester);
      await _close(tester);

      expect(harness.results, [null]);
      expect(harness.repository.savedGomafiaUrls, isEmpty);
      expect(harness.tournamentBloc.added, isEmpty);
      expect(harness.checklistBloc.added, isEmpty);
    });

    testWidgets('on the link step does not save an unsent link', (tester) async {
      final harness = await _openWizard(tester);
      await _tap(tester, 'Да');
      await tester.enterText(find.byType(TextField), _gomafiaUrl);
      await tester.pump();
      await _close(tester);

      expect(harness.results, [null]);
      expect(harness.repository.savedGomafiaUrls, isEmpty);
    });

    testWidgets('on the streaming question keeps the saved link and leaves the checklist as is', (tester) async {
      final harness = await _openWizard(tester);
      await _saveGomafiaUrl(tester);
      await _close(tester);

      expect(harness.results, [null]);
      expect(harness.repository.savedGomafiaUrls, [_gomafiaUrl]);
      expect(harness.tournamentBloc.added, [const TournamentPageEvent.pageOpened()]);
      expect(harness.checklistBloc.added, isEmpty);
    });

    testWidgets('at the end keeps both answers and does not navigate', (tester) async {
      final harness = await _openWizard(tester);
      await _saveGomafiaUrl(tester);
      await _tap(tester, 'Нет');
      await _close(tester);

      expect(harness.results, [null]);
      expect(harness.repository.savedGomafiaUrls, [_gomafiaUrl]);
      expect(harness.checklistBloc.added, [isA<OrganizerChecklistEventSetDismissed>()]);
    });

    testWidgets('by tapping outside works the same as the cross', (tester) async {
      final harness = await _openWizard(tester);
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(find.byType(OrganizerSetupSheet), findsNothing);
      expect(harness.results, [null]);
    });
  });
}
