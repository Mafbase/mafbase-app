///
//  Generated code. Do not modify.
//  source: seating-generator-proto/mafia.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class BestMove extends $pb.ProtobufEnum {
  static const BestMove miss = BestMove._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'miss');
  static const BestMove half = BestMove._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'half');
  static const BestMove full = BestMove._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'full');

  static const $core.List<BestMove> values = <BestMove> [
    miss,
    half,
    full,
  ];

  static final $core.Map<$core.int, BestMove> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BestMove? valueOf($core.int value) => _byValue[value];

  const BestMove._($core.int v, $core.String n) : super(v, n);
}

class GameWin extends $pb.ProtobufEnum {
  static const GameWin city = GameWin._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'city');
  static const GameWin mafia = GameWin._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'mafia');
  static const GameWin draw = GameWin._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'draw');

  static const $core.List<GameWin> values = <GameWin> [
    city,
    mafia,
    draw,
  ];

  static final $core.Map<$core.int, GameWin> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GameWin? valueOf($core.int value) => _byValue[value];

  const GameWin._($core.int v, $core.String n) : super(v, n);
}

class PlayerRole extends $pb.ProtobufEnum {
  static const PlayerRole citizen = PlayerRole._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'citizen');
  static const PlayerRole maf = PlayerRole._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'maf');
  static const PlayerRole don = PlayerRole._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'don');
  static const PlayerRole sheriff = PlayerRole._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'sheriff');

  static const $core.List<PlayerRole> values = <PlayerRole> [
    citizen,
    maf,
    don,
    sheriff,
  ];

  static final $core.Map<$core.int, PlayerRole> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PlayerRole? valueOf($core.int value) => _byValue[value];

  const PlayerRole._($core.int v, $core.String n) : super(v, n);
}

class PlayerStatus extends $pb.ProtobufEnum {
  static const PlayerStatus alive = PlayerStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'alive');
  static const PlayerStatus voted = PlayerStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'voted');
  static const PlayerStatus deleted = PlayerStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'deleted');
  static const PlayerStatus killed = PlayerStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'killed');

  static const $core.List<PlayerStatus> values = <PlayerStatus> [
    alive,
    voted,
    deleted,
    killed,
  ];

  static final $core.Map<$core.int, PlayerStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PlayerStatus? valueOf($core.int value) => _byValue[value];

  const PlayerStatus._($core.int v, $core.String n) : super(v, n);
}

class LoginEventOut_Error extends $pb.ProtobufEnum {
  static const LoginEventOut_Error noError = LoginEventOut_Error._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'noError');
  static const LoginEventOut_Error needVerification = LoginEventOut_Error._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'needVerification');
  static const LoginEventOut_Error invalidCredentials = LoginEventOut_Error._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'invalidCredentials');

  static const $core.List<LoginEventOut_Error> values = <LoginEventOut_Error> [
    noError,
    needVerification,
    invalidCredentials,
  ];

  static final $core.Map<$core.int, LoginEventOut_Error> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LoginEventOut_Error? valueOf($core.int value) => _byValue[value];

  const LoginEventOut_Error._($core.int v, $core.String n) : super(v, n);
}

class LoginByTokenEventOut_Error extends $pb.ProtobufEnum {
  static const LoginByTokenEventOut_Error noError = LoginByTokenEventOut_Error._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'noError');
  static const LoginByTokenEventOut_Error needVerification = LoginByTokenEventOut_Error._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'needVerification');
  static const LoginByTokenEventOut_Error invalidCredentials = LoginByTokenEventOut_Error._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'invalidCredentials');

  static const $core.List<LoginByTokenEventOut_Error> values = <LoginByTokenEventOut_Error> [
    noError,
    needVerification,
    invalidCredentials,
  ];

  static final $core.Map<$core.int, LoginByTokenEventOut_Error> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LoginByTokenEventOut_Error? valueOf($core.int value) => _byValue[value];

  const LoginByTokenEventOut_Error._($core.int v, $core.String n) : super(v, n);
}

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

class Tournament_Status extends $pb.ProtobufEnum {
  static const Tournament_Status waitForBilling = Tournament_Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'waitForBilling');
  static const Tournament_Status active = Tournament_Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'active');
  static const Tournament_Status ended = Tournament_Status._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ended');

  static const $core.List<Tournament_Status> values = <Tournament_Status> [
    waitForBilling,
    active,
    ended,
  ];

  static final $core.Map<$core.int, Tournament_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Tournament_Status? valueOf($core.int value) => _byValue[value];

  const Tournament_Status._($core.int v, $core.String n) : super(v, n);
}

