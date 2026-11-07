import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/notification_coverage_model.dart';

part 'notification_coverage_state.freezed.dart';

/// [coverage] остаётся null, если загрузка не удалась.
@freezed
abstract class NotificationCoverageState with _$NotificationCoverageState {
  const factory NotificationCoverageState({
    NotificationCoverageModel? coverage,
    @Default(true) bool isLoading,
  }) = _NotificationCoverageState;
}
