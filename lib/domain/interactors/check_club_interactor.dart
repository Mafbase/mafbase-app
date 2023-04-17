import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';

class CheckClubInteractor extends BaseInteractor {
  final ClubRepository _clubRepository;

  CheckClubInteractor(this._clubRepository);

  Future<bool> call(int clubId) {
    return wrap(() {
      return _clubRepository.isOwner(clubId);
    });
  }

  @override
  String get interactorName => 'CheckClubInteractor';
}