import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/model/player_statistics_model.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_bloc.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_state.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/widgets/player_pair_stats_section.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/widgets/player_role_stats_card.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

const _mockStatistics = PlayerStatisticsModel(
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
    PlayerPairStatModel(playerId: 2, nickname: 'Тень', games: 30, wins: 22, winRate: 73.3),
    PlayerPairStatModel(playerId: 3, nickname: 'Рыцарь', games: 25, wins: 17, winRate: 68.0),
    PlayerPairStatModel(playerId: 4, nickname: 'Ангел', games: 20, wins: 14, winRate: 70.0),
    PlayerPairStatModel(playerId: 5, nickname: 'Феникс', games: 18, wins: 11, winRate: 61.1),
    PlayerPairStatModel(playerId: 6, nickname: 'Гром', games: 15, wins: 10, winRate: 66.7),
  ],
  sameMafiaTop: [
    PlayerPairStatModel(playerId: 7, nickname: 'Вороной', games: 22, wins: 15, winRate: 68.2),
    PlayerPairStatModel(playerId: 8, nickname: 'Клинок', games: 18, wins: 12, winRate: 66.7),
    PlayerPairStatModel(playerId: 9, nickname: 'Шторм', games: 14, wins: 9, winRate: 64.3),
  ],
  diffTeamTop: [
    PlayerPairStatModel(playerId: 10, nickname: 'Алмаз', games: 28, wins: 20, winRate: 71.4),
    PlayerPairStatModel(playerId: 11, nickname: 'Сокол', games: 24, wins: 16, winRate: 66.7),
  ],
);

Widget _buildTestableWidget(Widget child) {
  return Provider<MyTheme>.value(
    value: MyTheme.light(false),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('ru'),
      home: child,
    ),
  );
}

void main() {
  group('PlayerStatsPage golden tests', () {
    testWidgets('loading state', (tester) async {
      await tester.pumpWidget(
        _buildTestableWidget(
          Scaffold(
            appBar: AppBar(
              leading: const Icon(Icons.arrow_back, color: Colors.white),
              title: const Text('Статистика игрока'),
              backgroundColor: const Color(0xFF1A2D42),
              foregroundColor: Colors.white,
            ),
            backgroundColor: const Color(0xFFF5F5F5),
            body: const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/player_stats_loading.png'),
      );
    });

    testWidgets('error state', (tester) async {
      await tester.pumpWidget(
        _buildTestableWidget(
          Scaffold(
            appBar: AppBar(
              leading: const Icon(Icons.arrow_back, color: Colors.white),
              title: const Text('Статистика игрока'),
              backgroundColor: const Color(0xFF1A2D42),
              foregroundColor: Colors.white,
            ),
            backgroundColor: const Color(0xFFF5F5F5),
            body: const Center(
              child: Text('Не удалось загрузить статистику'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/player_stats_error.png'),
      );
    });

    testWidgets('data state — full page', (tester) async {
      await tester.pumpWidget(
        _buildTestableWidget(
          Scaffold(
            appBar: AppBar(
              leading: const Icon(Icons.arrow_back, color: Colors.white),
              title: const Text('Статистика игрока'),
              backgroundColor: const Color(0xFF1A2D42),
              foregroundColor: Colors.white,
            ),
            backgroundColor: const Color(0xFFF5F5F5),
            body: Builder(builder: (context) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Center(
                          child: Text(
                            _mockStatistics.nickname,
                            style: MyTheme.of(context).headerTextStyle,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      PlayerRoleStatsCard(
                        title: context.locale.playerStatsOverall,
                        stats: _mockStatistics.overall,
                      ),
                      PlayerRoleStatsCard(
                        title: context.locale.playerStatsCitizen,
                        stats: _mockStatistics.citizen,
                      ),
                      PlayerRoleStatsCard(
                        title: context.locale.playerStatsMafia,
                        stats: _mockStatistics.mafia,
                      ),
                      PlayerRoleStatsCard(
                        title: context.locale.playerStatsDon,
                        stats: _mockStatistics.don,
                      ),
                      PlayerRoleStatsCard(
                        title: context.locale.playerStatsSheriff,
                        stats: _mockStatistics.sheriff,
                      ),
                      const SizedBox(height: 8),
                      PlayerPairStatsSection(
                        title: context.locale.playerStatsSameCityTop,
                        pairs: _mockStatistics.sameCityTop,
                      ),
                      PlayerPairStatsSection(
                        title: context.locale.playerStatsSameMafiaTop,
                        pairs: _mockStatistics.sameMafiaTop,
                      ),
                      PlayerPairStatsSection(
                        title: context.locale.playerStatsDiffTeamTop,
                        pairs: _mockStatistics.diffTeamTop,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/player_stats_data.png'),
      );
    });

    testWidgets('data state — empty pair lists', (tester) async {
      await tester.pumpWidget(
        _buildTestableWidget(
          Scaffold(
            appBar: AppBar(
              leading: const Icon(Icons.arrow_back, color: Colors.white),
              title: const Text('Статистика игрока'),
              backgroundColor: const Color(0xFF1A2D42),
              foregroundColor: Colors.white,
            ),
            backgroundColor: const Color(0xFFF5F5F5),
            body: Builder(builder: (context) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Center(
                          child: Text(
                            'Новичок',
                            style: MyTheme.of(context).headerTextStyle,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      PlayerRoleStatsCard(
                        title: context.locale.playerStatsOverall,
                        stats: const PlayerRoleStatsModel(
                          games: 3,
                          wins: 1,
                          winRate: 33.3,
                          avgBonusScore: 0.10,
                        ),
                      ),
                      const SizedBox(height: 8),
                      PlayerPairStatsSection(
                        title: context.locale.playerStatsSameCityTop,
                        pairs: const [],
                      ),
                      PlayerPairStatsSection(
                        title: context.locale.playerStatsSameMafiaTop,
                        pairs: const [],
                      ),
                      PlayerPairStatsSection(
                        title: context.locale.playerStatsDiffTeamTop,
                        pairs: const [],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/player_stats_empty_pairs.png'),
      );
    });
  });
}

extension _LocaleExt on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this)!;
}
