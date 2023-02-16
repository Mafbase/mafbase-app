import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';

class GetClubsInteractor extends BaseInteractor {
  final ClubRepository _clubRepository;

  GetClubsInteractor(this._clubRepository);

  @override
  String get interactorName => "GetClubsInteractor";

  Future<List<ClubModel>> run({bool onlyMy = false}) => wrap(
        () => _clubRepository.getClubs(
          onlyMy: onlyMy,
        ),
      );
}
