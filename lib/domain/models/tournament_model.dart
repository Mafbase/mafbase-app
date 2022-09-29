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
  }) = _TournamentModel;
}

enum TournamentStatus {
  active,
  waitForBilling,
  ended;

  static TournamentStatus from(GetTournamentsEventOut_Tournament_Status status) {
    switch (status) {
      case GetTournamentsEventOut_Tournament_Status.active:
        return TournamentStatus.active;
      case GetTournamentsEventOut_Tournament_Status.ended:
        return TournamentStatus.ended;
      case GetTournamentsEventOut_Tournament_Status.waitForBilling:
        return TournamentStatus.waitForBilling;
    }
    throw FormatException("can't parse $status to TournamentStatus");
  }
}
