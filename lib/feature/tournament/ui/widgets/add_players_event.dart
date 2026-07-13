import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';

part 'add_players_event.freezed.dart';

@freezed
abstract class AddPlayersEvent with _$AddPlayersEvent {
  const factory AddPlayersEvent.playerAdded({required PlayerModel player}) = AddPlayersEventPlayerAdded;

  const factory AddPlayersEvent.playerUpdated({
    required int index,
    required PlayerModel player,
  }) = AddPlayersEventPlayerUpdated;

  const factory AddPlayersEvent.playerRemoved({required int index}) = AddPlayersEventPlayerRemoved;

  const factory AddPlayersEvent.submitted() = AddPlayersEventSubmitted;
}
