import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';

class DeleteAccountRequest extends BaseRequest<void> {
  DeleteAccountRequest()
      : super(
          '/api/user/delete',
          forcePost: true,
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
