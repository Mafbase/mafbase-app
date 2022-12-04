import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';

class GetClubInteractor extends BaseInteractor {
  final ClubRepository _clubRepository;

  GetClubInteractor(this._clubRepository);

  @override
  String get interactorName => "GetClubInteractor";

  Future<ClubModel> run({required int clubId}) {
    return wrap(() => _clubRepository.getClub(id: clubId));
  }
}