import 'package:seating_generator_web/core/network/base_request.dart';

class DeleteOwnerRequest extends BaseRequest<void> {
  DeleteOwnerRequest({
    required int tournamentId,
    required int ownerId,
  }) : super(
          '/api/tournaments/$tournamentId/owners/$ownerId',
          methodType: Method.delete,
        );

  @override
  void parse(List<int> bytes) {}
}
