@Timeout(Duration(seconds: 20))
library;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/widgets/notification_coverage_counter_link.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/custom_text_info_form.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/start_game_info_form.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

import '../../feature/organizer_checklist/organizer_checklist_fixtures.dart';

const _counter = 'Получат: 14 из 20';

/// Страница охвата подменена той же страницей со строкой: в приложении меню со строкой видно и поверх неё.
class _TestRouter extends RootStackRouter {
  _TestRouter(this.home);

  final Widget home;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: PageInfo('MenuRoute', builder: (_) => home), path: '/'),
        AutoRoute(
          page: PageInfo(NotificationCoverageRoute.name, builder: (_) => home),
          path: '/tournament/:id/notification-coverage',
        ),
      ];
}

OrganizerChecklistState _withCoverageItem(ChecklistItemModel item) =>
    OrganizerChecklistState(checklist: OrganizerChecklistModel(isFsm: false, items: [item]));

Future<_TestRouter> _pump(WidgetTester tester, OrganizerChecklistState state, Widget child) async {
  final checklistBloc = RecordingOrganizerChecklistBloc(state);
  final tournamentBloc = RecordingTournamentPageBloc(ownerTournament);
  addTearDown(checklistBloc.close);
  addTearDown(tournamentBloc.close);

  final router = _TestRouter(Scaffold(body: SingleChildScrollView(child: child)));
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<OrganizerChecklistBloc>.value(value: checklistBloc),
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
  return router;
}

void main() {
  testWidgets('shows how many players get notifications and opens the coverage page', (tester) async {
    final router = await _pump(
      tester,
      _withCoverageItem(checklistItem(ChecklistKey.notifyCoverage, ChecklistStatus.warning, current: 14, total: 20)),
      const NotificationCoverageCounterLink(),
    );

    await tester.tap(find.text(_counter));
    await tester.pumpAndSettle();

    expect(router.current.name, NotificationCoverageRoute.name);
    expect(router.current.params.optInt('id'), 1);

    await tester.tap(find.text(_counter).last);
    await tester.pumpAndSettle();

    expect(router.stack.map((page) => page.name), ['MenuRoute', NotificationCoverageRoute.name]);
  });

  testWidgets('hidden without counters: no checklist, subscriptions unavailable, locked, hidden or no players',
      (tester) async {
    final states = {
      'checklist not loaded': const OrganizerChecklistState(),
      'load error': const OrganizerChecklistState(hasError: true),
      'unavailable': _withCoverageItem(
        checklistItem(ChecklistKey.notifyCoverage, ChecklistStatus.warning, unavailable: true),
      ),
      'locked': _withCoverageItem(checklistItem(ChecklistKey.notifyCoverage, ChecklistStatus.locked)),
      'locked with counters': _withCoverageItem(
        checklistItem(ChecklistKey.notifyCoverage, ChecklistStatus.locked, current: 14, total: 20),
      ),
      'dismissed': _withCoverageItem(checklistItem(ChecklistKey.notifyCoverage, ChecklistStatus.dismissed)),
      'no players': _withCoverageItem(
        checklistItem(ChecklistKey.notifyCoverage, ChecklistStatus.todo, current: 0, total: 0),
      ),
    };

    for (final MapEntry(:key, :value) in states.entries) {
      await tester.pumpWidget(const SizedBox());
      await _pump(tester, value, const NotificationCoverageCounterLink());

      expect(find.textContaining('Получат'), findsNothing, reason: key);
    }
  });

  testWidgets('both notification forms show the counter under the send button', (tester) async {
    await _pump(
      tester,
      _withCoverageItem(checklistItem(ChecklistKey.notifyCoverage, ChecklistStatus.warning, current: 14, total: 20)),
      SizedBox(
        width: 268,
        child: Column(
          children: [
            StartGameInfoForm(maxGame: 3, onCollapse: () {}),
            CustomTextInfoForm(onCollapse: () {}),
          ],
        ),
      ),
    );

    expect(find.text(_counter), findsNWidgets(2));
    final sendButtons = tester.widgetList<CustomButton>(find.widgetWithText(CustomButton, 'Отправить'));
    expect(sendButtons.map((button) => (button.isInverted, button.disabled)), [(true, true), (true, true)]);
  });
}
