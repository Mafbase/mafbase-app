import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_dialog_state.freezed.dart';

@freezed
abstract class ProfileDialogState with _$ProfileDialogState {
  const factory ProfileDialogState({
    String? imageUrl,
    @Default(false) bool isLoading,
  }) = _ProfileDialogState;
}
