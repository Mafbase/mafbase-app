import 'golden_utils.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_state.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/club_translation_control_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/club_translation_control_event.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_event.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_page.dart';

class MockTranslationControlBloc
    extends MockBloc<TranslationControlEvent, TranslationContentState>
    implements TranslationControlBloc {}

class MockClubTranslationControlBloc extends MockBloc<ClubTranslationControlEvent, TranslationContentState>
    implements ClubTranslationControlBloc {}

const _roles = [
  PlayerRole.citizen,
  PlayerRole.maf,
  PlayerRole.don,
  PlayerRole.sheriff,
  PlayerRole.citizen,
  PlayerRole.maf,
  PlayerRole.citizen,
  PlayerRole.citizen,
  PlayerRole.citizen,
  PlayerRole.citizen,
];

const _statuses = [
  PlayerStatus.alive,
  PlayerStatus.killed,
  PlayerStatus.alive,
  PlayerStatus.voted,
  PlayerStatus.alive,
  PlayerStatus.deleted,
  PlayerStatus.alive,
  PlayerStatus.alive,
  PlayerStatus.alive,
  PlayerStatus.alive,
];

const _nicknames = [
  'Белый Волк',
  'Тень',
  'Рыцарь',
  'Ангел',
  'Феникс',
  'Гром',
  'Вороной',
  'Клинок',
  'Шторм',
  'Алмаз',
];

const _images = ['', '', '', '', '', '', '', '', '', ''];

const _dataState = TranslationContentState(
  roles: _roles,
  statuses: _statuses,
  images: _images,
  nicknames: _nicknames,
  game: 2,
  totalGames: 5,
);

const _obsScenes = ['Игровой стол', 'Ночь крупно', 'Перерыв', 'Камера ведущего'];

final _savedMapping = ObsSceneMapping(day: 'Игровой стол', night: 'Ночь крупно');

final _obsDisconnectedState = _dataState.copyWith(
  obs: ObsState(connected: false),
  obsScenes: _savedMapping,
);

final _obsNoRightsState = _dataState.copyWith(
  obs: ObsState(connected: true, controlLevel: 2, scenes: _obsScenes, currentScene: 'Игровой стол'),
);

final _obsConnectedState = _dataState.copyWith(
  obs: ObsState(connected: true, controlLevel: 4, scenes: _obsScenes, currentScene: 'Игровой стол'),
  obsScenes: ObsSceneMapping(day: 'Игровой стол', night: 'Старая ночь'),
);

final _obsConnectedObs = ObsState(connected: true, controlLevel: 4, scenes: _obsScenes, currentScene: 'Игровой стол');

final _clubState = TranslationContentState(
  roles: _roles,
  statuses: _statuses,
  images: _images,
  nicknames: _nicknames,
  obs: _obsConnectedObs,
  obsScenes: _savedMapping,
);

MockTranslationControlBloc _createMockBloc(TranslationContentState state) {
  final bloc = MockTranslationControlBloc();
  whenListen(
    bloc,
    const Stream<TranslationContentState>.empty(),
    initialState: state,
  );
  return bloc;
}

Widget _pageWidget(TranslationControlBloc bloc) => themedWidget(
      BlocProvider<TranslationControlBloc>.value(
        value: bloc,
        child: const TranslationControlContent(),
      ),
    );

Widget _clubPageWidget(TranslationContentState state) {
  final bloc = MockClubTranslationControlBloc();
  whenListen(bloc, const Stream<TranslationContentState>.empty(), initialState: state);
  return themedWidget(
    BlocProvider<ClubTranslationControlBloc>.value(
      value: bloc,
      child: const ClubTranslationControlContent(),
    ),
  );
}

/// Снимает golden со всех устройств; [expandObs] раскрывает панель OBS нажатием на её заголовок.
Future<void> _matchGolden(WidgetTester tester, Widget page, String name, {bool expandObs = false}) async {
  final builder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: appDevices)
    ..addScenario(widget: page, name: name);

  await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
  if (expandObs) {
    final headers = find.text('OBS');
    for (var i = 0; i < headers.evaluate().length; i++) {
      await tester.tap(headers.at(i));
    }
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
  }
  await screenMatchesGolden(
    tester,
    goldenName('translation_control/$name'),
    customPump: (t) => t.pump(),
  );
}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('TranslationControlPage golden tests', () {
    testGoldens('empty state', (tester) async {
      final bloc = _createMockBloc(const TranslationContentState());
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'empty');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('translation_control/empty'),
        customPump: (t) => t.pump(),
      );
    });

    testGoldens('data state with mixed statuses', (tester) async {
      final bloc = _createMockBloc(_dataState);
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'data');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('translation_control/data'),
        customPump: (t) => t.pump(),
      );
    });

    testGoldens('obs connected and collapsed', (tester) async {
      final bloc = _createMockBloc(_obsConnectedState);
      addTearDown(bloc.close);
      await _matchGolden(tester, _pageWidget(bloc), 'obs_connected_collapsed');
    });

    testGoldens('obs disconnected expanded with saved scenes', (tester) async {
      final bloc = _createMockBloc(_obsDisconnectedState);
      addTearDown(bloc.close);
      await _matchGolden(tester, _pageWidget(bloc), 'obs_disconnected', expandObs: true);
    });

    testGoldens('obs without scene switch permission expanded', (tester) async {
      final bloc = _createMockBloc(_obsNoRightsState);
      addTearDown(bloc.close);
      await _matchGolden(tester, _pageWidget(bloc), 'obs_no_rights', expandObs: true);
    });

    testGoldens('obs connected expanded with missing scene', (tester) async {
      final bloc = _createMockBloc(_obsConnectedState);
      addTearDown(bloc.close);
      await _matchGolden(tester, _pageWidget(bloc), 'obs_connected', expandObs: true);
    });

    testGoldens('club page with obs collapsed', (tester) async {
      await _matchGolden(tester, _clubPageWidget(_clubState), 'club_obs_collapsed');
    });

    testGoldens('club page with obs expanded', (tester) async {
      await _matchGolden(tester, _clubPageWidget(_clubState), 'club_obs_expanded', expandObs: true);
    });
  });
}
