import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState.tournaments({
    required bool isLoading,
    required List<TournamentModel> tournaments,
  }) = MainStateTournaments;

  const factory MainState.regulations() = MainStateRegulations;
}
