import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';

part 'seating_page_event.freezed.dart';

@freezed
class SeatingPageEvent with _$SeatingPageEvent {
  const factory SeatingPageEvent.addPair() = SeatingPageEventAddPair;

  const factory SeatingPageEvent.deletePair({
    required PlayerModel first,
    required PlayerModel second,
  }) = SeatingPageEventDeletePair;

  const factory SeatingPageEvent.pageOpened({required int tournamentId}) =
      SeatingPageEventPageOpened;
}
