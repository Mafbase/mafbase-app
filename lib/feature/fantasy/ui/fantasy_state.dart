import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/user_model.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_current_game_info_model.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_rating_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'fantasy_state.freezed.dart';

@freezed
class FantasyState with _$FantasyState {
  const factory FantasyState({
    @Default(true) bool isLoading,
    FantasyRatingModel? rating,
    FantasyCurrentGameInfoModel? currentGameInfo,
    @Default([]) List<UserModel> participants,
    GameWin? selectedPrediction,
    @Default(false) bool isOwner,
  }) = _FantasyState;
}
