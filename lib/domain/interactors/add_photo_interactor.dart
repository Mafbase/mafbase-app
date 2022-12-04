import 'dart:typed_data';

import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';

class AddPhotoInteractor extends BaseInteractor {
  final PlayersRepository _playersRepository;

  AddPhotoInteractor(this._playersRepository);

  Future run({
    required Uint8List bytes,
    required String filename,
    required int playerId,
  }) {
    return wrap(() {
      return _playersRepository.addPhoto(playerId, bytes, filename);
    });
  }

  @override
  String get interactorName => "AddPhotoInteractor";
}
