import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_event.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_state.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/player_row.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/widgets/photo_theme_selector.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_page.dart';
import 'package:seating_generator_web/utils.dart';

class PlayersListBody extends StatefulWidget {
  final int tournamentId;

  const PlayersListBody({
    super.key,
    required this.tournamentId,
  });

  @override
  State<PlayersListBody> createState() => _PlayersListBodyState();
}

class _PlayersListBodyState extends State<PlayersListBody> {
  @override
  void initState() {
    context.read<TournamentPageBloc>().add(
          const TournamentPageEvent.playersListOpened(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: Navigator.canPop(context) ? () => Navigator.pop(context) : () => context.go(TournamentsPage.createLocation(context)),
          ),
          title: Text(context.locale.participants),
        ),
        body: Container(
          color: MyTheme.of(context).background2,
          child: BlocBuilder<TournamentPageBloc, TournamentPageState>(
            builder: (context, state) {
              final selectedTheme = state.photoThemes.where((t) => t.id == state.activePhotoThemeId).firstOrNull;

              return Stack(
                children: [
                  Column(
                    children: [
                      if (state.isMyTournament && state.photoThemes.isNotEmpty)
                        PhotoThemeSelector(
                          themes: state.photoThemes,
                          selectedTheme: selectedTheme,
                          onChanged: (theme) {
                            context.read<TournamentPageBloc>().add(
                                  TournamentPageEvent.setActivePhotoTheme(
                                    themeId: theme?.id,
                                  ),
                                );
                          },
                        ),
                      Expanded(
                        child: state.tournamentPlayers.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    'Пока не добавлен ни один участник',
                                    textAlign: TextAlign.center,
                                    style: MyTheme.of(context).defaultTextStyle,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: state.tournamentPlayers.length,
                                itemBuilder: (context, index) {
                                  final player = state.tournamentPlayers[index];
                                  final resolvedImageUrl = state.activeThemePhotos[player.id] ?? player.imageUrl;
                                  return PlayerRow(
                                    index: index,
                                    onTap: state.isMyTournament
                                        ? () async {
                                            context.read<TournamentPageBloc>().add(
                                                  TournamentPageEvent.openProfileDialog(
                                                    player: player,
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
                                    nickname: player.nickname,
                                    imageUrl: resolvedImageUrl,
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                  if (state.isLoading) const LoadingOverlayWidget(),
                ],
              );
            },
          ),
        ),
      );
}
