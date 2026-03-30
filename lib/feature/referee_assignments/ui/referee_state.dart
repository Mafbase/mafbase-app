import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/feature/referee_assignments/domain/referee_assignment_model.dart';

part 'referee_state.freezed.dart';

@freezed
abstract class RefereeState with _$RefereeState {
  const factory RefereeState({
    @Default(true) bool loading,
    @Default([]) List<RefereeAssignmentModel> assignments,
  }) = _RefereeState;
}
