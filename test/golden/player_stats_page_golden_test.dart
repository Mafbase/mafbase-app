import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/model/player_statistics_model.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_bloc.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_event.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_page.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_state.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

class MockPlayerStatsBloc
    extends MockBloc<PlayerStatsEvent, PlayerStatsState>
    implements PlayerStatsBloc {}

const _fullStatistics = PlayerStatisticsModel(
  playerId: 1,
  nickname: 'Белый Волк',
  overall: PlayerRoleStatsModel(
    games: 120,
    wins: 78,
    winRate: 65.0,
    avgBonusScore: 0.42,
  ),
  citizen: PlayerRoleStatsModel(
    games: 55,
    wins: 38,
    winRate: 69.1,
    avgBonusScore: 0.35,
  ),
  mafia: PlayerRoleStatsModel(
    games: 35,
    wins: 20,
    winRate: 57.1,
    avgBonusScore: 0.51,
  ),
  don: PlayerRoleStatsModel(
    games: 18,
    wins: 12,
    winRate: 66.7,
    avgBonusScore: 0.60,
  ),
  sheriff: PlayerRoleStatsModel(
    games: 12,
    wins: 8,
    winRate: 66.7,
    avgBonusScore: 0.38,
  ),
  sameCityTop: [
    PlayerPairStatModel(
        playerId: 2, nickname: 'Тень', games: 30, wins: 22, winRate: 73.3),
    PlayerPairStatModel(
        playerId: 3, nickname: 'Рыцарь', games: 25, wins: 17, winRate: 68.0),
    PlayerPairStatModel(
        playerId: 4, nickname: 'Ангел', games: 20, wins: 14, winRate: 70.0),
    PlayerPairStatModel(
        playerId: 5, nickname: 'Феникс', games: 18, wins: 11, winRate: 61.1),
    PlayerPairStatModel(
        playerId: 6, nickname: 'Гром', games: 15, wins: 10, winRate: 66.7),
  ],
  sameMafiaTop: [
    PlayerPairStatModel(
        playerId: 7, nickname: 'Вороной', games: 22, wins: 15, winRate: 68.2),
    PlayerPairStatModel(
        playerId: 8, nickname: 'Клинок', games: 18, wins: 12, winRate: 66.7),
    PlayerPairStatModel(
        playerId: 9, nickname: 'Шторм', games: 14, wins: 9, winRate: 64.3),
  ],
  diffTeamTop: [
    PlayerPairStatModel(
        playerId: 10, nickname: 'Алмаз', games: 28, wins: 20, winRate: 71.4),
    PlayerPairStatModel(
        playerId: 11, nickname: 'Сокол', games: 24, wins: 16, winRate: 66.7),
  ],
);

const _emptyPairsStatistics = PlayerStatisticsModel(
  playerId: 2,
  nickname: 'Новичок',
  overall: PlayerRoleStatsModel(
      games: 3, wins: 1, winRate: 33.3, avgBonusScore: 0.10),
  citizen: PlayerRoleStatsModel(
      games: 2, wins: 1, winRate: 50.0, avgBonusScore: 0.05),
  mafia: PlayerRoleStatsModel(
      games: 1, wins: 0, winRate: 0.0, avgBonusScore: 0.0),
  don: PlayerRoleStatsModel(
      games: 0, wins: 0, winRate: 0.0, avgBonusScore: 0.0),
  sheriff: PlayerRoleStatsModel(
      games: 0, wins: 0, winRate: 0.0, avgBonusScore: 0.0),
  sameCityTop: [],
  sameMafiaTop: [],
  diffTeamTop: [],
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

Widget _buildPage(PlayerStatsBloc bloc) {
  return Provider<MyTheme>.value(
    value: MyTheme.light(false),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('ru'),
      home: BlocProvider<PlayerStatsBloc>.value(
        value: bloc,
        child: const PlayerStatsPage(playerId: 1),
      ),
    ),
  );
}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('PlayerStatsPage golden tests', () {
    testWidgets('loading state', (tester) async {
      final bloc = _createMockBloc(const PlayerStatsState(isLoading: true));

      await tester.pumpWidget(_buildPage(bloc));
      await tester.pump();
      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/player_stats_loading.png'),
      );

      await bloc.close();
    });

    testWidgets('error state', (tester) async {
      final bloc = _createMockBloc(
        const PlayerStatsState(isLoading: false, hasError: true),
      );

      await tester.pumpWidget(_buildPage(bloc));
      await tester.pump();
      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/player_stats_error.png'),
      );

      await bloc.close();
    });

    testWidgets('data state — full page', (tester) async {
      final bloc = _createMockBloc(
        const PlayerStatsState(
          isLoading: false,
          statistics: _fullStatistics,
        ),
      );

      await tester.pumpWidget(_buildPage(bloc));
      await tester.pump();
      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/player_stats_data.png'),
      );

      await bloc.close();
    });

    testWidgets('data state — empty pair lists', (tester) async {
      final bloc = _createMockBloc(
        const PlayerStatsState(
          isLoading: false,
          statistics: _emptyPairsStatistics,
        ),
      );

      await tester.pumpWidget(_buildPage(bloc));
      await tester.pump();
      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/player_stats_empty_pairs.png'),
      );

      await bloc.close();
    });
  });
}
