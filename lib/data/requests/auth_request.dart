import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class AuthRequest extends BaseRequest<AuthEventOut> {
  const AuthRequest(AuthEvent event) : super(
    "/api/auth",
    data: event,
    forcePost: true,
    resendOnUnauth: false,
  );

  @override
  AuthEventOut parse(List<int> bytes) {
    return AuthEventOut.fromBuffer(bytes);
  }
}
