import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/billing_result.dart';
import 'package:seating_generator_web/domain/repositories/purchase_repository.dart';

class BillTournamentInteractor extends BaseInteractor {
  final PurchaseRepository _purchaseRepository;
  final BuildContext _context;

  BillTournamentInteractor(this._purchaseRepository, this._context);

  @override
  String get interactorName => 'BillTournamentInteractor';

  Future<BillingResult> call({
    required int tournamentId,
    required int playersCount,
    required bool billedTranslation,
  }) =>
      wrap(
        () => _purchaseRepository.billTranslation(
          tournamentId: tournamentId,
          playersCount: playersCount,
          billedTranslation: billedTranslation,
          redirectPath: _context.router.currentUrl,
        ),
      );
}
