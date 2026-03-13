import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/purchase_repository.dart';

class BillTournamentInteractor extends BaseInteractor {
  final PurchaseRepository _purchaseRepository;
  final BuildContext _context;

  BillTournamentInteractor(this._purchaseRepository, this._context);

  @override
  String get interactorName => 'BillTournamentInteractor';

  Future<String> call({
    required int tournamentId,
    required int playersCount,
    required bool billedTranslation,
  }) =>
      wrap(
        () => _purchaseRepository.billTranslation(
          tournamentId: tournamentId,
          playersCount: playersCount,
          billedTranslation: billedTranslation,
          redirectPath: GoRouter.of(_context).routeInformationProvider.value.uri.toString(),
        ),
      );
}
