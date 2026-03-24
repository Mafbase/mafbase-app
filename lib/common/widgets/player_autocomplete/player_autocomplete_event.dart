import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_autocomplete_event.freezed.dart';

@freezed
abstract class PlayerAutoCompleteEvent with _$PlayerAutoCompleteEvent {
  const factory PlayerAutoCompleteEvent.search(String query) = PlayerAutoCompleteEventSearch;

  const factory PlayerAutoCompleteEvent.clear() = PlayerAutoCompleteEventClear;
}
