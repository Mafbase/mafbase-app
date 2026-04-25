import 'package:seating_generator_web/domain/models/billing_result.dart';

abstract class PurchaseRepository {
  Future<BillingResult> billTranslation({
    required int tournamentId,
    required int playersCount,
    required bool billedTranslation,
    required String redirectPath,
  });

  Future<BillingResult> billClub({
    required int clubId,
    required int days,
    required String redirectPath,
  });
}
