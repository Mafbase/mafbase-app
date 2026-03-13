import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class ForgotPasswordRequest extends BaseRequest<ForgotPasswordEventOut> {
  const ForgotPasswordRequest(ForgotPasswordEvent event) : super('/api/forgotPassword', data: event);

  @override
  ForgotPasswordEventOut parse(List<int> bytes) {
    return ForgotPasswordEventOut.fromBuffer(bytes);
  }
}
