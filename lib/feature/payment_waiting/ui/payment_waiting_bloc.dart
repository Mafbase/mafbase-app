import 'package:dio/dio.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/payment_waiting/domain/repository/payment_waiting_repository.dart';
import 'package:seating_generator_web/feature/payment_waiting/ui/payment_waiting_effect.dart';
import 'package:seating_generator_web/feature/payment_waiting/ui/payment_waiting_event.dart';
import 'package:seating_generator_web/feature/payment_waiting/ui/payment_waiting_state.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';

class PaymentWaitingBloc extends Bloc<PaymentWaitingEvent, PaymentWaitingState>
    with EffectEmitter<PaymentWaitingEffect, PaymentWaitingState> {
  final PaymentWaitingRepository _repository;

  PaymentWaitingBloc(this._repository) : super(const PaymentWaitingState()) {
    on<PaymentWaitingEventStart>(_onStart);
  }

  Future<void> _onStart(PaymentWaitingEventStart event, Emitter<PaymentWaitingState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      while (!isClosed) {
        try {
          final status = await _repository.waitForPayment(purchaseId: event.purchaseId);

          if (status == WaitForPaymentStatus.succeeded) {
            emitEffect(const PaymentWaitingEffect.navigateNext());
            return;
          } else if (status == WaitForPaymentStatus.canceled) {
            emitEffect(const PaymentWaitingEffect.paymentCanceled());
            return;
          }
          // pending — poll again
        } on DioException {
          // Network error — wait before retrying to avoid spamming when offline
          await Future.delayed(const Duration(seconds: 5));
        }
        // RequestError (HTTP >= 400) propagates out and is handled by AppBlocObserver
      }
    } finally {
      if (!isClosed) {
        emit(state.copyWith(isLoading: false));
      }
    }
  }
}
