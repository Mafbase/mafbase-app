import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class VerificationRequest extends BaseRequest<EmailVerificationEventOut> {
  VerificationRequest(EmailVerificationEvent event) : super('/api/emailVerification', event);

  @override
  EmailVerificationEventOut parse(List<int> bytes) {
    return EmailVerificationEventOut.fromBuffer(bytes);
  }

}