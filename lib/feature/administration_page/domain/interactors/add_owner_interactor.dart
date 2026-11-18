import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/club/domain/owners_repository.dart';

class AddOwnerInteractor extends BaseInteractor {
  final OwnersRepository _ownersRepository;

  AddOwnerInteractor(this._ownersRepository);

  @override
  String get interactorName => 'GetAdministrationInteractor.run()';

  Future<void> run({required int tournamentId, required String email}) => wrap(
        () => _ownersRepository.addOwner(tournamentId: tournamentId, email: email),
      );
}
