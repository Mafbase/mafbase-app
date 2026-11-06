@Timeout(Duration(seconds: 10))
library;

import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/tournament/ui/models/tournament_menu_models.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_builder.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

class _RecordingTournamentPageBloc extends MockBloc<TournamentPageEvent, TournamentPageState>
    implements TournamentPageBloc {
  final added = <TournamentPageEvent>[];

  @override
  void add(TournamentPageEvent event) => added.add(event);
}

class _TestRouter extends RootStackRouter {
  _TestRouter(this.page);

  final Widget page;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: PageInfo('MenuRoute', builder: (_) => page), path: '/'),
      ];
}

const _overlaysTitle = 'Плашки для трансляции';
const _notificationsTitle = 'Оповещения';
const _lockedHint = 'Доступно после оплаты';

const _unpaidOwner = TournamentPageState(
  isLoading: false,
  isMyTournament: true,
  isBillingLoaded: true,
);

const _paidOwner = TournamentPageState(
  isLoading: false,
  isMyTournament: true,
  isBillingLoaded: true,
  billedPlayers: 20,
  billedTranslation: true,
  notificationEnabled: true,
);

/// Строит секции меню там же, где их строит приложение: под роутером и блоком турнира.
Future<(List<TournamentMenuSection>, _RecordingTournamentPageBloc)> _pumpSections(
  WidgetTester tester,
  TournamentPageState state, {
  bool showBill = true,
  OrganizerChecklistModel? checklist,
}) async {
  final bloc = _RecordingTournamentPageBloc();
  whenListen(bloc, const Stream<TournamentPageState>.empty(), initialState: state);
  addTearDown(bloc.close);

  late List<TournamentMenuSection> sections;
  final router = _TestRouter(
    BlocProvider<TournamentPageBloc>.value(
      value: bloc,
      child: Scaffold(
        body: Builder(
          builder: (context) {
            sections = TournamentMenuBuilder.buildSections(
              context,
              state,
              1,
              showBill: showBill,
              seatingLoading: false,
              checklist: checklist,
            );
            return const SizedBox.expand();
          },
        ),
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
  return (sections, bloc);
}

List<TournamentMenuLockedItem> _locked(List<TournamentMenuSection> sections) =>
    sections.expand((section) => section.items).whereType<TournamentMenuLockedItem>().toList();

TournamentMenuSection? _notificationsSection(List<TournamentMenuSection> sections) =>
    sections.where((section) => section.title == 'ОПОВЕЩЕНИЯ').firstOrNull;

void main() {
  testWidgets('owner sees the checklist first in the main section, with progress once it is loaded', (tester) async {
    const checklist = OrganizerChecklistModel(
      isFsm: false,
      items: [
        ChecklistItemModel(key: ChecklistKey.gamesCount, status: ChecklistStatus.done),
        ChecklistItemModel(key: ChecklistKey.players, status: ChecklistStatus.warning, current: 23),
        ChecklistItemModel(key: ChecklistKey.billing, status: ChecklistStatus.dismissed),
      ],
    );

    var (sections, _) = await _pumpSections(tester, _paidOwner, checklist: checklist);
    final item = sections.first.items.first as TournamentMenuTapItem;
    expect(item.text, 'Чеклист организатора');
    expect(item.routeSegment, 'checklist');
    expect(item.trailingText, '1/2');

    await tester.pumpWidget(const SizedBox());
    (sections, _) = await _pumpSections(tester, _paidOwner);
    expect((sections.first.items.first as TournamentMenuTapItem).trailingText, isNull);

    await tester.pumpWidget(const SizedBox());
    (sections, _) = await _pumpSections(tester, _paidOwner.copyWith(isMyTournament: false), checklist: checklist);
    expect(
      sections.expand((section) => section.items).map((item) => item.text),
      isNot(contains('Чеклист организатора')),
    );
  });

  testWidgets('owner of an unpaid tournament sees locked overlays and notifications', (tester) async {
    final (sections, _) = await _pumpSections(tester, _unpaidOwner);

    final locked = _locked(sections);
    expect(locked.map((item) => item.text), [_overlaysTitle, _notificationsTitle]);
    expect(locked.map((item) => item.hint), everyElement(_lockedHint));
    expect(locked.first.icon, Icons.layers_outlined);

    final notifications = _notificationsSection(sections);
    expect(notifications?.items, hasLength(1));
    expect(notifications?.items.single, isA<TournamentMenuLockedItem>());
  });

  testWidgets('paid tournament keeps the regular items under the new name', (tester) async {
    final (sections, _) = await _pumpSections(tester, _paidOwner);

    expect(_locked(sections), isEmpty);
    final overlays = sections
        .expand((section) => section.items)
        .whereType<TournamentMenuExpandableItem>()
        .where((item) => item.text == _overlaysTitle)
        .single;
    expect(overlays.icon, Icons.layers_outlined);
    expect(_notificationsSection(sections)?.items, hasLength(3));
  });

  testWidgets('no locked items for a foreign tournament, hidden billing or unknown billing', (tester) async {
    final cases = <(TournamentPageState, bool)>[
      (_unpaidOwner.copyWith(isMyTournament: false), true),
      (_unpaidOwner, false),
      (_unpaidOwner.copyWith(isBillingLoaded: false), true),
      (_unpaidOwner.copyWith(isLoading: true), true),
    ];
    for (final (state, showBill) in cases) {
      await tester.pumpWidget(const SizedBox());
      final (sections, _) = await _pumpSections(tester, state, showBill: showBill);
      expect(_locked(sections), isEmpty, reason: '$state, showBill: $showBill');
      expect(_notificationsSection(sections), isNull, reason: '$state, showBill: $showBill');
    }
  });

  testWidgets('locked overlays open the sheet and pay with overlays already checked', (tester) async {
    final (sections, bloc) = await _pumpSections(tester, _unpaidOwner);

    _locked(sections).first.onTap();
    await tester.pumpAndSettle();
    expect(find.text(_overlaysTitle), findsOneWidget);

    await tester.tap(find.text('Оплатить'));
    await tester.pumpAndSettle();
    expect(find.text(_overlaysTitle), findsNothing);
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);

    await tester.tap(find.text('Оплатить 300₽'));
    await tester.pumpAndSettle();
    expect(bloc.added, [const TournamentPageEvent.bill(playersCount: 10, billedTranlsation: true)]);
  });

  testWidgets('locked notifications open billing without preselected overlays', (tester) async {
    final (sections, bloc) = await _pumpSections(tester, _unpaidOwner);

    _locked(sections).last.onTap();
    await tester.pumpAndSettle();
    expect(find.text(_notificationsTitle), findsOneWidget);

    await tester.tap(find.text('Оплатить'));
    await tester.pumpAndSettle();
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isFalse);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNull);
    expect(bloc.added, isEmpty);
  });
}
