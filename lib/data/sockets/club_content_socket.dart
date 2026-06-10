import 'package:seating_generator_web/data/base_socket.dart';
import 'package:seating_generator_web/data/sockets/tournament_content_socket.dart';

class ClubContentSocket extends BaseSocket {
  ClubContentSocket({required int clubId, required int table})
      : super('${getScheme()}://${getHost()}/api/clubSeatingContent?table=$table&clubId=$clubId');
}
