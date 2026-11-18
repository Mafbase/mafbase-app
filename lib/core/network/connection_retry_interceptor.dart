import 'dart:io';

import 'package:dio/dio.dart';

/// Повторяет GET при обрыве соединения: после долгого фона iOS ОС или сервер закрывают keep-alive сокеты,
/// а пул `HttpClient` об этом не знает и отдаёт мёртвое соединение первому запросу.
class ConnectionRetryInterceptor extends Interceptor {
  ConnectionRetryInterceptor(
    this._fetch, {
    List<Duration> retryDelays = const [Duration(seconds: 1), Duration(seconds: 2)],
  }) : _retryDelays = retryDelays;

  static const _attemptKey = 'connectionRetryAttempt';

  final Future<Response<dynamic>> Function(RequestOptions options) _fetch;
  final List<Duration> _retryDelays;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    final attempt = options.extra[_attemptKey] as int? ?? 0;

    if (options.method.toUpperCase() != 'GET' || attempt >= _retryDelays.length || !_isConnectionDrop(err)) {
      handler.next(err);
      return;
    }

    await Future<void>.delayed(_retryDelays[attempt]);
    options.extra[_attemptKey] = attempt + 1;

    try {
      handler.resolve(await _fetch(options));
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  static bool _isConnectionDrop(DioException err) => switch (err.type) {
        DioExceptionType.connectionError => true,
        DioExceptionType.unknown => err.error is SocketException || err.error is HttpException,
        _ => false,
      };
}
