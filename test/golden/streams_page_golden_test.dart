import 'golden_utils.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:seating_generator_web/domain/models/game_stream_admin_model.dart';
import 'package:seating_generator_web/feature/streams/bloc/streams_admin_bloc.dart';
import 'package:seating_generator_web/feature/streams/bloc/streams_admin_event.dart';
import 'package:seating_generator_web/feature/streams/bloc/streams_admin_state.dart';
import 'package:seating_generator_web/feature/streams/ui/streams_page.dart';

class MockStreamsAdminBloc extends MockBloc<StreamsAdminEvent, StreamsAdminState> implements StreamsAdminBloc {}

const _activeStream = GameStreamAdminModel(
  id: 1,
  tableNumber: 1,
  viewerUrl: 'https://mafbase.ru/stream/abc123',
  rtmpServerUrl: 'rtmp://live.mafbase.ru/stream',
  rtmpKey: 'abc123-key',
  active: true,
  startedAt: '2026-05-08T12:00:00Z',
);

const _inactiveStream = GameStreamAdminModel(
  id: 2,
  tableNumber: 1,
  viewerUrl: 'https://mafbase.ru/stream/old456',
  rtmpServerUrl: null,
  rtmpKey: null,
  active: false,
  startedAt: '2026-05-08T10:30:00Z',
);

const _table2Stream = GameStreamAdminModel(
  id: 3,
  tableNumber: 2,
  viewerUrl: 'https://twitch.tv/mafbase2',
  rtmpServerUrl: null,
  rtmpKey: null,
  active: true,
  startedAt: '2026-05-08T11:45:00Z',
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

Widget _pageWidget(StreamsAdminBloc bloc) => themedWidget(
      BlocProvider<StreamsAdminBloc>.value(
        value: bloc,
        child: const StreamsPageContent(tournamentId: 1),
      ),
    );

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

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(tester, goldenName('streams_page/loading'), customPump: (t) => t.pump());
    });

    testGoldens('empty state', (tester) async {
      final bloc = _createMockBloc(const StreamsAdminState(isLoading: false));
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'empty');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(tester, goldenName('streams_page/empty'), customPump: (t) => t.pump());
    });

    testGoldens('with active stream', (tester) async {
      final bloc = _createMockBloc(
        const StreamsAdminState(
          isLoading: false,
          streams: [_activeStream],
        ),
      );
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'active_stream');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(tester, goldenName('streams_page/active_stream'), customPump: (t) => t.pump());
    });

    testGoldens('with multiple streams and tables', (tester) async {
      final bloc = _createMockBloc(
        const StreamsAdminState(
          isLoading: false,
          streams: [_activeStream, _inactiveStream, _table2Stream],
        ),
      );
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'multiple_streams');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(tester, goldenName('streams_page/multiple_streams'), customPump: (t) => t.pump());
    });
  });
}
