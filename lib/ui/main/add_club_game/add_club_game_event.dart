import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'add_club_game_event.freezed.dart';

@freezed
class AddClubGameEvent with _$AddClubGameEvent {
  const factory AddClubGameEvent.pageOpened({int? gameId}) =
      AddClubGameEventPageOpened;

  const factory AddClubGameEvent.submit({required ClubGameResult gameResult}) =
      AddClubGameEventSubmit;
}
