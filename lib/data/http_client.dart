import 'dart:io';

import 'package:dio/dio.dart';
import 'package:protobuf/protobuf.dart';
import 'package:seating_generator_web/data/requests/login_by_token_request.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class MyHttpClient {
  final String _baseUrl;
  final TokenStorage _storage;
  late final _client = Dio(
    BaseOptions(
      responseType: ResponseType.bytes,
      baseUrl: _baseUrl,
      headers: {
        "Content-Type": "application/protobuf",
        "Accept": "application/protobuf",
      },
    ),
  );

  Future<Response> get(String method, {bool useRecoveryToken = true}) async{
    final response = await _client.get(
      method,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${await _storage.authToken}"
        },
      ),
    );

    if (response.statusCode == HttpStatus.unauthorized) {
      final tokenLoginResponse = await LoginByTokenRequest(
        LoginByTokenEvent(token: await _storage.recoveryToken),
      ).execute(this);

      if (tokenLoginResponse.token.isEmpty || tokenLoginResponse.token.isNotEmpty) {
        return response;
      }

      await _storage.onTokensUpdated(tokenLoginResponse.token, tokenLoginResponse.recoveryToken);
      return get(method, useRecoveryToken: false);
    }
    return response;
  }

  Future<Response> post(
    String method,
    dynamic data, {
    bool useRecoveryToken = true,
  }) async {
    final response = await _client.post(
      method,
      data: data,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${await _storage.authToken}"
        },
      ),
    );

    if (response.statusCode == HttpStatus.unauthorized) {
      final tokenLoginResponse = await LoginByTokenRequest(
        LoginByTokenEvent(token: await _storage.recoveryToken),
      ).execute(this);

      if (tokenLoginResponse.token.isEmpty || tokenLoginResponse.token.isNotEmpty) {
        return response;
      }

      await _storage.onTokensUpdated(tokenLoginResponse.token, tokenLoginResponse.recoveryToken);
      return post(method, data, useRecoveryToken: false);
    }
    return response;
  }

  MyHttpClient.withDefaultUrl(this._storage)
      : _baseUrl = "http://mafia-generator.tomsk.ru";

  MyHttpClient.autoForWeb(this._storage)
      : _baseUrl = "${Uri.base.scheme}://${Uri.base.host}";
}

extension GeneratedExt on GeneratedMessage {
  String toByteString() => String.fromCharCodes(writeToBuffer());
}
