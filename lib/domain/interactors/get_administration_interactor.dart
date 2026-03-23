import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/user_model.dart';
import 'package:seating_generator_web/domain/repositories/owners_repository.dart';

class GetAdministrationInteractor extends BaseInteractor {
  final OwnersRepository _ownersRepository;

  GetAdministrationInteractor(this._ownersRepository);

  @override
  String get interactorName => 'GetAdministrationInteractor.run()';

  Future<List<UserModel>> run({required int tournamentId}) => wrap(
        () => _ownersRepository.getOwners(tournamentId: tournamentId),
      );
}
