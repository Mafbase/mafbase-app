import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class ResetPasswordRequest extends BaseRequest<ResetPasswordEventOut> {
  const ResetPasswordRequest(ResetPasswordEvent event)
      : super("/api/resetPassword", data: event);

  @override
  ResetPasswordEventOut parse(List<int> bytes) {
    return ResetPasswordEventOut.fromBuffer(bytes);
  }
}
