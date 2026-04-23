import 'package:auto_route/annotations.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/player_row.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_action.dart';
import 'package:seating_generator_web/utils.dart';

@RoutePage(name: 'TournamentPlayersRoute')
class PlayersListBody extends StatelessWidget {
  const PlayersListBody({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: context.backOrNavigateTo(const TournamentsRoute())),
          title: Text(context.locale.participants),
          actions: [
            TournamentMenuAction(
              openDrawer: () => Scaffold.of(context).openEndDrawer(),
            ),
          ],
        ),
        body: BlocBuilder<TournamentPageBloc, TournamentPageState>(
          builder: (context, state) => Stack(
            children: [
              state.tournamentPlayers.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          context.locale.tournamentMenuNoPlayers,
                          textAlign: TextAlign.center,
                          style: MyTheme.of(context).defaultTextStyle,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: state.tournamentPlayers.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: MyTheme.of(context).greyColor.withValues(alpha: 0.3),
                      ),
                      itemBuilder: (context, index) {
                        final player = state.tournamentPlayers[index];
                        final resolvedImageUrl = state.activeThemePhotos[player.id] ?? player.imageUrl;
                        return PlayerRow(
                          index: index,
                          player: player,
                          imageUrlOverride: resolvedImageUrl != player.imageUrl ? resolvedImageUrl : null,
                          onTap: state.isMyTournament
                              ? () async {
                                  context.read<TournamentPageBloc>().add(
                                        TournamentPageEvent.openProfileDialog(
                                          player: player,
                                        ),
                                      );
                                }
                              : null,
                          onSubstitute: state.isMyTournament
                              ? () {
                                  context.read<TournamentPageBloc>().add(
                                        TournamentPageEvent.substitutePlayer(
                                          oldPlayer: player,
                                        ),
                                      );
                                }
                              : null,
                          onDelete: state.isMyTournament
                              ? () {
                                  final bloc = context.read<TournamentPageBloc>();
                                  ConfirmDialog.open(context).then((value) {
                                    if (value == true) {
                                      bloc.add(
                                        TournamentPageEvent.deletePlayer(
                                          player: player,
                                        ),
                                      );
                                    }
                                  });
                                }
                              : null,
                        );
                      },
                    ),
              if (state.isLoading) const LoadingOverlayWidget(),
            ],
          ),
        ),
      );
}
