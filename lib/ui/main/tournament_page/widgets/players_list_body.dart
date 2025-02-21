import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_event.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_state.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/player_row.dart';
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
  Widget build(BuildContext context) => Container(
      color: MyTheme.of(context).background2,
      child: BlocBuilder<TournamentPageBloc, TournamentPageState>(
        builder: (context, state) => Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    context.locale.participants,
                    style: MyTheme.of(context).headerTextStyle,
                  ),
                  const SizedBox(
                    height: 8,
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
                            itemBuilder: (context, index) => PlayerRow(
                              index: index,
                              onTap: state.isMyTournament
                                  ? () async {
                                      context.read<TournamentPageBloc>().add(
                                            TournamentPageEvent.openProfileDialog(
                                              player:
                                                  state.tournamentPlayers[index],
                                            ),
                                          );
                                    }
                                  : null,
                              onDelete: state.isMyTournament
                                  ? () {
                                      final bloc =
                                          context.read<TournamentPageBloc>();
                                      ConfirmDialog.open(context).then((value) {
                                        if (value == true) {
                                          bloc.add(
                                            TournamentPageEvent.deletePlayer(
                                              player:
                                                  state.tournamentPlayers[index],
                                            ),
                                          );
                                        }
                                      });
                                    }
                                  : null,
                              nickname: state.tournamentPlayers[index].nickname,
                              imageUrl: state.tournamentPlayers[index].imageUrl,
                            ),
                          ),
                  ),
                ],
              ),
              if (state.isLoading) const LoadingOverlayWidget(),
            ],
          ),
      ),
    );
}
