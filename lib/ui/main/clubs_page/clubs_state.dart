import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';

part 'clubs_state.freezed.dart';

@freezed
abstract class ClubsState with _$ClubsState {
  const factory ClubsState({
    @Default([]) List<ClubModel> clubs,
    @Default(true) bool isLoading,
  }) = _ClubsState;
}
