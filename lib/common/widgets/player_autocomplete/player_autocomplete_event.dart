import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';

part 'player_autocomplete_event.freezed.dart';

@freezed
abstract class PlayerAutoCompleteEvent with _$PlayerAutoCompleteEvent {
  const factory PlayerAutoCompleteEvent.search(
    String query, {
    Completer<List<PlayerModel>>? completer,
  }) = PlayerAutoCompleteEventSearch;

  const factory PlayerAutoCompleteEvent.clear() = PlayerAutoCompleteEventClear;
}
