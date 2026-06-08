import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class ChangeClubSeatingContentRequest extends BaseRequest<void> {
  ChangeClubSeatingContentRequest({
    required int clubId,
    required int table,
    required String key,
    required ChangeClubSeatingContent content,
  }) : super('/api/changeClubSeatingContent?clubId=$clubId&table=$table&key=$key', data: content);

  @override
  void parse(List<int> bytes) {}
}
