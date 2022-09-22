import 'package:freezed_annotation/freezed_annotation.dart';

part 'seating_inserting_state.freezed.dart';

@freezed
class SeatingInsertingState with _$SeatingInsertingState {
  const factory SeatingInsertingState({@Default(false) bool isLoading}) =
      _SeatingInsertingState;
}
