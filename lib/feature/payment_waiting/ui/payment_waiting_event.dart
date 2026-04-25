import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_waiting_event.freezed.dart';

@freezed
abstract class PaymentWaitingEvent with _$PaymentWaitingEvent {
  const factory PaymentWaitingEvent.start({
    required int purchaseId,
    required String nextPath,
  }) = PaymentWaitingEventStart;
}
