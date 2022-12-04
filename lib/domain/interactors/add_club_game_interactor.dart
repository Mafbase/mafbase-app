import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class AddClubGameInteractor extends BaseInteractor {
  final ClubRepository _repository = getIt();

  @override
  String get interactorName => "AddClubGameInteractor";

  Future<int> run({required int clubId, required ClubGameResult result}) {
    return wrap(() {
      return _repository.addGame(result, clubId);
    });
  }
}
