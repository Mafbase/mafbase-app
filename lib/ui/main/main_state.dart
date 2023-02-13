import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/app/router.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    required bool isLoading,
    required MainPageTab selectedTab,
    required bool hasBackButton,
  }) = _MainState;
}
