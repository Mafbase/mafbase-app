import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/club/domain/club_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class AddClubGameInteractor extends BaseInteractor {
  final ClubRepository _repository;

  AddClubGameInteractor(this._repository);

  @override
  String get interactorName => 'AddClubGameInteractor';

  Future<int> run({required int clubId, required ClubGameResult result}) {
    return wrap(() {
      return _repository.addGame(result, clubId);
    });
  }
}
