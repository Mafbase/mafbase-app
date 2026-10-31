import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/data/connection_retry_interceptor.dart';

/// Отдаёт результаты по порядку вызовов, последний повторяется. Функция строит результат из опций запроса,
/// всё, кроме [ResponseBody], бросается.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this._results);

  final List<Object> _results;
  int calls = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final result = _results[calls < _results.length ? calls : _results.length - 1];
    calls++;
    final value = result is Object Function(RequestOptions) ? result(options) : result;
    if (value is ResponseBody) return value;
    throw value;
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _ok() => ResponseBody.fromString('ok', 200);

Dio _dio(_FakeAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.com', responseType: ResponseType.plain))
    ..httpClientAdapter = adapter;
  return dio..interceptors.add(ConnectionRetryInterceptor(dio.fetch, retryDelays: [Duration.zero, Duration.zero]));
}

void main() {
  test('GET повторяется после SocketException и возвращает ответ', () async {
    final adapter = _FakeAdapter([const SocketException('Connection reset by peer'), _ok()]);

    final response = await _dio(adapter).get<String>('/rating');

    expect(response.statusCode, 200);
    expect(response.data, 'ok');
    expect(adapter.calls, 2);
  });

  test('GET повторяется после HttpException и DioExceptionType.connectionError', () async {
    final adapter = _FakeAdapter([
      const HttpException('Connection closed before full header was received'),
      (RequestOptions options) =>
          DioException.connectionError(requestOptions: options, reason: 'Software caused connection abort'),
      _ok(),
    ]);

    final response = await _dio(adapter).get<String>('/rating');

    expect(response.statusCode, 200);
    expect(adapter.calls, 3);
  });

  test('GET после двух неудачных повторов пробрасывает DioException', () async {
    final adapter = _FakeAdapter([const SocketException('Connection reset by peer')]);

    await expectLater(
      _dio(adapter).get<String>('/rating'),
      throwsA(isA<DioException>().having((e) => e.error, 'error', isA<SocketException>())),
    );
    expect(adapter.calls, 3);
  });

  test('POST не повторяется', () async {
    final adapter = _FakeAdapter([const SocketException('Connection reset by peer'), _ok()]);

    await expectLater(_dio(adapter).post<String>('/rating', data: 'body'), throwsA(isA<DioException>()));
    expect(adapter.calls, 1);
  });

  test('GET с ответом 500 не повторяется', () async {
    final adapter = _FakeAdapter([ResponseBody.fromString('error', 500), _ok()]);

    await expectLater(
      _dio(adapter).get<String>('/rating'),
      throwsA(isA<DioException>().having((e) => e.type, 'type', DioExceptionType.badResponse)),
    );
    expect(adapter.calls, 1);
  });

  test('GET с ошибкой не сетевого типа не повторяется', () async {
    final adapter = _FakeAdapter([const FormatException('broken'), _ok()]);

    await expectLater(
      _dio(adapter).get<String>('/rating'),
      throwsA(isA<DioException>().having((e) => e.error, 'error', isA<FormatException>())),
    );
    expect(adapter.calls, 1);
  });
}
