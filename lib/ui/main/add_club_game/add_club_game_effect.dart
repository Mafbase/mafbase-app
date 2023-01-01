import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'add_club_game_effect.freezed.dart';

@freezed
class AddClubGameEffect with _$AddClubGameEffect {
  const factory AddClubGameEffect.setValues({
    required List<String> players,
    required List<double> addScore,
    required List<PlayerRole> roles,
    required GameWin win,
    required BestMove bestMove,
    required String referee,
    required int died,
    required DateTime date,
  }) = AddClubGameEffectSetValues;

  const factory AddClubGameEffect.setPlayer({
    required int index,
    required PlayerModel player,
  }) = AddClubGameEffectSetPlayer;
}
