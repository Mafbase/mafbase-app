///
//  Generated code. Do not modify.
//  source: seating-generator-proto/mafia.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'mafia.pbenum.dart';

export 'mafia.pbenum.dart';

class LoginEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoginEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'password')
    ..hasRequiredFields = false
  ;

  LoginEvent._() : super();
  factory LoginEvent({
    $core.String? email,
    $core.String? password,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    if (password != null) {
      _result.password = password;
    }
    return _result;
  }
  factory LoginEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoginEvent clone() => LoginEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoginEvent copyWith(void Function(LoginEvent) updates) => super.copyWith((message) => updates(message as LoginEvent)) as LoginEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginEvent create() => LoginEvent._();
  LoginEvent createEmptyInstance() => create();
  static $pb.PbList<LoginEvent> createRepeated() => $pb.PbList<LoginEvent>();
  @$core.pragma('dart2js:noInline')
  static LoginEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginEvent>(create);
  static LoginEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);
}

class LoginEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoginEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recoveryToken', protoName: 'recoveryToken')
    ..hasRequiredFields = false
  ;

  LoginEventOut._() : super();
  factory LoginEventOut({
    $core.String? token,
    $core.String? recoveryToken,
  }) {
    final _result = create();
    if (token != null) {
      _result.token = token;
    }
    if (recoveryToken != null) {
      _result.recoveryToken = recoveryToken;
    }
    return _result;
  }
  factory LoginEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoginEventOut clone() => LoginEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoginEventOut copyWith(void Function(LoginEventOut) updates) => super.copyWith((message) => updates(message as LoginEventOut)) as LoginEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginEventOut create() => LoginEventOut._();
  LoginEventOut createEmptyInstance() => create();
  static $pb.PbList<LoginEventOut> createRepeated() => $pb.PbList<LoginEventOut>();
  @$core.pragma('dart2js:noInline')
  static LoginEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginEventOut>(create);
  static LoginEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get recoveryToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set recoveryToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRecoveryToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecoveryToken() => clearField(2);
}

class LoginByTokenEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoginByTokenEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..hasRequiredFields = false
  ;

  LoginByTokenEvent._() : super();
  factory LoginByTokenEvent({
    $core.String? token,
  }) {
    final _result = create();
    if (token != null) {
      _result.token = token;
    }
    return _result;
  }
  factory LoginByTokenEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginByTokenEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoginByTokenEvent clone() => LoginByTokenEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoginByTokenEvent copyWith(void Function(LoginByTokenEvent) updates) => super.copyWith((message) => updates(message as LoginByTokenEvent)) as LoginByTokenEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginByTokenEvent create() => LoginByTokenEvent._();
  LoginByTokenEvent createEmptyInstance() => create();
  static $pb.PbList<LoginByTokenEvent> createRepeated() => $pb.PbList<LoginByTokenEvent>();
  @$core.pragma('dart2js:noInline')
  static LoginByTokenEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginByTokenEvent>(create);
  static LoginByTokenEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);
}

class LoginByTokenEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoginByTokenEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recoveryToken', protoName: 'recoveryToken')
    ..hasRequiredFields = false
  ;

  LoginByTokenEventOut._() : super();
  factory LoginByTokenEventOut({
    $core.String? token,
    $core.String? recoveryToken,
  }) {
    final _result = create();
    if (token != null) {
      _result.token = token;
    }
    if (recoveryToken != null) {
      _result.recoveryToken = recoveryToken;
    }
    return _result;
  }
  factory LoginByTokenEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginByTokenEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoginByTokenEventOut clone() => LoginByTokenEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoginByTokenEventOut copyWith(void Function(LoginByTokenEventOut) updates) => super.copyWith((message) => updates(message as LoginByTokenEventOut)) as LoginByTokenEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginByTokenEventOut create() => LoginByTokenEventOut._();
  LoginByTokenEventOut createEmptyInstance() => create();
  static $pb.PbList<LoginByTokenEventOut> createRepeated() => $pb.PbList<LoginByTokenEventOut>();
  @$core.pragma('dart2js:noInline')
  static LoginByTokenEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginByTokenEventOut>(create);
  static LoginByTokenEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get recoveryToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set recoveryToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRecoveryToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecoveryToken() => clearField(2);
}

class SignUpEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SignUpEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'password')
    ..hasRequiredFields = false
  ;

  SignUpEvent._() : super();
  factory SignUpEvent({
    $core.String? email,
    $core.String? password,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    if (password != null) {
      _result.password = password;
    }
    return _result;
  }
  factory SignUpEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignUpEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignUpEvent clone() => SignUpEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignUpEvent copyWith(void Function(SignUpEvent) updates) => super.copyWith((message) => updates(message as SignUpEvent)) as SignUpEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignUpEvent create() => SignUpEvent._();
  SignUpEvent createEmptyInstance() => create();
  static $pb.PbList<SignUpEvent> createRepeated() => $pb.PbList<SignUpEvent>();
  @$core.pragma('dart2js:noInline')
  static SignUpEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignUpEvent>(create);
  static SignUpEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);
}

class SignUpEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SignUpEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recoveryToken', protoName: 'recoveryToken')
    ..e<SignUpEventOut_Error>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: SignUpEventOut_Error.noError, valueOf: SignUpEventOut_Error.valueOf, enumValues: SignUpEventOut_Error.values)
    ..hasRequiredFields = false
  ;

  SignUpEventOut._() : super();
  factory SignUpEventOut({
    $core.String? token,
    $core.String? recoveryToken,
    SignUpEventOut_Error? error,
  }) {
    final _result = create();
    if (token != null) {
      _result.token = token;
    }
    if (recoveryToken != null) {
      _result.recoveryToken = recoveryToken;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory SignUpEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignUpEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignUpEventOut clone() => SignUpEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignUpEventOut copyWith(void Function(SignUpEventOut) updates) => super.copyWith((message) => updates(message as SignUpEventOut)) as SignUpEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignUpEventOut create() => SignUpEventOut._();
  SignUpEventOut createEmptyInstance() => create();
  static $pb.PbList<SignUpEventOut> createRepeated() => $pb.PbList<SignUpEventOut>();
  @$core.pragma('dart2js:noInline')
  static SignUpEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignUpEventOut>(create);
  static SignUpEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get recoveryToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set recoveryToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRecoveryToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecoveryToken() => clearField(2);

  @$pb.TagNumber(3)
  SignUpEventOut_Error get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(SignUpEventOut_Error v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => clearField(3);
}

class SeatingForTranslationEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SeatingForTranslationEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tournamentId', $pb.PbFieldType.O3, protoName: 'tournamentId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'table', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'game', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SeatingForTranslationEvent._() : super();
  factory SeatingForTranslationEvent({
    $core.int? tournamentId,
    $core.int? table,
    $core.int? game,
  }) {
    final _result = create();
    if (tournamentId != null) {
      _result.tournamentId = tournamentId;
    }
    if (table != null) {
      _result.table = table;
    }
    if (game != null) {
      _result.game = game;
    }
    return _result;
  }
  factory SeatingForTranslationEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SeatingForTranslationEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SeatingForTranslationEvent clone() => SeatingForTranslationEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SeatingForTranslationEvent copyWith(void Function(SeatingForTranslationEvent) updates) => super.copyWith((message) => updates(message as SeatingForTranslationEvent)) as SeatingForTranslationEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SeatingForTranslationEvent create() => SeatingForTranslationEvent._();
  SeatingForTranslationEvent createEmptyInstance() => create();
  static $pb.PbList<SeatingForTranslationEvent> createRepeated() => $pb.PbList<SeatingForTranslationEvent>();
  @$core.pragma('dart2js:noInline')
  static SeatingForTranslationEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SeatingForTranslationEvent>(create);
  static SeatingForTranslationEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get tournamentId => $_getIZ(0);
  @$pb.TagNumber(1)
  set tournamentId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTournamentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTournamentId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get table => $_getIZ(1);
  @$pb.TagNumber(2)
  set table($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTable() => $_has(1);
  @$pb.TagNumber(2)
  void clearTable() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get game => $_getIZ(2);
  @$pb.TagNumber(3)
  set game($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGame() => $_has(2);
  @$pb.TagNumber(3)
  void clearGame() => clearField(3);
}

class SeatingForTranslationEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SeatingForTranslationEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'players')
    ..hasRequiredFields = false
  ;

  SeatingForTranslationEventOut._() : super();
  factory SeatingForTranslationEventOut({
    $core.Iterable<$core.String>? players,
  }) {
    final _result = create();
    if (players != null) {
      _result.players.addAll(players);
    }
    return _result;
  }
  factory SeatingForTranslationEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SeatingForTranslationEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SeatingForTranslationEventOut clone() => SeatingForTranslationEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SeatingForTranslationEventOut copyWith(void Function(SeatingForTranslationEventOut) updates) => super.copyWith((message) => updates(message as SeatingForTranslationEventOut)) as SeatingForTranslationEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SeatingForTranslationEventOut create() => SeatingForTranslationEventOut._();
  SeatingForTranslationEventOut createEmptyInstance() => create();
  static $pb.PbList<SeatingForTranslationEventOut> createRepeated() => $pb.PbList<SeatingForTranslationEventOut>();
  @$core.pragma('dart2js:noInline')
  static SeatingForTranslationEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SeatingForTranslationEventOut>(create);
  static SeatingForTranslationEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get players => $_getList(0);
}

class InsertSeatingEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsertSeatingEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bytes', $pb.PbFieldType.OY)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tournamentId', $pb.PbFieldType.O3, protoName: 'tournamentId')
    ..hasRequiredFields = false
  ;

  InsertSeatingEvent._() : super();
  factory InsertSeatingEvent({
    $core.List<$core.int>? bytes,
    $core.int? tournamentId,
  }) {
    final _result = create();
    if (bytes != null) {
      _result.bytes = bytes;
    }
    if (tournamentId != null) {
      _result.tournamentId = tournamentId;
    }
    return _result;
  }
  factory InsertSeatingEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsertSeatingEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsertSeatingEvent clone() => InsertSeatingEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsertSeatingEvent copyWith(void Function(InsertSeatingEvent) updates) => super.copyWith((message) => updates(message as InsertSeatingEvent)) as InsertSeatingEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InsertSeatingEvent create() => InsertSeatingEvent._();
  InsertSeatingEvent createEmptyInstance() => create();
  static $pb.PbList<InsertSeatingEvent> createRepeated() => $pb.PbList<InsertSeatingEvent>();
  @$core.pragma('dart2js:noInline')
  static InsertSeatingEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsertSeatingEvent>(create);
  static InsertSeatingEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get bytes => $_getN(0);
  @$pb.TagNumber(1)
  set bytes($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBytes() => $_has(0);
  @$pb.TagNumber(1)
  void clearBytes() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get tournamentId => $_getIZ(1);
  @$pb.TagNumber(2)
  set tournamentId($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTournamentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTournamentId() => clearField(2);
}

class GetTournamentsEventOut_Tournament extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTournamentsEventOut.Tournament', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<GetTournamentsEventOut_Tournament_Status>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: GetTournamentsEventOut_Tournament_Status.waitForBilling, valueOf: GetTournamentsEventOut_Tournament_Status.valueOf, enumValues: GetTournamentsEventOut_Tournament_Status.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateStart', protoName: 'dateStart')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateEnd', protoName: 'dateEnd')
    ..hasRequiredFields = false
  ;

  GetTournamentsEventOut_Tournament._() : super();
  factory GetTournamentsEventOut_Tournament({
    $core.int? id,
    $core.String? name,
    GetTournamentsEventOut_Tournament_Status? status,
    $core.String? dateStart,
    $core.String? dateEnd,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (status != null) {
      _result.status = status;
    }
    if (dateStart != null) {
      _result.dateStart = dateStart;
    }
    if (dateEnd != null) {
      _result.dateEnd = dateEnd;
    }
    return _result;
  }
  factory GetTournamentsEventOut_Tournament.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTournamentsEventOut_Tournament.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTournamentsEventOut_Tournament clone() => GetTournamentsEventOut_Tournament()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTournamentsEventOut_Tournament copyWith(void Function(GetTournamentsEventOut_Tournament) updates) => super.copyWith((message) => updates(message as GetTournamentsEventOut_Tournament)) as GetTournamentsEventOut_Tournament; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTournamentsEventOut_Tournament create() => GetTournamentsEventOut_Tournament._();
  GetTournamentsEventOut_Tournament createEmptyInstance() => create();
  static $pb.PbList<GetTournamentsEventOut_Tournament> createRepeated() => $pb.PbList<GetTournamentsEventOut_Tournament>();
  @$core.pragma('dart2js:noInline')
  static GetTournamentsEventOut_Tournament getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTournamentsEventOut_Tournament>(create);
  static GetTournamentsEventOut_Tournament? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  GetTournamentsEventOut_Tournament_Status get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(GetTournamentsEventOut_Tournament_Status v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get dateStart => $_getSZ(3);
  @$pb.TagNumber(4)
  set dateStart($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDateStart() => $_has(3);
  @$pb.TagNumber(4)
  void clearDateStart() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get dateEnd => $_getSZ(4);
  @$pb.TagNumber(5)
  set dateEnd($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDateEnd() => $_has(4);
  @$pb.TagNumber(5)
  void clearDateEnd() => clearField(5);
}

class GetTournamentsEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTournamentsEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..pc<GetTournamentsEventOut_Tournament>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tournaments', $pb.PbFieldType.PM, subBuilder: GetTournamentsEventOut_Tournament.create)
    ..hasRequiredFields = false
  ;

  GetTournamentsEventOut._() : super();
  factory GetTournamentsEventOut({
    $core.Iterable<GetTournamentsEventOut_Tournament>? tournaments,
  }) {
    final _result = create();
    if (tournaments != null) {
      _result.tournaments.addAll(tournaments);
    }
    return _result;
  }
  factory GetTournamentsEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTournamentsEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTournamentsEventOut clone() => GetTournamentsEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTournamentsEventOut copyWith(void Function(GetTournamentsEventOut) updates) => super.copyWith((message) => updates(message as GetTournamentsEventOut)) as GetTournamentsEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTournamentsEventOut create() => GetTournamentsEventOut._();
  GetTournamentsEventOut createEmptyInstance() => create();
  static $pb.PbList<GetTournamentsEventOut> createRepeated() => $pb.PbList<GetTournamentsEventOut>();
  @$core.pragma('dart2js:noInline')
  static GetTournamentsEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTournamentsEventOut>(create);
  static GetTournamentsEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GetTournamentsEventOut_Tournament> get tournaments => $_getList(0);
}

