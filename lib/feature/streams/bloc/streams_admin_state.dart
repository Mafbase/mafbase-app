import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/game_stream_admin_model.dart';

part 'streams_admin_state.freezed.dart';

@freezed
abstract class StreamsAdminState with _$StreamsAdminState {
  const factory StreamsAdminState({
    @Default([]) List<GameStreamAdminModel> streams,
    @Default(true) bool isLoading,
  }) = _StreamsAdminState;
}
