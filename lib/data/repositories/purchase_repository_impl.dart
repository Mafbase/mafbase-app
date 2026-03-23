import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/data/requests/bill_club_request.dart';
import 'package:seating_generator_web/data/requests/bill_tournament_request.dart';
import 'package:seating_generator_web/domain/repositories/purchase_repository.dart';

class PurchaseRepositoryImpl extends BaseRepository implements PurchaseRepository {
  PurchaseRepositoryImpl(super.client);

  @override
  Future<String> billTranslation({
    required int tournamentId,
    required int playersCount,
    required bool billedTranslation,
    required String redirectPath,
  }) {
    return BillTournamentRequest(
      tournamentId: tournamentId,
      billedCount: playersCount,
      billedTranslation: billedTranslation,
      redirectPath: redirectPath,
    ).execute(client).then((value) => value.redirectLink);
  }

  @override
  Future<String> billClub({
    required int clubId,
    required int days,
    required String redirectPath,
  }) {
    return BillClubRequest(
      clubId: clubId,
      days: days,
      redirectPath: redirectPath,
    ).execute(client).then((value) => value.redirectLink);
  }
}
