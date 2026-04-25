import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_waiting_state.freezed.dart';

@freezed
abstract class PaymentWaitingState with _$PaymentWaitingState {
  const factory PaymentWaitingState({
    @Default(false) bool isLoading,
  }) = _PaymentWaitingState;
}
