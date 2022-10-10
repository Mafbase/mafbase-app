import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';

part 'tournament_page_state.freezed.dart';

@freezed
class TournamentPageState with _$TournamentPageState {
  const factory TournamentPageState({
    @Default(true) bool isLoading,
    @Default([]) List<PlayerModel> players,
    @Default([]) List<PlayerModel> tournamentPlayers,
    @Default([]) List<List<PlayerModel>> cannotMeet,
  }) = _TournamentPageState;
}
