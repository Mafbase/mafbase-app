import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_club_state.freezed.dart';

@freezed
abstract class AddClubState with _$AddClubState {
  const factory AddClubState({
    @Default(false) bool isLoading,
  }) = _AddClubState;
}
