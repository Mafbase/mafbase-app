import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'tournament_model.freezed.dart';

@freezed
class TournamentModel with _$TournamentModel {
  const factory TournamentModel({
    required int id,
    required String name,
    required TournamentStatus status,
    required DateTime dateStart,
    required DateTime dateEnd,
    required int gamesCount,
    required int billedPlayers,
    required bool billedTranslation,
    required bool notificationEnabled,
    @Default('') String gomafiaUrl,
    int? photoThemeId,
  }) = _TournamentModel;
}

enum TournamentStatus {
  active,
  waitForBilling,
  ended;

  static TournamentStatus from(Tournament_Status status) {
    switch (status) {
      case Tournament_Status.active:
        return TournamentStatus.active;
      case Tournament_Status.ended:
        return TournamentStatus.ended;
      case Tournament_Status.waitForBilling:
        return TournamentStatus.waitForBilling;
    }
    throw FormatException("can't parse $status to TournamentStatus");
  }
}
