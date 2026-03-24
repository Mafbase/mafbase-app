import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';
part 'tournaments_state.freezed.dart';

@freezed
abstract class TournamentsState with _$TournamentsState {
  const factory TournamentsState({
    required List<TournamentModel> tournaments,
    required bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(true) bool hasMore,
    @Default('') String searchQuery,
  }) = _TournamentsState;
}
