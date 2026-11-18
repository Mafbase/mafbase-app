import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/club/domain/models/club_model.dart';
import 'package:seating_generator_web/shared/club/domain/club_repository.dart';

class GetClubInteractor extends BaseInteractor {
  final ClubRepository _clubRepository;

  GetClubInteractor(this._clubRepository);

  @override
  String get interactorName => 'GetClubInteractor';

  Future<ClubModel> run({required int clubId}) {
    return wrap(() => _clubRepository.getClub(id: clubId));
  }
}
