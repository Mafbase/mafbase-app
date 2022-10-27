import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_events.freezed.dart';

@freezed
class VerificationEvents with _$VerificationEvents {
  const factory VerificationEvents.submit({required String token}) = VerificationEventSubmit;
}