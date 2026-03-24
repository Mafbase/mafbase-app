import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'translation_control_event.freezed.dart';

@freezed
abstract class TranslationControlEvent with _$TranslationControlEvent {
  const factory TranslationControlEvent.changeRole({
    required int index,
    required PlayerRole role,
  }) = TranslationControlEventChangeRole;

  const factory TranslationControlEvent.changeStatus({
    required int index,
    required PlayerStatus status,
  }) = TranslationControlEventChangeStatus;

  const factory TranslationControlEvent.selectGame({
    required int gameIndex,
  }) = TranslationControlEventSelectGame;

  const factory TranslationControlEvent.stateReceived({
    required SeatingContent event,
  }) = TranslationControlEventStateReceived;

  const factory TranslationControlEvent.pageOpened() = TranslationControlEventPageOpened;
}
