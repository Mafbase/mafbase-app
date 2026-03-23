import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';

class DeleteUserRequest extends BaseRequest<void> {
  DeleteUserRequest()
      : super(
          '/api/user',
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
