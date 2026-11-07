@Timeout(Duration(seconds: 20))
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/notification_coverage_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_page.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

import '../../feature/organizer_checklist/notification_coverage_fixtures.dart';
import '../../feature/organizer_checklist/organizer_checklist_fixtures.dart';

const _noFsmNickname = 'Нет ФСМ-ника — оповещение в ВК не придёт';
const _notSubscribed = 'Не подписан на бота в Telegram';
const _setFsmNickname = 'Указать ФСМ-ник';

typedef _Harness = ({RecordingNotificationCoverageBloc bloc, RecordingTournamentPageBloc tournamentBloc});

Future<_Harness> _pumpPage(
  WidgetTester tester,
  NotificationCoverageState state, {
  TournamentPageState tournament = ownerTournament,
  Stream<TournamentPageState>? tournamentStates,
}) async {
  tester.view.physicalSize = const Size(900, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final bloc = RecordingNotificationCoverageBloc(state);
  final tournamentBloc = RecordingTournamentPageBloc(tournament, states: tournamentStates);
  addTearDown(bloc.close);
  addTearDown(tournamentBloc.close);

  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<NotificationCoverageBloc>.value(value: bloc),
        BlocProvider<TournamentPageBloc>.value(value: tournamentBloc),
      ],
      child: MaterialApp(
        theme: AppTheme.light(isMobile: true),
        locale: const Locale('ru'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const NotificationCoverageContent(tournamentId: 1),
      ),
    ),
  );
  await tester.pump();
  return (bloc: bloc, tournamentBloc: tournamentBloc);
}

NotificationCoverageState _loaded(NotificationCoverageModel coverage) =>
    NotificationCoverageState(coverage: coverage, isLoading: false);

Finder _channel(String title, String count) => find.ancestor(
      of: find.text(title),
      matching: find.ancestor(of: find.text(count), matching: find.byType(Row)),
    );

void main() {
  testWidgets('FSM tournament: counts from the endpoint, the VK channel and the note on top', (tester) async {
    await _pumpPage(tester, _loaded(fsmCoverage()));

    expect(find.text('Участники с ФСМ-ником получат оповещения в ВК автоматически'), findsOneWidget);
    expect(find.text('Получат оповещения: 14 из 20'), findsOneWidget);
    expect(_channel('Telegram', '9'), findsWidgets);
    expect(_channel('ВКонтакте', '12'), findsWidgets);
    expect(_channel('Push в приложении', '4'), findsWidgets);
    expect(find.text('Только оповещение о начале игры, в общий счёт не входит'), findsOneWidget);
    expect(find.text('Не получат оповещения (6)'), findsOneWidget);
    expect(find.text(_noFsmNickname), findsNWidgets(6));
    expect(find.text(_notSubscribed), findsNothing);
    expect(find.text(_setFsmNickname), findsNWidgets(6));
  });

  testWidgets('«Указать ФСМ-ник» opens the player profile dialog of the tournament', (tester) async {
    const participant = PlayerModel(id: 12, nickname: 'Вишня', mafbankNickname: 'cherry', imageUrl: 'https://photo');
    final harness = await _pumpPage(
      tester,
      _loaded(fsmCoverage()),
      tournament: ownerTournament.copyWith(tournamentPlayers: const [participant]),
    );

    await tester.tap(find.text(_setFsmNickname).at(0));
    await tester.tap(find.text(_setFsmNickname).at(1));

    expect(harness.tournamentBloc.added, [
      const TournamentPageEvent.openProfileDialog(player: PlayerModel(id: 11, nickname: 'Бармалей')),
      const TournamentPageEvent.openProfileDialog(player: participant),
    ]);
  });

  testWidgets('not FSM: Telegram only, every unreachable player is not subscribed', (tester) async {
    await _pumpPage(tester, _loaded(notFsmCoverage()));

    expect(find.text('Участники с ФСМ-ником получат оповещения в ВК автоматически'), findsNothing);
    expect(find.text('Получат оповещения: 17 из 20'), findsOneWidget);
    expect(_channel('Telegram', '17'), findsWidgets);
    expect(find.text('ВКонтакте'), findsNothing);
    expect(_channel('Push в приложении', '5'), findsWidgets);
    expect(find.text('Не получат оповещения (3)'), findsOneWidget);
    expect(find.text(_notSubscribed), findsNWidgets(3));
    expect(find.text(_noFsmNickname), findsNothing);
    expect(find.text(_setFsmNickname), findsNothing);
  });

  testWidgets('everyone has an FSM nickname: N of N and nobody is left out', (tester) async {
    await _pumpPage(tester, _loaded(everyoneCoverage()));

    expect(find.text('Получат оповещения: 20 из 20'), findsOneWidget);
    expect(find.text('Оповещения получат все участники'), findsOneWidget);
    expect(find.textContaining('Не получат оповещения'), findsNothing);
  });

  testWidgets('without participants there is nothing to count', (tester) async {
    await _pumpPage(
      tester,
      _loaded(
        const NotificationCoverageModel(
          isFsm: false,
          total: 0,
          reachable: 0,
          telegram: 0,
          vk: 0,
          push: 0,
          unreachable: [],
          unavailable: false,
        ),
      ),
    );

    expect(find.text('В турнире пока нет участников'), findsOneWidget);
    expect(find.textContaining('Получат оповещения'), findsNothing);
    expect(find.text('Оповещения получат все участники'), findsNothing);
    expect(find.text('Скопировать приглашение'), findsOneWidget);
  });

  testWidgets('subscriptions unavailable: a retry instead of «0 из N»', (tester) async {
    final harness = await _pumpPage(tester, _loaded(unavailableCoverage()));

    expect(find.text('Не удалось получить данные о подписках'), findsOneWidget);
    expect(find.textContaining('из 20'), findsNothing);
    expect(find.text('Telegram'), findsNothing);
    expect(find.textContaining('Не получат оповещения'), findsNothing);
    expect(find.text('Участники с ФСМ-ником получат оповещения в ВК автоматически'), findsOneWidget);
    expect(find.text('Скопировать приглашение'), findsOneWidget);

    await tester.tap(find.text('Повторить'));

    expect(harness.bloc.loadCount, 1);
  });

  testWidgets('the invitation goes to the clipboard with the bot link and /pair', (tester) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') copied = (call.arguments as Map)['text'] as String?;
      return null;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));
    await _pumpPage(tester, _loaded(notFsmCoverage()));

    await tester.tap(find.text('Скопировать приглашение'));
    await tester.pump();

    expect(
      copied,
      'Чтобы получать номер своего стола и время начала игры, напишите боту '
      'https://t.me/mafbase_notification_bot свой ФСМ-ник с учётом регистра и цифр.\n\n'
      'Если ФСМ-ника нет, отправьте боту /pair и через пробел свой ник в Mafbase — '
      'как в списке участников турнира. Например: /pair Шерлок',
    );
    expect(find.text('Приглашение скопировано'), findsOneWidget);
  });

  testWidgets('a change of the tournament participants reloads the coverage', (tester) async {
    final tournamentStates = StreamController<TournamentPageState>();
    addTearDown(tournamentStates.close);
    final harness = await _pumpPage(tester, _loaded(fsmCoverage()), tournamentStates: tournamentStates.stream);

    tournamentStates.add(
      ownerTournament.copyWith(tournamentPlayers: const [PlayerModel(id: 11, nickname: 'Бармалей')]),
    );
    await tester.pump();

    expect(harness.bloc.loadCount, 1);
  });

  testWidgets('first load shows a spinner, a failed one offers a retry', (tester) async {
    await _pumpPage(tester, const NotificationCoverageState());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    final harness = await _pumpPage(tester, const NotificationCoverageState(isLoading: false));
    expect(find.text('Не удалось загрузить охват оповещений'), findsOneWidget);

    await tester.tap(find.text('Повторить'));

    expect(harness.bloc.loadCount, 1);
  });
}
