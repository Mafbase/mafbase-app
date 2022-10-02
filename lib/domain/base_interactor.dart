import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract class BaseInteractor {
  @protected
  Future<T> wrap<T>(Future<T> Function() method) async {
    final transaction = Sentry.startTransaction('$runtimeType.run()', 'task')
      ..status = const SpanStatus.ok();
    try {
      return await method.call();
    } catch (err) {
      transaction.status = const SpanStatus.internalError();
      transaction.throwable = err;
      rethrow;
    } finally {
      transaction.finish();
    }
  }
}
