///
//  Generated code. Do not modify.
//  source: seating-generator-proto/mafia.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class SignUpEventOut_Error extends $pb.ProtobufEnum {
  static const SignUpEventOut_Error noError = SignUpEventOut_Error._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'noError');
  static const SignUpEventOut_Error emailExist = SignUpEventOut_Error._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'emailExist');
  static const SignUpEventOut_Error weakPassword = SignUpEventOut_Error._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'weakPassword');
  static const SignUpEventOut_Error needVerification = SignUpEventOut_Error._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'needVerification');

  static const $core.List<SignUpEventOut_Error> values = <SignUpEventOut_Error> [
    noError,
    emailExist,
    weakPassword,
    needVerification,
  ];

  static final $core.Map<$core.int, SignUpEventOut_Error> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SignUpEventOut_Error? valueOf($core.int value) => _byValue[value];

  const SignUpEventOut_Error._($core.int v, $core.String n) : super(v, n);
}

class EmailVerificationEventOut_Status extends $pb.ProtobufEnum {
  static const EmailVerificationEventOut_Status success = EmailVerificationEventOut_Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'success');
  static const EmailVerificationEventOut_Status incorrectToken = EmailVerificationEventOut_Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'incorrectToken');

  static const $core.List<EmailVerificationEventOut_Status> values = <EmailVerificationEventOut_Status> [
    success,
    incorrectToken,
  ];

  static final $core.Map<$core.int, EmailVerificationEventOut_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static EmailVerificationEventOut_Status? valueOf($core.int value) => _byValue[value];

  const EmailVerificationEventOut_Status._($core.int v, $core.String n) : super(v, n);
}

class GetTournamentsEventOut_Tournament_Status extends $pb.ProtobufEnum {
  static const GetTournamentsEventOut_Tournament_Status waitForBilling = GetTournamentsEventOut_Tournament_Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'waitForBilling');
  static const GetTournamentsEventOut_Tournament_Status active = GetTournamentsEventOut_Tournament_Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'active');
  static const GetTournamentsEventOut_Tournament_Status ended = GetTournamentsEventOut_Tournament_Status._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ended');

  static const $core.List<GetTournamentsEventOut_Tournament_Status> values = <GetTournamentsEventOut_Tournament_Status> [
    waitForBilling,
    active,
    ended,
  ];

  static final $core.Map<$core.int, GetTournamentsEventOut_Tournament_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetTournamentsEventOut_Tournament_Status? valueOf($core.int value) => _byValue[value];

  const GetTournamentsEventOut_Tournament_Status._($core.int v, $core.String n) : super(v, n);
}

