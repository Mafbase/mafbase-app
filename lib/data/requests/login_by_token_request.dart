import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class LoginByTokenRequest
    extends BaseRequest<LoginByTokenEventOut> {
  const LoginByTokenRequest(LoginByTokenEvent event)
      : super("/api/loginByToken", event, false);

  @override
  LoginByTokenEventOut parse(List<int> bytes) {
    return LoginByTokenEventOut.fromBuffer(bytes);
  }
}
