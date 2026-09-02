import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'club_streams_admin_state.freezed.dart';

@freezed
abstract class ClubStreamsAdminState with _$ClubStreamsAdminState {
  const factory ClubStreamsAdminState({
    @Default([]) List<GameStreamAdmin> streams,
    @Default(true) bool isLoading,
  }) = _ClubStreamsAdminState;
}
