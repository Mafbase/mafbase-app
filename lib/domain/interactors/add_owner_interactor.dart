import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/owners_repository.dart';

class AddOwnerInteractor extends BaseInteractor {
  final OwnersRepository _ownersRepository;

  AddOwnerInteractor(this._ownersRepository);

  @override
  String get interactorName => 'GetAdministrationInteractor.run()';

  Future<void> run({required int tournamentId, required String email}) => wrap(
        () => _ownersRepository.addOwner(tournamentId: tournamentId, email: email),
      );
}
