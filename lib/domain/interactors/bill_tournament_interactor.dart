import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/billing_result.dart';
import 'package:seating_generator_web/domain/repositories/purchase_repository.dart';

class BillTournamentInteractor extends BaseInteractor {
  final PurchaseRepository _purchaseRepository;

  BillTournamentInteractor(this._purchaseRepository);

  @override
  String get interactorName => 'BillTournamentInteractor';

  Future<BillingResult> call({
    required int tournamentId,
    required int playersCount,
    required bool billedTranslation,
    required String nextPath,
  }) =>
      wrap(
        () => _purchaseRepository.billTranslation(
          tournamentId: tournamentId,
          playersCount: playersCount,
          billedTranslation: billedTranslation,
          redirectPath: '/payment-waiting?nextPath=${Uri.encodeQueryComponent(nextPath)}',
        ),
      );
}
