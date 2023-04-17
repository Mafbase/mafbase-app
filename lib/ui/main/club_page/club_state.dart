import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';

part 'club_state.freezed.dart';

@freezed
class ClubState with _$ClubState {
  const factory ClubState({
    @Default(true) isLoading,
    ClubModel? model,
    @Default(false) isOwner,
  }) = _ClubState;
}
