import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';

class CreateClubInteractor extends BaseInteractor {
  final ClubRepository _clubRepository;

  CreateClubInteractor(this._clubRepository);

  @override
  String get interactorName => 'CreateClubInteractor';

  Future<ClubModel> run({
    required String name,
    String? description,
    String? groupLink,
  }) {
    return wrap(
      () => _clubRepository.createClub(
        name: name,
        description: description,
        groupLink: groupLink,
      ),
    );
  }
}
