import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/owners_repository.dart';

class DeleteOwnerInteractor extends BaseInteractor {
  final OwnersRepository _ownersRepository;

  DeleteOwnerInteractor(this._ownersRepository);

  @override
  String get interactorName => 'DeleteOwnerInteractor';

  Future run({
    required int tournamentId,
    required int ownerId,
  }) {
    return wrap(
      () => _ownersRepository.deleteOwner(tournamentId: tournamentId, ownerId: ownerId),
    );
  }
}
