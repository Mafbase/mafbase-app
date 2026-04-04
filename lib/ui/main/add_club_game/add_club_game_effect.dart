import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/ci_scheme_model.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'add_club_game_effect.freezed.dart';

@freezed
abstract class AddClubGameEffect with _$AddClubGameEffect {
  const factory AddClubGameEffect.setValues({
    List<PlayerModel>? players,
    List<double>? addScore,
    List<double>? minusScore,
    List<PlayerRole>? roles,
    GameWin? win,
    BestMove? bestMove,
    String? referee,
    PlayerModel? refereePlayer,
    int? died,
    DateTime? date,
    CiSchemeModel? ciModel,
    RatingScheme? ratingsSchema,
  }) = AddClubGameEffectSetValues;

  const factory AddClubGameEffect.setPlayer({
    required int index,
    required PlayerModel player,
  }) = AddClubGameEffectSetPlayer;
}
