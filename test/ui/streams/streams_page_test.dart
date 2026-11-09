@Timeout(Duration(seconds: 10))
library;

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/feature/streams/bloc/streams_admin_bloc.dart';
import 'package:seating_generator_web/feature/streams/bloc/streams_admin_event.dart';
import 'package:seating_generator_web/feature/streams/bloc/streams_admin_state.dart';
import 'package:seating_generator_web/feature/streams/ui/streams_page.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class _MockStreamsAdminBloc extends MockBloc<StreamsAdminEvent, StreamsAdminState> implements StreamsAdminBloc {}

class _MockTournamentPageBloc extends MockBloc<TournamentPageEvent, TournamentPageState>
    implements TournamentPageBloc {}

const _guideStep = 'Отправьте оператору «Ссылку оператора» этого стола.';
const _billingHint = 'Без оплаты плашек видео пойдёт без плашек';

const _unpaidOwner = TournamentPageState(isLoading: false, isMyTournament: true, isBillingLoaded: true);

final _stream = GameStreamAdmin(id: 1, tableNumber: 1, viewerUrl: 'https://vkvideo.ru/live/1', active: true);

Future<void> _pumpPage(
  WidgetTester tester, {
  List<GameStreamAdmin> streams = const [],
  TournamentPageState tournament = _unpaidOwner,
  bool hideBilling = false,
}) async {
  final streamsBloc = _MockStreamsAdminBloc();
  whenListen(
    streamsBloc,
    const Stream<StreamsAdminState>.empty(),
    initialState: StreamsAdminState(isLoading: false, streams: streams),
  );
  final tournamentBloc = _MockTournamentPageBloc();
  whenListen(tournamentBloc, const Stream<TournamentPageState>.empty(), initialState: tournament);
  final authNotifier = AuthNotifier()..value = AuthNotifierModel.authorized(userId: 1, hideBilling: hideBilling);
  addTearDown(streamsBloc.close);
  addTearDown(tournamentBloc.close);
  addTearDown(authNotifier.dispose);

  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(isMobile: true),
      locale: const Locale('ru'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ChangeNotifierProvider<AuthNotifier>.value(
        value: authNotifier,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<StreamsAdminBloc>.value(value: streamsBloc),
            BlocProvider<TournamentPageBloc>.value(value: tournamentBloc),
          ],
          child: const StreamsPageContent(tournamentId: 1),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('phone guide is expanded until the tournament has streams', (tester) async {
    await _pumpPage(tester);
    expect(find.text(_guideStep), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await _pumpPage(tester, streams: [_stream]);
    expect(find.text(_guideStep), findsNothing);

    await tester.tap(find.text('Как вести трансляцию с телефона'));
    await tester.pumpAndSettle();
    expect(find.text(_guideStep), findsOneWidget);
  });

  testWidgets('overlay billing hint is shown under the same conditions as the locked menu items', (tester) async {
    await _pumpPage(tester);
    expect(find.text(_billingHint), findsOneWidget);

    final hidden = <(TournamentPageState, bool)>[
      (_unpaidOwner.copyWith(billedTranslation: true), false),
      (_unpaidOwner.copyWith(isMyTournament: false), false),
      (_unpaidOwner.copyWith(isBillingLoaded: false), false),
      (_unpaidOwner, true),
    ];
    for (final (tournament, hideBilling) in hidden) {
      await tester.pumpWidget(const SizedBox());
      await _pumpPage(tester, tournament: tournament, hideBilling: hideBilling);
      expect(find.text(_billingHint), findsNothing, reason: '$tournament, hideBilling: $hideBilling');
    }
  });

  testWidgets('pay opens billing with overlays already checked', (tester) async {
    await _pumpPage(tester);

    await tester.tap(find.text('Оплатить'));
    await tester.pumpAndSettle();

    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);
    expect(find.text('Оплатить 300₽'), findsOneWidget);
  });
}
