import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';

abstract interface class PaymentWaitingRepository {
  Future<WaitForPaymentStatus> waitForPayment({required int purchaseId});
}
