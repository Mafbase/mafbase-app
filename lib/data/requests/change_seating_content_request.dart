import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class ChangeSeatingContentRequest extends BaseRequest<void> {
  ChangeSeatingContentRequest({
    required int tournamentId,
    required int table,
    required String key,
    required ChangeSeatingContent content,
  }) : super(
          "/api/changeSeatingContent?table=$table&tournamentId=$tournamentId&key=$key",
          data: content,
        );

  @override
  void parse(List<int> bytes) {}
}
