import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:protobuf/protobuf.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/data/requests/login_by_token_request.dart';
import 'package:seating_generator_web/data/requests/login_request.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class MyHttpClient {
  final String baseUrl;
  final TokenStorage _storage;
  final CredentialStorage _credentialStorage;

  late final _client = Dio(
    BaseOptions(
      responseType: ResponseType.bytes,
      baseUrl: baseUrl,
      validateStatus: (status) {
        return status != null && status <= 300 ||
            status == HttpStatus.unauthorized ||
            status == HttpStatus.forbidden ||
            status == HttpStatus.internalServerError;
      },
      headers: {
        "Content-Type": "application/protobuf",
        "Accept": "application/protobuf",
      },
    ),
  );

  Future<Response> get(String method, {bool useRecoveryToken = true}) async {
    if (useRecoveryToken) {
      debugPrint("sending request to $baseUrl$method");
    }
    final response = await _client.get(
      method,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${await _storage.authToken}"
        },
      ),
    );

    _checkResponse(response);

    if (response.statusCode == HttpStatus.unauthorized) {
      if (useRecoveryToken) {
        final credentials = await _credentialStorage.read();
        debugPrint("test25: $credentials");
        if (credentials != null) {
          final authResponse = await LoginRequest(
            LoginEvent(
              email: credentials.login,
              password: credentials.password,
            ),
          ).execute(this);

          if (authResponse.token.isEmpty) {
            return response;
          } else {
            await _storage.onTokensUpdated(
              authResponse.token,
              authResponse.recoveryToken,
            );
          }
        }
        return get(method, useRecoveryToken: false);
      } else {
        throw UnauthenticatedError("Authentication error");
      }
    }
    return response;
  }

  Future<Response> post(
    String method,
    dynamic data,
    int contentLength, {
    bool useRecoveryToken = true,
  }) async {
    if (useRecoveryToken) {
      debugPrint("sending request to $baseUrl$method");
    }
    final response = await _client.post(
      method,
      data: data,
      options: Options(
        headers: {
          HttpHeaders.contentLengthHeader: contentLength,
          HttpHeaders.authorizationHeader: "Bearer ${await _storage.authToken}"
        },
      ),
    );

    _checkResponse(response);

    if (response.statusCode == HttpStatus.unauthorized) {
      if (useRecoveryToken) {

        final credentials = await _credentialStorage.read();
        if (credentials != null) {
          final authResponse = await LoginRequest(
            LoginEvent(
              email: credentials.login,
              password: credentials.password,
            ),
          ).execute(this);

          if (authResponse.token.isEmpty) {
            return response;
          } else {
            await _storage.onTokensUpdated(
              authResponse.token,
              authResponse.recoveryToken,
            );
          }
        }

        return post(method, data, contentLength, useRecoveryToken: false);
      } else {
        throw UnauthenticatedError("Authentication error");
      }
    }
    return response;
  }

  Future<Response> putFile(
    String method,
    List<int> bytes, [
    String? fileName,
  ]) async {
    return _client
        .post(
      method,
      data: FormData.fromMap(
        {
          "file":
              MultipartFile.fromBytes(bytes, filename: fileName ?? "temp.csv")
        },
      ),
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "multipart/*",
          HttpHeaders.authorizationHeader: "Bearer ${await _storage.authToken}",
        },
      ),
    )
        .then(
      (value) {
        debugPrint(value.statusCode.toString());
        _checkResponse(value);
        return value;
      },
    );
  }

  void _checkResponse(Response response) {
    debugPrint("Status code: ${response.statusCode}");
    if (response.statusCode == HttpStatus.internalServerError) {
      throw RequestError(
        ErrorOut.fromBuffer(parseResponseData(response.data)).message,
      );
    }

    if (response.statusCode == HttpStatus.forbidden) {
      throw ForbiddenError(
        ErrorOut.fromBuffer(parseResponseData(response.data)).message,
      );
    }
  }

  MyHttpClient.withDefaultUrl(this._storage, this._credentialStorage)
      : baseUrl = "http://31.211.71.43";

  MyHttpClient.autoForWeb(this._storage, this._credentialStorage)
      : baseUrl = "${Uri.base.scheme}://${Uri.base.host}:${Uri.base.port}";
}

extension GeneratedExt on GeneratedMessage {
  String toByteString() {
    final bytes = Uint8List.fromList(writeToBuffer());

    return utf8.decode(bytes, allowMalformed: true);
  }
}

class RequestError extends Error {
  final String? message;

  RequestError([this.message]);

  @override
  String toString() {
    if (message == null) {
      return "RequestError";
    } else {
      return "RequestError: $message";
    }
  }
}

class UnauthenticatedError extends Error {
  final String? message;

  UnauthenticatedError([this.message]);

  @override
  String toString() {
    if (message == null) {
      return "UnauthenticatedError";
    } else {
      return "UnauthenticatedError: $message";
    }
  }
}

class ForbiddenError extends Error {
  final String? message;

  ForbiddenError([this.message]);

  @override
  String toString() {
    return "UnauthenticatedError${message == null ? "" : ": $message"}";
  }
}
