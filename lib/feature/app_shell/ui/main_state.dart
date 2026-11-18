import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_state.freezed.dart';

@freezed
abstract class MainState with _$MainState {
  const factory MainState({
    required bool isLoading,
    required bool hasBackButton,
  }) = _MainState;
}
