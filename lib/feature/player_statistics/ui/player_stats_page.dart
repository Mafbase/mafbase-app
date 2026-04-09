import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_bloc.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_event.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_state.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/widgets/player_pair_stats_section.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/widgets/player_role_stats_card.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/widgets/best_move_distribution_chart.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/widgets/role_distribution_chart.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/model/player_statistics_model.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

@RoutePage()
class PlayerStatsPage extends StatelessWidget {
  final int playerId;

  const PlayerStatsPage({super.key, @PathParam('playerId') required this.playerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerStatsBloc>(
      create: (context) => PlayerStatsBloc(
        RepositoryFactory.of(context).playerStatisticsRepository,
      )..add(PlayerStatsEvent.pageOpened(playerId: playerId)),
      child: PlayerStatsView(playerId: playerId),
    );
  }
}

class PlayerStatsView extends StatelessWidget {
  final int playerId;

  const PlayerStatsView({super.key, required this.playerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.playerStatsTitle),
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: BlocBuilder<PlayerStatsBloc, PlayerStatsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const LoadingOverlayWidget();
            }

            if (state.hasError) {
              return Center(
                child: Text(
                  context.locale.playerStatsError,
                  style: MyTheme.of(context).defaultTextStyle,
                ),
              );
            }

            final statistics = state.statistics;
            if (statistics == null) {
              return const SizedBox.shrink();
            }

            return _PlayerStatsContent(
              statistics: statistics,
            );
          },
        ),
      ),
    );
  }
}

class _PlayerStatsContent extends StatefulWidget {
  final PlayerStatisticsModel statistics;

  const _PlayerStatsContent({
    required this.statistics,
  });

  @override
  State<_PlayerStatsContent> createState() => _PlayerStatsContentState();
}

class _PlayerStatsContentState extends CustomState<_PlayerStatsContent> {
  PlayerStatisticsModel get statistics => widget.statistics;

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            statistics.nickname,
            style: MyTheme.of(context).headerTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    return RoleDistributionChart(statistics: statistics);
  }

  List<Widget> _buildRoleCards(BuildContext context) {
    return [
      PlayerRoleStatsCard(
        title: context.locale.playerStatsOverall,
        stats: statistics.overall,
      ),
      PlayerRoleStatsCard(
        title: context.locale.playerStatsCitizen,
        stats: statistics.citizen,
        extraLabel: context.locale.playerStatsFirstNightDeaths,
        extraTitle: statistics.citizen.extraTitle,
      ),
      PlayerRoleStatsCard(
        title: context.locale.playerStatsSheriff,
        stats: statistics.sheriff,
        extraLabel: context.locale.playerStatsFirstNightDeaths,
        extraTitle: statistics.sheriff.extraTitle,
      ),
      PlayerRoleStatsCard(
        title: context.locale.playerStatsMafia,
        stats: statistics.mafia,
        extraLabel: context.locale.playerStatsSelfShots,
        extraTitle: statistics.mafia.extraTitle,
      ),
      PlayerRoleStatsCard(
        title: context.locale.playerStatsDon,
        stats: statistics.don,
        extraLabel: context.locale.playerStatsSelfShots,
        extraTitle: statistics.mafia.extraTitle,
      ),
    ];
  }

  List<Widget> _buildPairSections(BuildContext context) {
    return [
      PlayerPairStatsSection(
        title: context.locale.playerStatsSameCityTop,
        pairs: statistics.sameCityTop,
      ),
      PlayerPairStatsSection(
        title: context.locale.playerStatsSameMafiaTop,
        pairs: statistics.sameMafiaTop,
      ),
      PlayerPairStatsSection(
        title: context.locale.playerStatsDiffTeamTop,
        pairs: statistics.diffTeamTop,
      ),
      PlayerPairStatsSection(
        title: context.locale.playerStatsSameCityBottom,
        pairs: statistics.sameCityBottom,
      ),
      PlayerPairStatsSection(
        title: context.locale.playerStatsSameMafiaBottom,
        pairs: statistics.sameMafiaBottom,
      ),
      PlayerPairStatsSection(
        title: context.locale.playerStatsDiffTeamBottom,
        pairs: statistics.diffTeamBottom,
      ),
    ];
  }

  Widget _buildBestMoveChart() {
    return BestMoveDistributionChart(distribution: statistics.bestMoveDistribution);
  }

  @override
  Widget? buildMobile(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            _buildHeader(context),
            const SizedBox(height: 8),
            _buildChart(),
            const SizedBox(height: 8),
            _buildBestMoveChart(),
            const SizedBox(height: 8),
            ..._buildRoleCards(context).map(
              (e) => SizedBox(
                width: double.infinity,
                child: e,
              ),
            ),
            const SizedBox(height: 8),
            ..._buildPairSections(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      children: [
        _buildHeader(context),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            _buildChart(),
            _buildBestMoveChart(),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: _buildRoleCards(context),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: _buildPairSections(context).map((section) => SizedBox(width: 380, child: section)).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

extension _StatsExt on PlayerRoleStatsModel {
  String get extraTitle {
    final total = games;
    final dies = firstNightDeaths;

    if (games == 0) return '0% (0)';

    return '${(dies/total*100).toStringAsFixed(1)}% ($dies)';
  }
}