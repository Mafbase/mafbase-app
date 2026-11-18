import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/feature/tournament/domain/info_repository.dart';

class CustomTextInfoInteractor extends BaseInteractor {
  final InfoRepository _repository;

  CustomTextInfoInteractor(this._repository);

  @override
  String get interactorName => 'CustomTextInfoInteractor.run()';

  Future call({required int tournamentId, required String text}) => wrap(
        () => _repository.customTextInfo(
          tournamentId: tournamentId,
          text: text,
        ),
      );
}
