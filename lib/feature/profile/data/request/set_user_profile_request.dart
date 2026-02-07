import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SetUserProfileRequest extends BaseRequest<void> {
  SetUserProfileRequest({required Player player})
      : super(
          '/api/profile',
          data: UserProfile(player: player),
        );

  @override
  void parse(List<int> bytes) {}
}
