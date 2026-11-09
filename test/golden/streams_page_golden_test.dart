import 'golden_utils.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/feature/streams/bloc/streams_admin_bloc.dart';
import 'package:seating_generator_web/feature/streams/bloc/streams_admin_event.dart';
import 'package:seating_generator_web/feature/streams/bloc/streams_admin_state.dart';
import 'package:seating_generator_web/feature/streams/ui/streams_page.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class MockStreamsAdminBloc extends MockBloc<StreamsAdminEvent, StreamsAdminState> implements StreamsAdminBloc {}

class MockTournamentPageBloc extends MockBloc<TournamentPageEvent, TournamentPageState> implements TournamentPageBloc {}

final _activeStream = GameStreamAdmin(
  id: 1,
  tableNumber: 1,
  viewerUrl: 'https://mafbase.ru/stream/abc123',
  rtmpServerUrl: 'rtmp://live.mafbase.ru/stream',
  rtmpKey: 'abc123-key',
  active: true,
  startedAt: '2026-05-08T12:00:00Z',
);

final _inactiveStream = GameStreamAdmin(
  id: 2,
  tableNumber: 1,
  viewerUrl: 'https://mafbase.ru/stream/old456',
  active: false,
  startedAt: '2026-05-08T10:30:00Z',
);

final _table2Stream = GameStreamAdmin(
  id: 3,
  tableNumber: 2,
  viewerUrl: 'https://twitch.tv/mafbase2',
  active: true,
  startedAt: '2026-05-08T11:45:00Z',
);

final _phoneStream = GameStreamAdmin(
  id: 4,
  tableNumber: 1,
  viewerUrl: 'https://vkvideo.ru/live/mafbase1',
  rtmpServerUrl: 'rtmp://ovsu.okcdn.ru/input/',
  rtmpKey: 'vk-stream-key',
  active: true,
  startedAt: '2026-05-08T12:00:00Z',
  broadcastToken: 'operator-token-1',
);

final _noRtmpStream = GameStreamAdmin(
  id: 5,
  tableNumber: 2,
  viewerUrl: 'https://vkvideo.ru/live/mafbase2',
  active: true,
  startedAt: '2026-05-08T12:05:00Z',
  broadcastToken: 'operator-token-2',
);

const _paidTournament = TournamentPageState(
  isLoading: false,
  isMyTournament: true,
  isBillingLoaded: true,
  billedTranslation: true,
);

const _unpaidTournament = TournamentPageState(
  isLoading: false,
  isMyTournament: true,
  isBillingLoaded: true,
);

MockStreamsAdminBloc _createMockBloc(StreamsAdminState state) {
  final bloc = MockStreamsAdminBloc();
  whenListen(
    bloc,
    const Stream<StreamsAdminState>.empty(),
    initialState: state,
  );
  return bloc;
}

Widget _pageWidget(StreamsAdminBloc bloc, {TournamentPageState tournament = _paidTournament}) {
  final tournamentBloc = MockTournamentPageBloc();
  whenListen(tournamentBloc, const Stream<TournamentPageState>.empty(), initialState: tournament);
  final authNotifier = AuthNotifier()..value = const AuthNotifierModel.authorized(userId: 1, hideBilling: false);
  addTearDown(tournamentBloc.close);
  addTearDown(authNotifier.dispose);

  return themedWidget(
    ChangeNotifierProvider<AuthNotifier>.value(
      value: authNotifier,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<StreamsAdminBloc>.value(value: bloc),
          BlocProvider<TournamentPageBloc>.value(value: tournamentBloc),
        ],
        child: const StreamsPageContent(tournamentId: 1),
      ),
    ),
  );
}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('StreamsPage golden tests', () {
    testGoldens('loading state', (tester) async {
      final bloc = _createMockBloc(const StreamsAdminState(isLoading: true));
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'loading');

      await tester.pumpDeviceBuilder(builder, wrapper: ruAppWrapper());
      await screenMatchesGolden(tester, goldenName('streams_page/loading'), customPump: (t) => t.pump());
    });

    testGoldens('empty state of an unpaid tournament', (tester) async {
      final bloc = _createMockBloc(const StreamsAdminState(isLoading: false));
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc, tournament: _unpaidTournament), name: 'empty');

      await tester.pumpDeviceBuilder(builder, wrapper: ruAppWrapper());
      await screenMatchesGolden(tester, goldenName('streams_page/empty'), customPump: (t) => t.pump());
    });

    testGoldens('with active stream', (tester) async {
      final bloc = _createMockBloc(
        StreamsAdminState(
          isLoading: false,
          streams: [_activeStream],
        ),
      );
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'active_stream');

      await tester.pumpDeviceBuilder(builder, wrapper: ruAppWrapper());
      await screenMatchesGolden(tester, goldenName('streams_page/active_stream'), customPump: (t) => t.pump());
    });

    testGoldens('with multiple streams and tables', (tester) async {
      final bloc = _createMockBloc(
        StreamsAdminState(
          isLoading: false,
          streams: [_activeStream, _inactiveStream, _table2Stream],
        ),
      );
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'multiple_streams');

      await tester.pumpDeviceBuilder(builder, wrapper: ruAppWrapper());
      await screenMatchesGolden(tester, goldenName('streams_page/multiple_streams'), customPump: (t) => t.pump());
    });

    testGoldens('phone stream and table without RTMP', (tester) async {
      final bloc = _createMockBloc(
        StreamsAdminState(
          isLoading: false,
          streams: [_phoneStream, _noRtmpStream],
        ),
      );
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'operator_links');

      await tester.pumpDeviceBuilder(builder, wrapper: ruAppWrapper());
      await screenMatchesGolden(tester, goldenName('streams_page/operator_links'), customPump: (t) => t.pump());
    });
  });
}
