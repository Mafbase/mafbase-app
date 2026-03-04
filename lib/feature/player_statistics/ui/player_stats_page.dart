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
import 'package:seating_generator_web/feature/player_statistics/domain/model/player_statistics_model.dart';
import 'package:seating_generator_web/utils.dart';

class PlayerStatsPage extends StatelessWidget {
  final int playerId;

  const PlayerStatsPage._({required this.playerId});

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
        child: PlayerStatsPage._(playerId: playerId),
      );
    },
  );

  void _navigateToPlayer(BuildContext context, int targetPlayerId) {
    context.push(
      PlayerStatsPage.createLocation(
        context: context,
        playerId: targetPlayerId,
      ),
    );
  }

  void _onBackPressed(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _onBackPressed(context),
        ),
        title: Text(context.locale.playerStatsTitle),
        backgroundColor: MyTheme.of(context).darkBlueColor,
        foregroundColor: Colors.white,
      ),
      backgroundColor: MyTheme.of(context).background1,
      body: BlocBuilder<PlayerStatsBloc, PlayerStatsState>(
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
            onPlayerTap: (id) => _navigateToPlayer(context, id),
          );
        },
      ),
    );
  }
}

class _PlayerStatsContent extends StatelessWidget {
  final PlayerStatisticsModel statistics;
  final void Function(int playerId) onPlayerTap;

  const _PlayerStatsContent({
    required this.statistics,
    required this.onPlayerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Center(
                child: Text(
                  statistics.nickname,
                  style: MyTheme.of(context).headerTextStyle,
                ),
              ),
            ),
            const SizedBox(height: 8),
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
            const SizedBox(height: 8),
            PlayerPairStatsSection(
              title: context.locale.playerStatsSameCityTop,
              pairs: statistics.sameCityTop,
              onPlayerTap: onPlayerTap,
            ),
            PlayerPairStatsSection(
              title: context.locale.playerStatsSameMafiaTop,
              pairs: statistics.sameMafiaTop,
              onPlayerTap: onPlayerTap,
            ),
            PlayerPairStatsSection(
              title: context.locale.playerStatsDiffTeamTop,
              pairs: statistics.diffTeamTop,
              onPlayerTap: onPlayerTap,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
