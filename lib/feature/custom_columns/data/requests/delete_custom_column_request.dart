import 'dart:async';
import 'package:seating_generator_web/data/base_request.dart';

class DeleteCustomColumnRequest extends BaseRequest<void> {
  DeleteCustomColumnRequest({
    required int clubId,
    required int columnId,
  }) : super(
          '/api/club/$clubId/custom-columns/$columnId',
          methodType: Method.delete,
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
