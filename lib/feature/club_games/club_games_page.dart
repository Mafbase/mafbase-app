import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/widgets/game_result_widget.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/feature/club_games/club_games_bloc.dart';
import 'package:seating_generator_web/feature/club_games/club_games_event.dart';
import 'package:seating_generator_web/feature/club_games/club_games_state.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class ClubGamesPage extends StatefulWidget {
  final int clubId;

  const ClubGamesPage({
    super.key,
    required this.clubId,
  });

  static const _name = 'club-games';

  static String createLocation({
    required BuildContext context,
    required int clubId,
    DateTimeRange? range,
  }) =>
      context.namedLocation(
        _name,
        pathParameters: {
          'clubId': clubId.toString(),
        },
        queryParameters: {
          'date-start': range?.start.toIso8601String(),
          'date-end': range?.end.toIso8601String(),
        },
      );

  static final GoRoute route = GoRoute(
    path: 'games',
    name: _name,
    builder: (context, state) {
      final clubId = int.parse(state.pathParameters['clubId']!);
      final dateStart = DateTime.tryParse(state.uri.queryParameters['date-start'] ?? '') ??
          DateTime.now().subtract(const Duration(days: 30));
      final dateEnd = DateTime.tryParse(state.uri.queryParameters['date-end'] ?? '') ?? DateTime.now();
      final range = DateTimeRange(start: dateStart, end: dateEnd);

      return BlocProvider(
        create: (context) {
          final repository = RepositoryFactory.of(context).clubRepository;

          return ClubGamesBloc(
            const ClubGamesState(),
            repository,
          )..add(ClubGamesEvent.init(clubId: clubId, range: range));
        },
        child: ClubGamesPage(clubId: clubId),
      );
    },
  );

  @override
  State<ClubGamesPage> createState() => _ClubGamesPageState();
}

class _ClubGamesPageState extends CustomState<ClubGamesPage> {
  @override
  Widget buildDesktop(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
              onPressed: context.backOrGoToDefault(
                  (c) => c.namedLocation('club', pathParameters: {'clubId': widget.clubId.toString()}))),
          title: const Text('Игры клуба'),
        ),
        body: BlocBuilder<ClubGamesBloc, ClubGamesState>(
          builder: (context, state) => state.loading
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
                            child: GameResultWidget(
                              model: state.games[index].copyWith(
                                game: index + 1,
                                table: 1,
                              ),
                            ),
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
          appBar: AppBar(
            leading: BackButton(
                onPressed: context.backOrGoToDefault(
                    (c) => c.namedLocation('club', pathParameters: {'clubId': widget.clubId.toString()}))),
            title: const Text('Игры клуба'),
          ),
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
                            model: state.games[index].copyWith(
                              game: index + 1,
                              table: 1,
                            ),
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

  void openGame(int gameId) => context.push(AddClubGamePage.createViewLocation(context, widget.clubId, gameId));
}
