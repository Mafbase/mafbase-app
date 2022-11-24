import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class LoginRequest extends BaseRequest<LoginEventOut> {
  const LoginRequest(LoginEvent event) : super("/api/login", data: event);

  @override
  LoginEventOut parse(List<int> bytes) {
    return LoginEventOut.fromBuffer(bytes);
  }
}
