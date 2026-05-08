import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'streams_admin_state.freezed.dart';

@freezed
abstract class StreamsAdminState with _$StreamsAdminState {
  const factory StreamsAdminState({
    @Default([]) List<GameStreamAdmin> streams,
    @Default(true) bool isLoading,
  }) = _StreamsAdminState;
}
