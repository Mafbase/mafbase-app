import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract class BaseInteractor {
  abstract final String interactorName;

  @protected
  Future<T> wrap<T>(Future<T> Function() method) async {
    ISentrySpan? transaction;
    if (!kDebugMode) {
      transaction = Sentry.startTransaction(
        '$interactorName.run()',
        'task',
        startTimestamp: DateTime.now(),
      )..status = const SpanStatus.ok();
    }
    try {
      return await method.call();
    } catch (err) {
      transaction?.status = const SpanStatus.internalError();
      transaction?.throwable = err;
      rethrow;
    } finally {
      transaction?.finish(endTimestamp: DateTime.now());
    }
  }
}
