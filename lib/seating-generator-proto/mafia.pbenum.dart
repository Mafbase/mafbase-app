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

  static const $core.List<SignUpEventOut_Error> values = <SignUpEventOut_Error> [
    noError,
    emailExist,
    weakPassword,
  ];

  static final $core.Map<$core.int, SignUpEventOut_Error> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SignUpEventOut_Error? valueOf($core.int value) => _byValue[value];

  const SignUpEventOut_Error._($core.int v, $core.String n) : super(v, n);
}

