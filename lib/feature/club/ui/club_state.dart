import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:seating_generator_web/shared/club/domain/models/club_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'club_state.freezed.dart';

@freezed
abstract class ClubState with _$ClubState {
  const factory ClubState({
    @Default(true) bool isLoading,
    ClubModel? model,
    @Default(false) isOwner,
    DateTime? hideDate,
    DateTimeRange? defaultRatingPeriod,
    @Default([]) List<GameStream> streams,
  }) = _ClubState;
}
