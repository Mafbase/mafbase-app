import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/feature/club_games/club_games_event.dart';
import 'package:seating_generator_web/feature/club_games/club_games_state.dart';

class ClubGamesBloc extends CustomBloc<ClubGamesEvent, ClubGamesState> {
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
    final games = await repository.getGames(
      clubId: event.clubId,
      range: event.range,
    );

    emit(state.copyWith(
      loading: false,
      games: games,
    ));
  }

  @override
  void emitOnError(Emitter<ClubGamesState> emit) {
    emit(state.copyWith(loading: false));
  }
}
