import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournaments_events.freezed.dart';

@freezed
class TournamentsEvent with _$TournamentsEvent {
  const factory TournamentsEvent.opened({Completer? completer}) = TournamentOpenedEvent;

  const factory TournamentsEvent.create() = TournamentsEventCreate;
}
