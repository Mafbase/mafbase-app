import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_model.freezed.dart';

@freezed
class TournamentModel with _$TournamentModel {
  const factory TournamentModel({
    required int id,
    required String name,
    required int participantsCount,
    required TournamentStatus status,
  }) = _TournamentModel;
}

enum TournamentStatus {
  active,
  waitForBilling,
  ended,
}
