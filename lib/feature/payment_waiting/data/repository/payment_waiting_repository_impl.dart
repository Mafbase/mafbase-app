import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/feature/payment_waiting/data/request/wait_for_payment_request.dart';
import 'package:seating_generator_web/feature/payment_waiting/domain/repository/payment_waiting_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';

class PaymentWaitingRepositoryImpl extends BaseRepository implements PaymentWaitingRepository {
  PaymentWaitingRepositoryImpl(super.client);

  @override
  Future<WaitForPaymentStatus> waitForPayment({required int purchaseId}) async {
    final response = await WaitForPaymentRequest(purchaseId: purchaseId).execute(client);
    return response.status;
  }
}
