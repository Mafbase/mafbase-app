import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/club/domain/models/club_model.dart';
import 'package:seating_generator_web/shared/club/domain/club_repository.dart';

class GetClubsInteractor extends BaseInteractor {
  final ClubRepository _clubRepository;

  GetClubsInteractor(this._clubRepository);

  @override
  String get interactorName => 'GetClubsInteractor';

  Future<List<ClubModel>> run({bool onlyMy = false}) => wrap(
        () => _clubRepository.getClubs(
          onlyMy: onlyMy,
        ),
      );
}
