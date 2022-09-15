import 'package:seating_generator_web/data/http_client.dart';

abstract class BaseRepository {
  final MyHttpClient client;

  BaseRepository(this.client);
}