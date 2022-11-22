import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:protobuf/protobuf.dart';
import 'package:seating_generator_web/data/http_client.dart';

abstract class BaseRequest<R> {
  final String method;
  final GeneratedMessage? data;
  final bool resendOnUnauth;

  const BaseRequest(this.method, [this.data, this.resendOnUnauth = true]);

  Future<R> execute(MyHttpClient client) async {
    final Response response;
    if (data == null) {
      response = await client.get(method, useRecoveryToken: resendOnUnauth);
    } else {
      final bytes = data!.writeToBuffer();
      response = await client
          .post(
        method,
        Stream.fromIterable(bytes.map((e) => [e])),
        bytes.length,
        useRecoveryToken: resendOnUnauth,
      );
    }

    final result = parse(parseResponseData(response.data));

    debugPrint("Received: $result");
    return result;
  }

  R parse(List<int> bytes);
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

enum Method {
  post, get
}
