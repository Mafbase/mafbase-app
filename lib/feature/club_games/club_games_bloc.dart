import 'package:collection/collection.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/feature/club_games/club_games_event.dart';
import 'package:seating_generator_web/feature/club_games/club_games_state.dart';

class ClubGamesBloc extends Bloc<ClubGamesEvent, ClubGamesState> {
  final ClubRepository repository;

  ClubGamesBloc(
    super.initialState,
    this.repository,
  ) {
    on<ClubGamesEventInit>(_init);
  }

  Future<void> _init(
    ClubGamesEventInit event,
    Emitter<ClubGamesState> emit,
  ) async {
    emit(state.copyWith(loading: true, sort: event.sort));
    try {
      final games = await repository.getGames(
        clubId: event.clubId,
        range: event.range,
        sort: event.sort,
      );

      emit(
        state.copyWith(
          loading: false,
          games: games.mapIndexed((index, e) {
            final gameNumber = event.sort == 'desc' ? games.length - index : index + 1;
            return e.copyWith(table: 1, game: gameNumber);
          }).toList(),
        ),
      );
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
