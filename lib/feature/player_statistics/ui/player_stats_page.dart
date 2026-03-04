import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_bloc.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_event.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_state.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/widgets/player_pair_stats_section.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/widgets/player_role_stats_card.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/widgets/role_distribution_chart.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/model/player_statistics_model.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class PlayerStatsPage extends StatelessWidget {
  final int playerId;

  @visibleForTesting
  const PlayerStatsPage({super.key, required this.playerId});

  static String createLocation({
    required BuildContext context,
    required int playerId,
  }) {
    return context.namedLocation(
      'player_statistics',
      pathParameters: {'playerId': playerId.toString()},
    );
  }

  static final GoRoute route = GoRoute(
    path: '/player/:playerId/statistics',
    name: 'player_statistics',
    builder: (context, state) {
      final playerId = int.parse(state.pathParameters['playerId']!);
      return BlocProvider<PlayerStatsBloc>(
        create: (context) => PlayerStatsBloc(
          RepositoryFactory.of(context).playerStatisticsRepository,
        )..add(PlayerStatsEvent.pageOpened(playerId: playerId)),
        child: PlayerStatsPage(playerId: playerId),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.of(context).background1,
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
            context.locale.playerStatsTitle,
            style: MyTheme.of(context).defaultTextStyle,
          ),
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
      ),
      PlayerRoleStatsCard(
        title: context.locale.playerStatsMafia,
        stats: statistics.mafia,
      ),
      PlayerRoleStatsCard(
        title: context.locale.playerStatsDon,
        stats: statistics.don,
      ),
      PlayerRoleStatsCard(
        title: context.locale.playerStatsSheriff,
        stats: statistics.sheriff,
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
        _buildChart(),
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
