import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/club/domain/club_repository.dart';

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
