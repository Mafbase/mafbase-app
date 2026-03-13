import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/data/http_client.dart';

class InsertSeatingRequest extends BaseRequest<bool> {
  final List<int> _bytes;
  InsertSeatingRequest(int tournamentId, this._bytes) : super('/api/insertSeating/$tournamentId');

  @override
  bool parse(List<int> bytes) {
    return true;
  }

  @override
  Future<bool> execute(MyHttpClient client) async {
    await client.putFile(method, _bytes);
    return true;
  }
}
