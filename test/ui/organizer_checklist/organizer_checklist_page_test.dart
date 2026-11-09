@Timeout(Duration(seconds: 20))
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_page.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_hidden_section.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_stream_method_options.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

import '../../feature/organizer_checklist/organizer_checklist_fixtures.dart';

const _obsSection = 'Через OBS на компьютере';
const _phoneSection = 'С телефона через приложение Mafbase';

Future<RecordingOrganizerChecklistBloc> _pumpPage(WidgetTester tester, OrganizerChecklistState state) async {
  tester.view.physicalSize = const Size(900, 2200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final bloc = RecordingOrganizerChecklistBloc(state);
  final tournamentBloc = RecordingTournamentPageBloc(ownerTournament);
  addTearDown(bloc.close);
  addTearDown(tournamentBloc.close);

  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<OrganizerChecklistBloc>.value(value: bloc),
        BlocProvider<TournamentPageBloc>.value(value: tournamentBloc),
      ],
      child: MaterialApp(
        theme: AppTheme.light(isMobile: true),
        locale: const Locale('ru'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const OrganizerChecklistPage(tournamentId: 1),
      ),
    ),
  );
  await tester.pump();
  return bloc;
}

Finder _restoreButtonNear(String text) => find.descendant(
      of: find.ancestor(of: find.text(text), matching: find.byType(Row)).first,
      matching: find.text('Вернуть'),
    );

void main() {
  testWidgets('loads on open, shows progress, groups and both stream methods while none is chosen', (tester) async {
    final bloc = await _pumpPage(tester, OrganizerChecklistState(checklist: checklistMethodNotChosen()));

    expect(bloc.loadCount, 1);
    expect(find.text('Готовность турнира 4/12'), findsOneWidget);
    expect(find.text('Подготовка'), findsOneWidget);
    expect(find.text('Оповещения'), findsOneWidget);
    expect(find.text('Трансляция'), findsOneWidget);
    expect(find.text(_obsSection), findsOneWidget);
    expect(find.text(_phoneSection), findsOneWidget);
    expect(find.text('Получат 14 из 20'), findsOneWidget);
    expect(find.text('Доступно после оплаты плашек'), findsNWidgets(2));
    expect(find.byType(OrganizerChecklistHiddenSection), findsNothing);
  });

  testWidgets('a chosen method drops the subheaders, its counterpart waits in the hidden block', (tester) async {
    final bloc = await _pumpPage(tester, OrganizerChecklistState(checklist: checklistPhoneChosen()));

    expect(find.text(_obsSection), findsNothing);
    expect(find.text(_phoneSection), findsOneWidget, reason: 'subtitle of the chosen method item');
    expect(find.text('Не удалось проверить'), findsOneWidget);
    expect(find.text('Скрытые (2)'), findsOneWidget);
    expect(find.text('Виджет добавлен в OBS'), findsNothing);

    await tester.tap(find.text('Скрытые (2)'));
    await tester.pumpAndSettle();
    await tester.tap(_restoreButtonNear('Виджет добавлен в OBS'));

    final event = bloc.dismissEvents.single;
    expect(event.keys, [ChecklistKey.obsWidget]);
    expect(event.dismissed, isFalse);
  });

  testWidgets('«Не нужна» hides all six translation items with one event', (tester) async {
    final bloc = await _pumpPage(tester, OrganizerChecklistState(checklist: checklistMethodNotChosen()));

    await tester.tap(find.text('Не нужна'));

    final event = bloc.dismissEvents.single;
    expect(event.keys, ChecklistGroup.translation.keys);
    expect(event.dismissed, isTrue);
  });

  testWidgets('the whole hidden translation group comes back with one row', (tester) async {
    final bloc = await _pumpPage(tester, OrganizerChecklistState(checklist: checklistTranslationHidden()));

    expect(find.text('Трансляция'), findsNothing);
    await tester.tap(find.text('Скрытые (7)'));
    await tester.pumpAndSettle();

    expect(find.text('Оплата'), findsOneWidget);
    expect(find.text('Скрыта вся группа'), findsOneWidget);
    expect(find.text('Способ трансляции'), findsNothing);

    await tester.tap(_restoreButtonNear('Скрыта вся группа'));
    await tester.tap(_restoreButtonNear('Оплата'));

    expect(bloc.dismissEvents.map((event) => [event.keys, event.dismissed]).toList(), [
      [ChecklistGroup.translation.keys, false],
      [
        [ChecklistKey.billing],
        false,
      ],
    ]);
  });

  testWidgets('buttons are disabled while a change is saved', (tester) async {
    final bloc = await _pumpPage(
      tester,
      OrganizerChecklistState(checklist: checklistMethodNotChosen(), isUpdating: true),
    );

    await tester.tap(find.text('Не нужна'));

    expect(bloc.dismissEvents, isEmpty);
    expect(find.byType(LinearProgressIndicator), findsNWidgets(2));
  });

  testWidgets('load error offers a retry instead of a dialog', (tester) async {
    final bloc = await _pumpPage(tester, const OrganizerChecklistState(hasError: true));

    expect(find.text('Не удалось загрузить чеклист'), findsOneWidget);
    await tester.tap(find.text('Повторить'));

    expect(bloc.loadCount, 2);
  });

  testWidgets('an item opens its sheet and closing the sheet reloads the checklist', (tester) async {
    final bloc = await _pumpPage(tester, OrganizerChecklistState(checklist: checklistMethodNotChosen()));

    await tester.tap(find.text('Количество игр'));
    await tester.pumpAndSettle();

    expect(find.text('Количество игр'), findsNWidgets(2));
    expect(find.text('Сделать'), findsOneWidget);
    expect(find.text('Не нужно'), findsNothing);
    expect(find.text('Задать вопрос'), findsOneWidget);

    await tester.tap(find.byType(CloseButton));
    await tester.pumpAndSettle();

    expect(bloc.loadCount, 2);
  });

  testWidgets('«Не нужно» and «Достаточно» hide the item from its sheet', (tester) async {
    final bloc = await _pumpPage(tester, OrganizerChecklistState(checklist: checklistMethodNotChosen()));

    await tester.tap(find.text('Где стоят столы'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Не нужно'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Игроки получат оповещения'));
    await tester.pumpAndSettle();
    expect(find.text('Сейчас оповещения получат: 14 из 20.'), findsOneWidget);
    await tester.tap(find.text('Достаточно'));
    await tester.pumpAndSettle();

    expect(bloc.dismissEvents.map((event) => [event.keys, event.dismissed]).toList(), [
      [
        [ChecklistKey.tableDescriptions],
        true,
      ],
      [
        [ChecklistKey.notifyCoverage],
        true,
      ],
    ]);
  });

  testWidgets('the stream method sheet sends the chosen way', (tester) async {
    final bloc = await _pumpPage(tester, OrganizerChecklistState(checklist: checklistMethodNotChosen()));

    await tester.tap(find.text('Способ трансляции'));
    await tester.pumpAndSettle();

    final options = find.byType(OrganizerChecklistStreamMethodOptions);
    expect(find.descendant(of: options, matching: find.text('Выбрано')), findsNothing);
    await tester.tap(find.descendant(of: options, matching: find.text('С телефона через приложение Mafbase')));
    await tester.pumpAndSettle();

    expect(options, findsNothing);
    expect(
      bloc.added.whereType<OrganizerChecklistEventSelectStreamMethod>().map((event) => event.method),
      [ChecklistStreamMethod.phone],
    );
  });

  testWidgets('a chosen method is marked in its sheet and only the other one can be picked', (tester) async {
    final bloc = await _pumpPage(tester, OrganizerChecklistState(checklist: checklistPhoneChosen()));

    await tester.tap(find.text('Способ трансляции'));
    await tester.pumpAndSettle();

    final options = find.byType(OrganizerChecklistStreamMethodOptions);
    expect(find.descendant(of: options, matching: find.text('Выбрано')), findsOneWidget);
    await tester.tap(find.descendant(of: options, matching: find.text('С телефона через приложение Mafbase')));
    await tester.pumpAndSettle();
    expect(options, findsOneWidget, reason: 'the selected way is not a button');

    await tester.tap(find.descendant(of: options, matching: find.text('С компьютера через OBS')));
    await tester.pumpAndSettle();

    expect(
      bloc.added.whereType<OrganizerChecklistEventSelectStreamMethod>().map((event) => event.method),
      [ChecklistStreamMethod.obs],
    );
  });
}
