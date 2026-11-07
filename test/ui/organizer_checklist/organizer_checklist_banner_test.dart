@Timeout(Duration(seconds: 20))
library;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_banner.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

import '../../feature/organizer_checklist/organizer_checklist_fixtures.dart';

class _TestRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: PageInfo('HomeRoute', builder: (_) => const Scaffold(body: OrganizerChecklistBanner())),
          path: '/',
        ),
        AutoRoute(
          page: PageInfo(OrganizerChecklistRoute.name, builder: (_) => const Text('checklist page')),
          path: '/checklist',
        ),
      ];
}

Future<(RecordingOrganizerChecklistBloc, _TestRouter)> _pumpBanner(
  WidgetTester tester,
  OrganizerChecklistState state,
) async {
  final bloc = RecordingOrganizerChecklistBloc(state);
  final tournamentBloc = RecordingTournamentPageBloc(ownerTournament);
  addTearDown(bloc.close);
  addTearDown(tournamentBloc.close);
  final router = _TestRouter();

  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<OrganizerChecklistBloc>.value(value: bloc),
        BlocProvider<TournamentPageBloc>.value(value: tournamentBloc),
      ],
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
  return (bloc, router);
}

OrganizerChecklistModel _nextLocked(ChecklistKey locked) => OrganizerChecklistModel(
      isFsm: false,
      items: [
        for (final key in ChecklistKey.values)
          checklistItem(
            key,
            key == locked
                ? ChecklistStatus.locked
                : key.index < locked.index
                    ? (key.canDismiss ? ChecklistStatus.dismissed : ChecklistStatus.done)
                    : ChecklistStatus.todo,
          ),
      ],
    );

void main() {
  testWidgets('shows readiness and the next item, «Открыть» leads to the checklist', (tester) async {
    final (_, router) = await _pumpBanner(tester, OrganizerChecklistState(checklist: checklistMethodNotChosen()));

    expect(find.text('Готовность турнира 4/12'), findsOneWidget);
    expect(find.text('Дальше: Рассадка'), findsOneWidget);

    await tester.tap(find.text('Открыть'));
    await tester.pumpAndSettle();

    expect(router.current.name, OrganizerChecklistRoute.name);
  });

  testWidgets('is not shown until loaded, when everything is done and after closing', (tester) async {
    final done = OrganizerChecklistModel(
      isFsm: false,
      items: [
        checklistItem(ChecklistKey.gamesCount, ChecklistStatus.done),
        checklistItem(ChecklistKey.billing, ChecklistStatus.dismissed),
      ],
    );
    final states = [
      const OrganizerChecklistState(),
      const OrganizerChecklistState(hasError: true),
      OrganizerChecklistState(checklist: done),
      OrganizerChecklistState(checklist: checklistMethodNotChosen(), isBannerHidden: true),
    ];
    for (final state in states) {
      await tester.pumpWidget(const SizedBox());
      await _pumpBanner(tester, state);
      expect(find.textContaining('Готовность турнира'), findsNothing, reason: '$state');
    }
  });

  testWidgets('the cross hides the banner for this tournament', (tester) async {
    final (bloc, _) = await _pumpBanner(tester, OrganizerChecklistState(checklist: checklistMethodNotChosen()));

    await tester.tap(find.byTooltip('Скрыть'));

    expect(bloc.added.single, isA<OrganizerChecklistEventHideBanner>());
  });

  testWidgets('a locked next item leads to the payment that unlocks it', (tester) async {
    await _pumpBanner(tester, OrganizerChecklistState(checklist: _nextLocked(ChecklistKey.obsWidget)));
    expect(find.text('Дальше: Виджет добавлен в OBS'), findsOneWidget);
    await tester.tap(find.text('Оплатить'));
    await tester.pumpAndSettle();
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);

    await tester.pumpWidget(const SizedBox());
    await _pumpBanner(tester, OrganizerChecklistState(checklist: _nextLocked(ChecklistKey.notifyCoverage)));
    expect(find.text('Дальше: Игроки получат оповещения'), findsOneWidget);
    await tester.tap(find.text('Оплатить'));
    await tester.pumpAndSettle();
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isFalse);
  });
}
