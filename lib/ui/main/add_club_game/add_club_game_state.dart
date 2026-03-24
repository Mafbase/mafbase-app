import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/ci_scheme_model.dart';
part 'add_club_game_state.freezed.dart';

@freezed
abstract class AddClubGameState with _$AddClubGameState {
  const factory AddClubGameState({
    @Default(true) bool isLoading,
    @Default(false) bool canEdit,
    @Default('') String clubName,
    @Default([]) List<CiSchemeModel> ciSchemes,
    @Default(false) bool isTournament,
  }) = _AddClubGameState;
}
