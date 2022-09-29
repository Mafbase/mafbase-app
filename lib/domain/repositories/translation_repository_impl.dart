import 'package:seating_generator_web/data/requests/insert_seating_request.dart';
import 'package:seating_generator_web/domain/base_repository.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';

class TranslationRepositoryImpl extends BaseRepository
    implements TranslationRepository {
  TranslationRepositoryImpl(super.client);

  @override
  Future<bool> insertSeating(List<int> bytes, int tournamentId) {

    return InsertSeatingRequest(tournamentId, bytes).execute(client);
  }
}
