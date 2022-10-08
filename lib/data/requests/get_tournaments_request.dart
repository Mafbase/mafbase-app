import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetTournamentsRequest extends BaseRequest<GetTournamentsEventOut> {
  GetTournamentsRequest(): super("/api/tournaments");

  @override
  GetTournamentsEventOut parse(List<int> bytes) {

    return GetTournamentsEventOut.fromBuffer(bytes);
  }
}