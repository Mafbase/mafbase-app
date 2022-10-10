import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_event.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_state.dart';

class PlayersListBody extends StatefulWidget {
  const PlayersListBody({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentPageBloc, TournamentPageState>(
      builder: (context, state) {
        return Stack(
          children: [
            ListView.builder(
              itemCount: state.tournamentPlayers.length,
              itemBuilder: (context, index) =>
                  Text(state.tournamentPlayers[index].toString()),
            ),
            if (state.isLoading) const LoadingOverlayWidget(),
          ],
        );
      },
    );
  }
}
