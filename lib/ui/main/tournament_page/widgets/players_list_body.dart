import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_event.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_state.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/player_row.dart';

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
              itemBuilder: (context, index) => PlayerRow(
                onTap: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null && mounted) {
                    context.read<TournamentPageBloc>().add(
                          TournamentPageEvent.addPhoto(
                            playerId: state.tournamentPlayers[index].id,
                            bytes: Uint8List.fromList(await image.openRead().fold(<int>[], (previous, element) => previous + element)),
                            filename: image.name,
                          ),
                        );
                  }
                },
                onDelete: () {},
                nickname: state.tournamentPlayers[index].nickname,
                imageUrl:
                    "https://www.meme-arsenal.com/memes/a2060f59f1cbf8633c417fda93611194.jpg",
              ),
            ),
            if (state.isLoading) const LoadingOverlayWidget(),
          ],
        );
      },
    );
  }
}
