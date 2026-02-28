import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:protobuf/protobuf.dart';
import 'package:seating_generator_web/data/http_client.dart';

abstract class BaseRequest<R> {
  final String method;
  final GeneratedMessage? data;
  final Method? methodType;
  final bool resendOnUnauth;
  final bool useJson;
  final bool forcePost;

  const BaseRequest(
    this.method, {
    this.data,
    this.resendOnUnauth = true,
    this.useJson = false,
    this.forcePost = false,
    this.methodType,
  });

  Future<R> execute(MyHttpClient client) async {
    final Response response;
    log(
      '[base_request] Executing $method${data == null ? '' : '\nData: $data'}',
      level: Level.INFO.value,
    );

    if (methodType == Method.delete) {
      final bytes = data?.writeToBuffer() ?? [];
      response = await client.delete(
        method,
        Stream.fromIterable(bytes.map<List<int>>((e) => [e])),
        bytes.length,
        useRecoveryToken: resendOnUnauth,
      );
    } else if (methodType == Method.put) {
      final bytes = data?.writeToBuffer() ?? [];
      response = await client.put(
        method,
        Stream.fromIterable(bytes.map<List<int>>((e) => [e])),
        bytes.length,
        useRecoveryToken: resendOnUnauth,
      );
    } else {
      if (data == null && !forcePost) {
        response = await client.get(method, useRecoveryToken: resendOnUnauth);
      } else {
        final bytes = data?.writeToBuffer() ?? [];
        response = await client.post(
          method,
          Stream.fromIterable(bytes.map<List<int>>((e) => [e])),
          bytes.length,
          useRecoveryToken: resendOnUnauth,
        );
      }
    }

    final bytes = parseResponseData(response.data);
    final result = await parse(bytes);

    return result;
  }

  FutureOr<R> parse(List<int> bytes);
}

List<int> parseResponseData(dynamic data) {
  final List<int> list;
  if (data is String) {
    list = Uint16List.fromList(data.codeUnits);
  } else if (data is List<int>) {
    list = data;
  } else {
    throw FormatException("unsupported type: ${data.runtimeType}");
  }
  return list;
}

enum Method { post, get, delete, put }
