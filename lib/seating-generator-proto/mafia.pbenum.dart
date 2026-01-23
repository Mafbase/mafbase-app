//
//  Generated code. Do not modify.
//  source: seating-generator-proto/mafia.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class BestMove extends $pb.ProtobufEnum {
  static const BestMove miss = BestMove._(0, _omitEnumNames ? '' : 'miss');
  static const BestMove half = BestMove._(1, _omitEnumNames ? '' : 'half');
  static const BestMove full = BestMove._(2, _omitEnumNames ? '' : 'full');
  static const BestMove one = BestMove._(3, _omitEnumNames ? '' : 'one');

  static const $core.List<BestMove> values = <BestMove> [
    miss,
    half,
    full,
    one,
  ];

  static final $core.Map<$core.int, BestMove> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BestMove? valueOf($core.int value) => _byValue[value];

  const BestMove._(super.v, super.n);
}

class GameWin extends $pb.ProtobufEnum {
  static const GameWin city = GameWin._(0, _omitEnumNames ? '' : 'city');
  static const GameWin mafia = GameWin._(1, _omitEnumNames ? '' : 'mafia');
  static const GameWin draw = GameWin._(2, _omitEnumNames ? '' : 'draw');

  static const $core.List<GameWin> values = <GameWin> [
    city,
    mafia,
    draw,
  ];

  static final $core.Map<$core.int, GameWin> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GameWin? valueOf($core.int value) => _byValue[value];

  const GameWin._(super.v, super.n);
}

class FantasyStatus extends $pb.ProtobufEnum {
  static const FantasyStatus disabled = FantasyStatus._(0, _omitEnumNames ? '' : 'disabled');
  static const FantasyStatus enabledForSelected = FantasyStatus._(1, _omitEnumNames ? '' : 'enabledForSelected');
  static const FantasyStatus enabledForAll = FantasyStatus._(2, _omitEnumNames ? '' : 'enabledForAll');

  static const $core.List<FantasyStatus> values = <FantasyStatus> [
    disabled,
    enabledForSelected,
    enabledForAll,
  ];

  static final $core.Map<$core.int, FantasyStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FantasyStatus? valueOf($core.int value) => _byValue[value];

  const FantasyStatus._(super.v, super.n);
}

class PlayerRole extends $pb.ProtobufEnum {
  static const PlayerRole citizen = PlayerRole._(0, _omitEnumNames ? '' : 'citizen');
  static const PlayerRole maf = PlayerRole._(1, _omitEnumNames ? '' : 'maf');
  static const PlayerRole don = PlayerRole._(2, _omitEnumNames ? '' : 'don');
  static const PlayerRole sheriff = PlayerRole._(3, _omitEnumNames ? '' : 'sheriff');

  static const $core.List<PlayerRole> values = <PlayerRole> [
    citizen,
    maf,
    don,
    sheriff,
  ];

  static final $core.Map<$core.int, PlayerRole> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PlayerRole? valueOf($core.int value) => _byValue[value];

  const PlayerRole._(super.v, super.n);
}

class PlayerStatus extends $pb.ProtobufEnum {
  static const PlayerStatus alive = PlayerStatus._(0, _omitEnumNames ? '' : 'alive');
  static const PlayerStatus voted = PlayerStatus._(1, _omitEnumNames ? '' : 'voted');
  static const PlayerStatus deleted = PlayerStatus._(2, _omitEnumNames ? '' : 'deleted');
  static const PlayerStatus killed = PlayerStatus._(3, _omitEnumNames ? '' : 'killed');

  static const $core.List<PlayerStatus> values = <PlayerStatus> [
    alive,
    voted,
    deleted,
    killed,
  ];

  static final $core.Map<$core.int, PlayerStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PlayerStatus? valueOf($core.int value) => _byValue[value];

  const PlayerStatus._(super.v, super.n);
}

class RatingScheme extends $pb.ProtobufEnum {
  static const RatingScheme oldFSM = RatingScheme._(0, _omitEnumNames ? '' : 'oldFSM');
  static const RatingScheme minusFSM = RatingScheme._(1, _omitEnumNames ? '' : 'minusFSM');

  static const $core.List<RatingScheme> values = <RatingScheme> [
    oldFSM,
    minusFSM,
  ];

  static final $core.Map<$core.int, RatingScheme> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RatingScheme? valueOf($core.int value) => _byValue[value];

  const RatingScheme._(super.v, super.n);
}

class LoginEventOut_Error extends $pb.ProtobufEnum {
  static const LoginEventOut_Error noError = LoginEventOut_Error._(0, _omitEnumNames ? '' : 'noError');
  static const LoginEventOut_Error needVerification = LoginEventOut_Error._(1, _omitEnumNames ? '' : 'needVerification');
  static const LoginEventOut_Error invalidCredentials = LoginEventOut_Error._(2, _omitEnumNames ? '' : 'invalidCredentials');

  static const $core.List<LoginEventOut_Error> values = <LoginEventOut_Error> [
    noError,
    needVerification,
    invalidCredentials,
  ];

  static final $core.Map<$core.int, LoginEventOut_Error> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LoginEventOut_Error? valueOf($core.int value) => _byValue[value];

  const LoginEventOut_Error._(super.v, super.n);
}

class LoginByTokenEventOut_Error extends $pb.ProtobufEnum {
  static const LoginByTokenEventOut_Error noError = LoginByTokenEventOut_Error._(0, _omitEnumNames ? '' : 'noError');
  static const LoginByTokenEventOut_Error needVerification = LoginByTokenEventOut_Error._(1, _omitEnumNames ? '' : 'needVerification');
  static const LoginByTokenEventOut_Error invalidCredentials = LoginByTokenEventOut_Error._(2, _omitEnumNames ? '' : 'invalidCredentials');

  static const $core.List<LoginByTokenEventOut_Error> values = <LoginByTokenEventOut_Error> [
    noError,
    needVerification,
    invalidCredentials,
  ];

  static final $core.Map<$core.int, LoginByTokenEventOut_Error> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LoginByTokenEventOut_Error? valueOf($core.int value) => _byValue[value];

  const LoginByTokenEventOut_Error._(super.v, super.n);
}

class SignUpEventOut_Error extends $pb.ProtobufEnum {
  static const SignUpEventOut_Error noError = SignUpEventOut_Error._(0, _omitEnumNames ? '' : 'noError');
  static const SignUpEventOut_Error emailExist = SignUpEventOut_Error._(1, _omitEnumNames ? '' : 'emailExist');
  static const SignUpEventOut_Error weakPassword = SignUpEventOut_Error._(2, _omitEnumNames ? '' : 'weakPassword');
  static const SignUpEventOut_Error needVerification = SignUpEventOut_Error._(4, _omitEnumNames ? '' : 'needVerification');

  static const $core.List<SignUpEventOut_Error> values = <SignUpEventOut_Error> [
    noError,
    emailExist,
    weakPassword,
    needVerification,
  ];

  static final $core.Map<$core.int, SignUpEventOut_Error> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SignUpEventOut_Error? valueOf($core.int value) => _byValue[value];

  const SignUpEventOut_Error._(super.v, super.n);
}

class EmailVerificationEventOut_Status extends $pb.ProtobufEnum {
  static const EmailVerificationEventOut_Status success = EmailVerificationEventOut_Status._(0, _omitEnumNames ? '' : 'success');
  static const EmailVerificationEventOut_Status incorrectToken = EmailVerificationEventOut_Status._(1, _omitEnumNames ? '' : 'incorrectToken');

  static const $core.List<EmailVerificationEventOut_Status> values = <EmailVerificationEventOut_Status> [
    success,
    incorrectToken,
  ];

  static final $core.Map<$core.int, EmailVerificationEventOut_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static EmailVerificationEventOut_Status? valueOf($core.int value) => _byValue[value];

  const EmailVerificationEventOut_Status._(super.v, super.n);
}

class Tournament_Status extends $pb.ProtobufEnum {
  static const Tournament_Status waitForBilling = Tournament_Status._(0, _omitEnumNames ? '' : 'waitForBilling');
  static const Tournament_Status active = Tournament_Status._(1, _omitEnumNames ? '' : 'active');
  static const Tournament_Status ended = Tournament_Status._(2, _omitEnumNames ? '' : 'ended');

  static const $core.List<Tournament_Status> values = <Tournament_Status> [
    waitForBilling,
    active,
    ended,
  ];

  static final $core.Map<$core.int, Tournament_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Tournament_Status? valueOf($core.int value) => _byValue[value];

  const Tournament_Status._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
