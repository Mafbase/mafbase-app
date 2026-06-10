import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'club_translation_control_event.freezed.dart';

@freezed
abstract class ClubTranslationControlEvent with _$ClubTranslationControlEvent {
  const factory ClubTranslationControlEvent.pageOpened() = ClubTranslationControlEventPageOpened;

  const factory ClubTranslationControlEvent.stateReceived({required ClubSeatingContent content}) =
      ClubTranslationControlEventStateReceived;

  const factory ClubTranslationControlEvent.changeRole({required int index, required PlayerRole role}) =
      ClubTranslationControlEventChangeRole;

  const factory ClubTranslationControlEvent.changeStatus({required int index, required PlayerStatus status}) =
      ClubTranslationControlEventChangeStatus;

  const factory ClubTranslationControlEvent.changeBroadcastPhase({required BroadcastPhase phase}) =
      ClubTranslationControlEventChangeBroadcastPhase;

  const factory ClubTranslationControlEvent.changePlayer({required int index, required int playerId}) =
      ClubTranslationControlEventChangePlayer;

  const factory ClubTranslationControlEvent.startEditingPlayer({required int index}) =
      ClubTranslationControlEventStartEditingPlayer;
}
