import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/billing/domain/models/billing_result.dart';
import 'package:seating_generator_web/shared/billing/domain/purchase_repository.dart';

class BillClubInteractor extends BaseInteractor {
  final PurchaseRepository _purchaseRepository;

  BillClubInteractor(this._purchaseRepository);

  Future<BillingResult> call({
    required int clubId,
    required int days,
    required String redirectPath,
  }) {
    return wrap(
      () => _purchaseRepository.billClub(
        clubId: clubId,
        days: days,
        redirectPath: redirectPath,
      ),
    );
  }

  @override
  String get interactorName => 'BillClubInteractor';
}
