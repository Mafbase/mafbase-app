import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SignUpRequest extends BaseRequest<SignUpEventOut> {
  const SignUpRequest(SignUpEvent event) : super("/api/signUp", event);

  @override
  SignUpEventOut parse(List<int> bytes) {
    return SignUpEventOut.fromBuffer(bytes);
  }
}
