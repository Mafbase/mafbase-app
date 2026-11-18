import 'package:seating_generator_web/core/network/http_client.dart';

abstract class BaseRepository {
  final MyHttpClient client;

  BaseRepository(this.client);
}
