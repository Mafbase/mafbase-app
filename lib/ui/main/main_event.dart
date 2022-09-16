import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/app/router.dart';

part 'main_event.freezed.dart';

@freezed
class MainEvent with _$MainEvent {
  const factory MainEvent.switchTab({required MainPageTab tab}) =
      MainEventSwitchTab;

  const factory MainEvent.init() = MainEventInit;

  const factory MainEvent.backButtonPressed() = MainEventBackButtonPressed;
}
