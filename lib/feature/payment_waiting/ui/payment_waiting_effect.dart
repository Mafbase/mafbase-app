import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_waiting_effect.freezed.dart';

@freezed
sealed class PaymentWaitingEffect with _$PaymentWaitingEffect {
  const factory PaymentWaitingEffect.navigateNext() = PaymentWaitingEffectNavigateNext;

  const factory PaymentWaitingEffect.paymentCanceled() = PaymentWaitingEffectPaymentCanceled;
}
