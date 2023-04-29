import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/app/router.dart';

part 'main_event.freezed.dart';

@freezed
class MainEvent with _$MainEvent {
  const factory MainEvent.switchTab({
    required MainPageTab tab,
    @Default(false) disableNavigate,
    @Default(true) bool hasBackButton,
  }) = MainEventSwitchTab;

  const factory MainEvent.backButtonPressed() = MainEventBackButtonPressed;

  const factory MainEvent.onPageOpened() = MainEventPageOpened;

  const factory MainEvent.tournamentSelected({required int tournamentId}) =
      MainEventTournamentSelected;

  const factory MainEvent.onTitleTapped() = MainEventTitleTapped;

  const factory MainEvent.onEnterPressed() = MainEventEnterPressed;
}
