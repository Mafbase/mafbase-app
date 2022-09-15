import 'dart:typed_data';

import 'package:protobuf/protobuf.dart';
import 'package:seating_generator_web/data/http_client.dart';

abstract class BaseRequest<E extends GeneratedMessage,
    R extends GeneratedMessage> {
  final String method;
  final E data;

  const BaseRequest(this.method, this.data);

  Future<R> execute(MyHttpClient client) {
    return client
        .post(
      method,
      data.toByteString(),
    )
        .then((value) {
      return parse(_parseData(value.data));
    });
  }

  R parse(List<int> bytes);

  List<int> _parseData(dynamic data) {
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
}
