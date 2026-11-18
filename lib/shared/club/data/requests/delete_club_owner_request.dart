import 'package:seating_generator_web/core/network/base_request.dart';

class DeleteClubOwnerRequest extends BaseRequest<void> {
  DeleteClubOwnerRequest({
    required int clubId,
    required int ownerId,
  }) : super(
          '/api/clubs/$clubId/owners/$ownerId',
          methodType: Method.delete,
        );

  @override
  void parse(List<int> bytes) {}
}
