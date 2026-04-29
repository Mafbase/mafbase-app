import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/widgets/game_result_widget.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/feature/club_games/club_games_bloc.dart';
import 'package:seating_generator_web/feature/club_games/club_games_event.dart';
import 'package:seating_generator_web/feature/club_games/club_games_state.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

@RoutePage()
class ClubGamesPage extends StatelessWidget {
  final int clubId;
  final String? dateStartParam;
  final String? dateEndParam;

  const ClubGamesPage({
    super.key,
    @PathParam('clubId') required this.clubId,
    @QueryParam('date-start') this.dateStartParam,
    @QueryParam('date-end') this.dateEndParam,
  });

  @override
  Widget build(BuildContext context) {
    final dateStart = DateTime.tryParse(dateStartParam ?? '') ?? DateTime.now().subtract(const Duration(days: 30));
    final dateEnd = DateTime.tryParse(dateEndParam ?? '') ?? DateTime.now();
    final range = DateTimeRange(start: dateStart, end: dateEnd);

    return BlocProvider(
      create: (context) {
        final repository = RepositoryFactory.of(context).clubRepository;
        return ClubGamesBloc(const ClubGamesState(), repository)
          ..add(ClubGamesEvent.init(clubId: clubId, range: range, sort: 'asc'));
      },
      child: _ClubGamesPageContent(clubId: clubId, range: range),
    );
  }
}

class _ClubGamesPageContent extends StatefulWidget {
  final int clubId;
  final DateTimeRange range;

  const _ClubGamesPageContent({required this.clubId, required this.range});

  @override
  State<_ClubGamesPageContent> createState() => _ClubGamesPageState();
}

class _ClubGamesPageState extends CustomState<_ClubGamesPageContent> {
  @override
  Widget buildDesktop(BuildContext context) => BlocBuilder<ClubGamesBloc, ClubGamesState>(
    builder: (context, state) => Scaffold(
      appBar: AppBar(leading: const BackButton(), title: const Text('Игры клуба')),
      body: state.loading
          ? const LoadingOverlayWidget()
          : LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = (constraints.maxWidth - 16) / (GameResultWidget.baseWidth + 16);

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount.floor(),
                    mainAxisSpacing: 16,
                  ),
                  itemCount: state.games.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () => openGame(state.games[index].gameId),
                        child: GameResultWidget(model: state.games[index]),
                      ),
                    );
                  },
                );
              },
            ),
    ),
  );

  @override
  Widget? buildMobile(BuildContext context) => BlocBuilder<ClubGamesBloc, ClubGamesState>(
    builder: (context, state) => Scaffold(
      appBar: AppBar(leading: const BackButton(), title: const Text('Игры клуба')),
      body: state.loading
          ? const LoadingOverlayWidget()
          : PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.games.length,
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraints) {
                  final double coef;

                  final widthCoef = (constraints.maxWidth - 32) / GameResultWidget.baseWidth;

                  final heightCoef = (constraints.maxHeight - 32) / GameResultWidget.baseHeight;

                  coef = min(widthCoef, heightCoef);

                  return Center(
                    child: GestureDetector(
                      onTap: () => openGame(state.games[index].gameId),
                      child: GameResultWidget(
                        model: state.games[index].copyWith(game: index + 1, table: 1),
                        width: GameResultWidget.baseWidth * coef,
                        height: GameResultWidget.baseHeight * coef,
                      ),
                    ),
                  );
                },
              ),
            ),
    ),
  );

  void openGame(int gameId) => context.router.push(ClubGameDetailRoute(clubId: widget.clubId, gameId: gameId));
}
