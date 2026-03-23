import 'package:seating_generator_web/data/base_request.dart';

class ClubCheckRequest extends BaseRequest<void> {
  ClubCheckRequest({required int clubId}) : super('/api/club/$clubId/check');

  @override
  void parse(List<int> bytes) {}
}
