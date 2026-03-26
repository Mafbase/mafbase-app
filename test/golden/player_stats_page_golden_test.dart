import 'golden_utils.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/model/player_statistics_model.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_bloc.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_event.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_page.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_state.dart';

class MockPlayerStatsBloc extends MockBloc<PlayerStatsEvent, PlayerStatsState> implements PlayerStatsBloc {}

const _fullStatistics = PlayerStatisticsModel(
  playerId: 1,
  nickname: 'Белый Волк',
  overall: PlayerRoleStatsModel(
    games: 120,
    wins: 78,
    winRate: 65.0,
    avgBonusScore: 0.42,
    firstNightDeaths: 15,
  ),
  citizen: PlayerRoleStatsModel(
    games: 55,
    wins: 38,
    winRate: 69.1,
    avgBonusScore: 0.35,
    firstNightDeaths: 8,
  ),
  mafia: PlayerRoleStatsModel(
    games: 35,
    wins: 20,
    winRate: 57.1,
    avgBonusScore: 0.51,
    firstNightDeaths: 3,
  ),
  don: PlayerRoleStatsModel(
    games: 18,
    wins: 12,
    winRate: 66.7,
    avgBonusScore: 0.60,
    firstNightDeaths: 2,
  ),
  sheriff: PlayerRoleStatsModel(
    games: 12,
    wins: 8,
    winRate: 66.7,
    avgBonusScore: 0.38,
    firstNightDeaths: 2,
  ),
  sameCityTop: [
    PlayerPairStatModel(
      playerId: 2,
      nickname: 'Тень',
      games: 30,
      wins: 22,
      winRate: 73.3,
    ),
    PlayerPairStatModel(
      playerId: 3,
      nickname: 'Рыцарь',
      games: 25,
      wins: 17,
      winRate: 68.0,
    ),
    PlayerPairStatModel(
      playerId: 4,
      nickname: 'Ангел',
      games: 20,
      wins: 14,
      winRate: 70.0,
    ),
    PlayerPairStatModel(
      playerId: 5,
      nickname: 'Феникс',
      games: 18,
      wins: 11,
      winRate: 61.1,
    ),
    PlayerPairStatModel(
      playerId: 6,
      nickname: 'Гром',
      games: 15,
      wins: 10,
      winRate: 66.7,
    ),
  ],
  sameMafiaTop: [
    PlayerPairStatModel(
      playerId: 7,
      nickname: 'Вороной',
      games: 22,
      wins: 15,
      winRate: 68.2,
    ),
    PlayerPairStatModel(
      playerId: 8,
      nickname: 'Клинок',
      games: 18,
      wins: 12,
      winRate: 66.7,
    ),
    PlayerPairStatModel(
      playerId: 9,
      nickname: 'Шторм',
      games: 14,
      wins: 9,
      winRate: 64.3,
    ),
  ],
  diffTeamTop: [
    PlayerPairStatModel(
      playerId: 10,
      nickname: 'Алмаз',
      games: 28,
      wins: 20,
      winRate: 71.4,
    ),
    PlayerPairStatModel(
      playerId: 11,
      nickname: 'Сокол',
      games: 24,
      wins: 16,
      winRate: 66.7,
    ),
  ],
  sameCityBottom: [
    PlayerPairStatModel(
      playerId: 12,
      nickname: 'Молния',
      games: 20,
      wins: 8,
      winRate: 40.0,
    ),
    PlayerPairStatModel(
      playerId: 13,
      nickname: 'Туман',
      games: 18,
      wins: 6,
      winRate: 33.3,
    ),
  ],
  sameMafiaBottom: [
    PlayerPairStatModel(
      playerId: 14,
      nickname: 'Пепел',
      games: 15,
      wins: 4,
      winRate: 26.7,
    ),
  ],
  diffTeamBottom: [
    PlayerPairStatModel(
      playerId: 15,
      nickname: 'Кремень',
      games: 22,
      wins: 7,
      winRate: 31.8,
    ),
    PlayerPairStatModel(
      playerId: 16,
      nickname: 'Искра',
      games: 19,
      wins: 5,
      winRate: 26.3,
    ),
  ],
  bestMoveDistribution: BestMoveDistributionModel(
    miss: 10,
    one: 15,
    half: 8,
    full: 5,
  ),
);

const _emptyPairsStatistics = PlayerStatisticsModel(
  playerId: 2,
  nickname: 'Новичок',
  overall: PlayerRoleStatsModel(
    games: 3,
    wins: 1,
    winRate: 33.3,
    avgBonusScore: 0.10,
    firstNightDeaths: 1,
  ),
  citizen: PlayerRoleStatsModel(
    games: 2,
    wins: 1,
    winRate: 50.0,
    avgBonusScore: 0.05,
    firstNightDeaths: 1,
  ),
  mafia: PlayerRoleStatsModel(
    games: 1,
    wins: 0,
    winRate: 0.0,
    avgBonusScore: 0.0,
    firstNightDeaths: 0,
  ),
  don: PlayerRoleStatsModel(
    games: 0,
    wins: 0,
    winRate: 0.0,
    avgBonusScore: 0.0,
    firstNightDeaths: 0,
  ),
  sheriff: PlayerRoleStatsModel(
    games: 0,
    wins: 0,
    winRate: 0.0,
    avgBonusScore: 0.0,
    firstNightDeaths: 0,
  ),
  sameCityTop: [],
  sameMafiaTop: [],
  diffTeamTop: [],
  sameCityBottom: [],
  sameMafiaBottom: [],
  diffTeamBottom: [],
  bestMoveDistribution: BestMoveDistributionModel(
    miss: 0,
    one: 0,
    half: 0,
    full: 0,
  ),
);

MockPlayerStatsBloc _createMockBloc(PlayerStatsState state) {
  final bloc = MockPlayerStatsBloc();
  whenListen(
    bloc,
    const Stream<PlayerStatsState>.empty(),
    initialState: state,
  );
  return bloc;
}

Widget _pageWidget(PlayerStatsBloc bloc) => themedWidget(
      BlocProvider<PlayerStatsBloc>.value(
        value: bloc,
        child: const PlayerStatsPage(playerId: 1),
      ),
    );

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('PlayerStatsPage golden tests', () {
    testGoldens('loading state', (tester) async {
      final bloc = _createMockBloc(const PlayerStatsState(isLoading: true));
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'loading');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('player_stats_loading'),
        customPump: (t) => t.pump(),
      );
    });

    testGoldens('error state', (tester) async {
      final bloc = _createMockBloc(
        const PlayerStatsState(isLoading: false, hasError: true),
      );
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'error');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(tester, goldenName('player_stats_error'));
    });

    testGoldens('data state — full page', (tester) async {
      final bloc = _createMockBloc(
        const PlayerStatsState(
          isLoading: false,
          statistics: _fullStatistics,
        ),
      );
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'data');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(tester, goldenName('player_stats_data'));
    });

    testGoldens('data state — empty pair lists', (tester) async {
      final bloc = _createMockBloc(
        const PlayerStatsState(
          isLoading: false,
          statistics: _emptyPairsStatistics,
        ),
      );
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'empty_pairs');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(tester, goldenName('player_stats_empty_pairs'));
    });
  });
}
