import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetUserProfileRequest extends BaseRequest<UserProfile> {
  GetUserProfileRequest() : super('/api/profile');

  @override
  UserProfile parse(List<int> bytes) {
    return UserProfile.fromBuffer(bytes);
  }
}
