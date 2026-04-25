import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/data/requests/bill_club_request.dart';
import 'package:seating_generator_web/data/requests/bill_tournament_request.dart';
import 'package:seating_generator_web/domain/models/billing_result.dart';
import 'package:seating_generator_web/domain/repositories/purchase_repository.dart';

class PurchaseRepositoryImpl extends BaseRepository implements PurchaseRepository {
  PurchaseRepositoryImpl(super.client);

  @override
  Future<BillingResult> billTranslation({
    required int tournamentId,
    required int playersCount,
    required bool billedTranslation,
    required String redirectPath,
  }) async {
    final response = await BillTournamentRequest(
      tournamentId: tournamentId,
      billedCount: playersCount,
      billedTranslation: billedTranslation,
      redirectPath: redirectPath,
    ).execute(client);
    return BillingResult(redirectLink: response.redirectLink, purchaseId: response.purchaseId);
  }

  @override
  Future<BillingResult> billClub({
    required int clubId,
    required int days,
    required String redirectPath,
  }) async {
    final response = await BillClubRequest(
      clubId: clubId,
      days: days,
      redirectPath: redirectPath,
    ).execute(client);
    return BillingResult(redirectLink: response.redirectLink, purchaseId: response.purchaseId);
  }
}
