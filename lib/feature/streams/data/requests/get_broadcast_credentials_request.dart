import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

/// Публичный запрос креденшелов оператора для нативной трансляции.
///
/// Эндпоинт `GET /api/broadcast/credentials` НЕ требует авторизации: доступ
/// определяется одноразовым `key` из диплинка. Поэтому, в отличие от остальных
/// запросов проекта, здесь подавляется авто-recovery токена
/// (`resendOnUnauth: false`) — мы НЕ хотим, чтобы 401/403 уходили в попытку
/// перелогина по сохранённым кредам. Любой не-2xx статус должен пробрасываться
/// наверх как ошибка, чтобы резолвер мог показать корректный экран (403 —
/// ссылка устарела, 404 — стол не настроен).
///
/// Передаётся ровно один из `tournamentId`/`clubId` (заполненный > 0) — второй
/// не уходит в query, чтобы бэкенд однозначно понял контекст.
class GetBroadcastCredentialsRequest extends BaseRequest<BroadcastCredentialsOut> {
  GetBroadcastCredentialsRequest({
    int? tournamentId,
    int? clubId,
    required int table,
    required String key,
  }) : super(_buildPath(tournamentId: tournamentId, clubId: clubId, table: table, key: key), resendOnUnauth: false);

  static String _buildPath({
    required int? tournamentId,
    required int? clubId,
    required int table,
    required String key,
  }) {
    final query = <String, String>{
      if (tournamentId != null && tournamentId > 0) 'tournamentId': '$tournamentId',
      if (clubId != null && clubId > 0) 'clubId': '$clubId',
      'table': '$table',
      'key': key,
    };
    final queryString = query.entries.map((e) => '${e.key}=${Uri.encodeQueryComponent(e.value)}').join('&');
    return '/api/broadcast/credentials?$queryString';
  }

  @override
  Future<BroadcastCredentialsOut> execute(MyHttpClient client) async {
    // Публичный GET без recovery-токена: статус-коды 403/404 приходят как обычный
    // ответ (validateStatus пропускает <= 500), поэтому мы можем разнести их в
    // типизированное исключение вместо общего RequestError.
    final response = await client.getPublic(method);
    final status = response.statusCode ?? 0;
    if (status < 200 || status >= 300) {
      throw BroadcastCredentialsException(
        statusCode: status,
        message: _safeErrorMessage(response.data),
      );
    }

    final bytes = parseResponseData(response.data);
    return parse(bytes);
  }

  static String? _safeErrorMessage(dynamic data) {
    try {
      return ErrorOut.fromBuffer(parseResponseData(data)).message;
    } catch (_) {
      return null;
    }
  }

  @override
  FutureOr<BroadcastCredentialsOut> parse(List<int> bytes) => compute(BroadcastCredentialsOut.fromBuffer, bytes);
}

/// Исключение с HTTP-статусом для публичного запроса креденшелов трансляции.
///
/// Резолвер диплинка использует [statusCode], чтобы разнести сценарии:
/// `403` — ссылка устарела/ключ невалиден, `404` — стол без RTMP-настроек.
class BroadcastCredentialsException implements Exception {
  final int statusCode;
  final String? message;

  const BroadcastCredentialsException({required this.statusCode, this.message});

  bool get isLinkExpired => statusCode == HttpStatus.forbidden;

  bool get isTableNotConfigured => statusCode == HttpStatus.notFound;

  @override
  String toString() => 'BroadcastCredentialsException(statusCode: $statusCode, message: $message)';
}
