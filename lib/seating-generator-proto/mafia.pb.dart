///
//  Generated code. Do not modify.
//  source: seating-generator-proto/mafia.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

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

class TableSeating extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TableSeating', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nickname')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referee')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'table', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  TableSeating._() : super();
  factory TableSeating({
    $core.Iterable<$core.String>? nickname,
    $core.String? referee,
    $core.int? table,
  }) {
    final _result = create();
    if (nickname != null) {
      _result.nickname.addAll(nickname);
    }
    if (referee != null) {
      _result.referee = referee;
    }
    if (table != null) {
      _result.table = table;
    }
    return _result;
  }
  factory TableSeating.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TableSeating.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TableSeating clone() => TableSeating()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TableSeating copyWith(void Function(TableSeating) updates) => super.copyWith((message) => updates(message as TableSeating)) as TableSeating; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TableSeating create() => TableSeating._();
  TableSeating createEmptyInstance() => create();
  static $pb.PbList<TableSeating> createRepeated() => $pb.PbList<TableSeating>();
  @$core.pragma('dart2js:noInline')
  static TableSeating getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TableSeating>(create);
  static TableSeating? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get nickname => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get referee => $_getSZ(1);
  @$pb.TagNumber(2)
  set referee($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReferee() => $_has(1);
  @$pb.TagNumber(2)
  void clearReferee() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get table => $_getIZ(2);
  @$pb.TagNumber(3)
  set table($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTable() => $_has(2);
  @$pb.TagNumber(3)
  void clearTable() => clearField(3);
}

class TableSeatingResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TableSeatingResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..pc<PlayerRole>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role', $pb.PbFieldType.KE, valueOf: PlayerRole.valueOf, enumValues: PlayerRole.values, defaultEnumValue: PlayerRole.citizen)
    ..p<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'score', $pb.PbFieldType.KD)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'died', $pb.PbFieldType.O3)
    ..e<GameWin>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'win', $pb.PbFieldType.OE, defaultOrMaker: GameWin.city, valueOf: GameWin.valueOf, enumValues: GameWin.values)
    ..e<BestMove>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bestMove', $pb.PbFieldType.OE, protoName: 'bestMove', defaultOrMaker: BestMove.miss, valueOf: BestMove.valueOf, enumValues: BestMove.values)
    ..p<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addScore', $pb.PbFieldType.KD, protoName: 'addScore')
    ..hasRequiredFields = false
  ;

  TableSeatingResult._() : super();
  factory TableSeatingResult({
    $core.Iterable<PlayerRole>? role,
    $core.Iterable<$core.double>? score,
    $core.int? died,
    GameWin? win,
    BestMove? bestMove,
    $core.Iterable<$core.double>? addScore,
  }) {
    final _result = create();
    if (role != null) {
      _result.role.addAll(role);
    }
    if (score != null) {
      _result.score.addAll(score);
    }
    if (died != null) {
      _result.died = died;
    }
    if (win != null) {
      _result.win = win;
    }
    if (bestMove != null) {
      _result.bestMove = bestMove;
    }
    if (addScore != null) {
      _result.addScore.addAll(addScore);
    }
    return _result;
  }
  factory TableSeatingResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TableSeatingResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TableSeatingResult clone() => TableSeatingResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TableSeatingResult copyWith(void Function(TableSeatingResult) updates) => super.copyWith((message) => updates(message as TableSeatingResult)) as TableSeatingResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TableSeatingResult create() => TableSeatingResult._();
  TableSeatingResult createEmptyInstance() => create();
  static $pb.PbList<TableSeatingResult> createRepeated() => $pb.PbList<TableSeatingResult>();
  @$core.pragma('dart2js:noInline')
  static TableSeatingResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TableSeatingResult>(create);
  static TableSeatingResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PlayerRole> get role => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$core.double> get score => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get died => $_getIZ(2);
  @$pb.TagNumber(3)
  set died($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDied() => $_has(2);
  @$pb.TagNumber(3)
  void clearDied() => clearField(3);

  @$pb.TagNumber(4)
  GameWin get win => $_getN(3);
  @$pb.TagNumber(4)
  set win(GameWin v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasWin() => $_has(3);
  @$pb.TagNumber(4)
  void clearWin() => clearField(4);

  @$pb.TagNumber(5)
  BestMove get bestMove => $_getN(4);
  @$pb.TagNumber(5)
  set bestMove(BestMove v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasBestMove() => $_has(4);
  @$pb.TagNumber(5)
  void clearBestMove() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.double> get addScore => $_getList(5);
}

class TableSeatingItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TableSeatingItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gameId', $pb.PbFieldType.O3, protoName: 'gameId')
    ..aOM<TableSeating>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'seating', subBuilder: TableSeating.create)
    ..aOM<TableSeatingResult>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: TableSeatingResult.create)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'game', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'table', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  TableSeatingItem._() : super();
  factory TableSeatingItem({
    $core.int? gameId,
    TableSeating? seating,
    TableSeatingResult? result,
    $core.int? game,
    $core.int? table,
  }) {
    final _result = create();
    if (gameId != null) {
      _result.gameId = gameId;
    }
    if (seating != null) {
      _result.seating = seating;
    }
    if (result != null) {
      _result.result = result;
    }
    if (game != null) {
      _result.game = game;
    }
    if (table != null) {
      _result.table = table;
    }
    return _result;
  }
  factory TableSeatingItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TableSeatingItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TableSeatingItem clone() => TableSeatingItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TableSeatingItem copyWith(void Function(TableSeatingItem) updates) => super.copyWith((message) => updates(message as TableSeatingItem)) as TableSeatingItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TableSeatingItem create() => TableSeatingItem._();
  TableSeatingItem createEmptyInstance() => create();
  static $pb.PbList<TableSeatingItem> createRepeated() => $pb.PbList<TableSeatingItem>();
  @$core.pragma('dart2js:noInline')
  static TableSeatingItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TableSeatingItem>(create);
  static TableSeatingItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get gameId => $_getIZ(0);
  @$pb.TagNumber(1)
  set gameId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => clearField(1);

  @$pb.TagNumber(2)
  TableSeating get seating => $_getN(1);
  @$pb.TagNumber(2)
  set seating(TableSeating v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSeating() => $_has(1);
  @$pb.TagNumber(2)
  void clearSeating() => clearField(2);
  @$pb.TagNumber(2)
  TableSeating ensureSeating() => $_ensure(1);

  @$pb.TagNumber(3)
  TableSeatingResult get result => $_getN(2);
  @$pb.TagNumber(3)
  set result(TableSeatingResult v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasResult() => $_has(2);
  @$pb.TagNumber(3)
  void clearResult() => clearField(3);
  @$pb.TagNumber(3)
  TableSeatingResult ensureResult() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get game => $_getIZ(3);
  @$pb.TagNumber(4)
  set game($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasGame() => $_has(3);
  @$pb.TagNumber(4)
  void clearGame() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get table => $_getIZ(4);
  @$pb.TagNumber(5)
  set table($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTable() => $_has(4);
  @$pb.TagNumber(5)
  void clearTable() => clearField(5);
}

class SeatingEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SeatingEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..pc<TableSeatingItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'item', $pb.PbFieldType.PM, subBuilder: TableSeatingItem.create)
    ..hasRequiredFields = false
  ;

  SeatingEventOut._() : super();
  factory SeatingEventOut({
    $core.Iterable<TableSeatingItem>? item,
  }) {
    final _result = create();
    if (item != null) {
      _result.item.addAll(item);
    }
    return _result;
  }
  factory SeatingEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SeatingEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SeatingEventOut clone() => SeatingEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SeatingEventOut copyWith(void Function(SeatingEventOut) updates) => super.copyWith((message) => updates(message as SeatingEventOut)) as SeatingEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SeatingEventOut create() => SeatingEventOut._();
  SeatingEventOut createEmptyInstance() => create();
  static $pb.PbList<SeatingEventOut> createRepeated() => $pb.PbList<SeatingEventOut>();
  @$core.pragma('dart2js:noInline')
  static SeatingEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SeatingEventOut>(create);
  static SeatingEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TableSeatingItem> get item => $_getList(0);
}

class LoginEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoginEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recoveryToken', protoName: 'recoveryToken')
    ..e<LoginEventOut_Error>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: LoginEventOut_Error.noError, valueOf: LoginEventOut_Error.valueOf, enumValues: LoginEventOut_Error.values)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  LoginEventOut._() : super();
  factory LoginEventOut({
    $core.String? token,
    $core.String? recoveryToken,
    LoginEventOut_Error? error,
    $core.int? id,
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
    if (id != null) {
      _result.id = id;
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

  @$pb.TagNumber(3)
  LoginEventOut_Error get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(LoginEventOut_Error v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get id => $_getIZ(3);
  @$pb.TagNumber(4)
  set id($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasId() => $_has(3);
  @$pb.TagNumber(4)
  void clearId() => clearField(4);
}

class ChangeSeatingContent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ChangeSeatingContent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'player', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrl', protoName: 'imageUrl')
    ..e<PlayerRole>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role', $pb.PbFieldType.OE, defaultOrMaker: PlayerRole.citizen, valueOf: PlayerRole.valueOf, enumValues: PlayerRole.values)
    ..e<PlayerStatus>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: PlayerStatus.alive, valueOf: PlayerStatus.valueOf, enumValues: PlayerStatus.values)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selectedGame', $pb.PbFieldType.O3, protoName: 'selectedGame')
    ..hasRequiredFields = false
  ;

  ChangeSeatingContent._() : super();
  factory ChangeSeatingContent({
    $core.int? player,
    $core.String? imageUrl,
    PlayerRole? role,
    PlayerStatus? status,
    $core.int? selectedGame,
  }) {
    final _result = create();
    if (player != null) {
      _result.player = player;
    }
    if (imageUrl != null) {
      _result.imageUrl = imageUrl;
    }
    if (role != null) {
      _result.role = role;
    }
    if (status != null) {
      _result.status = status;
    }
    if (selectedGame != null) {
      _result.selectedGame = selectedGame;
    }
    return _result;
  }
  factory ChangeSeatingContent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangeSeatingContent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChangeSeatingContent clone() => ChangeSeatingContent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChangeSeatingContent copyWith(void Function(ChangeSeatingContent) updates) => super.copyWith((message) => updates(message as ChangeSeatingContent)) as ChangeSeatingContent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChangeSeatingContent create() => ChangeSeatingContent._();
  ChangeSeatingContent createEmptyInstance() => create();
  static $pb.PbList<ChangeSeatingContent> createRepeated() => $pb.PbList<ChangeSeatingContent>();
  @$core.pragma('dart2js:noInline')
  static ChangeSeatingContent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangeSeatingContent>(create);
  static ChangeSeatingContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get player => $_getIZ(0);
  @$pb.TagNumber(1)
  set player($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get imageUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set imageUrl($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasImageUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageUrl() => clearField(2);

  @$pb.TagNumber(3)
  PlayerRole get role => $_getN(2);
  @$pb.TagNumber(3)
  set role(PlayerRole v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => clearField(3);

  @$pb.TagNumber(4)
  PlayerStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(PlayerStatus v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get selectedGame => $_getIZ(4);
  @$pb.TagNumber(5)
  set selectedGame($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSelectedGame() => $_has(4);
  @$pb.TagNumber(5)
  void clearSelectedGame() => clearField(5);
}

class Club extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Club', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrl', protoName: 'imageUrl')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupLink', protoName: 'groupLink')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'city')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billedFor', protoName: 'billedFor')
    ..hasRequiredFields = false
  ;

  Club._() : super();
  factory Club({
    $core.int? id,
    $core.String? name,
    $core.String? description,
    $core.String? imageUrl,
    $core.String? groupLink,
    $core.String? city,
    $core.String? billedFor,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (imageUrl != null) {
      _result.imageUrl = imageUrl;
    }
    if (groupLink != null) {
      _result.groupLink = groupLink;
    }
    if (city != null) {
      _result.city = city;
    }
    if (billedFor != null) {
      _result.billedFor = billedFor;
    }
    return _result;
  }
  factory Club.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Club.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Club clone() => Club()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Club copyWith(void Function(Club) updates) => super.copyWith((message) => updates(message as Club)) as Club; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Club create() => Club._();
  Club createEmptyInstance() => create();
  static $pb.PbList<Club> createRepeated() => $pb.PbList<Club>();
  @$core.pragma('dart2js:noInline')
  static Club getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Club>(create);
  static Club? _defaultInstance;

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
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get imageUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set imageUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasImageUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearImageUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get groupLink => $_getSZ(4);
  @$pb.TagNumber(5)
  set groupLink($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGroupLink() => $_has(4);
  @$pb.TagNumber(5)
  void clearGroupLink() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get city => $_getSZ(5);
  @$pb.TagNumber(6)
  set city($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCity() => $_has(5);
  @$pb.TagNumber(6)
  void clearCity() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get billedFor => $_getSZ(6);
  @$pb.TagNumber(7)
  set billedFor($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBilledFor() => $_has(6);
  @$pb.TagNumber(7)
  void clearBilledFor() => clearField(7);
}

class ClubRatingEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClubRatingEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..pc<ClubRatingRow>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'row', $pb.PbFieldType.PM, subBuilder: ClubRatingRow.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'clubName', protoName: 'clubName')
    ..hasRequiredFields = false
  ;

  ClubRatingEventOut._() : super();
  factory ClubRatingEventOut({
    $core.Iterable<ClubRatingRow>? row,
    $core.String? clubName,
  }) {
    final _result = create();
    if (row != null) {
      _result.row.addAll(row);
    }
    if (clubName != null) {
      _result.clubName = clubName;
    }
    return _result;
  }
  factory ClubRatingEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClubRatingEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClubRatingEventOut clone() => ClubRatingEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClubRatingEventOut copyWith(void Function(ClubRatingEventOut) updates) => super.copyWith((message) => updates(message as ClubRatingEventOut)) as ClubRatingEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClubRatingEventOut create() => ClubRatingEventOut._();
  ClubRatingEventOut createEmptyInstance() => create();
  static $pb.PbList<ClubRatingEventOut> createRepeated() => $pb.PbList<ClubRatingEventOut>();
  @$core.pragma('dart2js:noInline')
  static ClubRatingEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClubRatingEventOut>(create);
  static ClubRatingEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ClubRatingRow> get row => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get clubName => $_getSZ(1);
  @$pb.TagNumber(2)
  set clubName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClubName() => $_has(1);
  @$pb.TagNumber(2)
  void clearClubName() => clearField(2);
}

class ClubRatingRow_GameItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClubRatingRow.GameItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gameId', $pb.PbFieldType.O3, protoName: 'gameId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'score', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ClubRatingRow_GameItem._() : super();
  factory ClubRatingRow_GameItem({
    $core.int? gameId,
    $core.double? score,
  }) {
    final _result = create();
    if (gameId != null) {
      _result.gameId = gameId;
    }
    if (score != null) {
      _result.score = score;
    }
    return _result;
  }
  factory ClubRatingRow_GameItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClubRatingRow_GameItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClubRatingRow_GameItem clone() => ClubRatingRow_GameItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClubRatingRow_GameItem copyWith(void Function(ClubRatingRow_GameItem) updates) => super.copyWith((message) => updates(message as ClubRatingRow_GameItem)) as ClubRatingRow_GameItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClubRatingRow_GameItem create() => ClubRatingRow_GameItem._();
  ClubRatingRow_GameItem createEmptyInstance() => create();
  static $pb.PbList<ClubRatingRow_GameItem> createRepeated() => $pb.PbList<ClubRatingRow_GameItem>();
  @$core.pragma('dart2js:noInline')
  static ClubRatingRow_GameItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClubRatingRow_GameItem>(create);
  static ClubRatingRow_GameItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get gameId => $_getIZ(0);
  @$pb.TagNumber(1)
  set gameId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get score => $_getN(1);
  @$pb.TagNumber(2)
  set score($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearScore() => clearField(2);
}

class ClubRatingRow extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClubRatingRow', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nickname')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'score', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addScore', $pb.PbFieldType.OD, protoName: 'addScore')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstDie', $pb.PbFieldType.O3, protoName: 'firstDie')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donWins', $pb.PbFieldType.O3, protoName: 'donWins')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sheriffWins', $pb.PbFieldType.O3, protoName: 'sheriffWins')
    ..pc<ClubRatingRow_GameItem>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'item', $pb.PbFieldType.PM, subBuilder: ClubRatingRow_GameItem.create)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'wins', $pb.PbFieldType.O3)
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ci', $pb.PbFieldType.O3)
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalGames', $pb.PbFieldType.O3, protoName: 'totalGames')
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'citizenGames', $pb.PbFieldType.O3, protoName: 'citizenGames')
    ..a<$core.int>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donGames', $pb.PbFieldType.O3, protoName: 'donGames')
    ..a<$core.int>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sheriffGames', $pb.PbFieldType.O3, protoName: 'sheriffGames')
    ..a<$core.int>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mafiaGames', $pb.PbFieldType.O3, protoName: 'mafiaGames')
    ..a<$core.int>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mafiaWins', $pb.PbFieldType.O3, protoName: 'mafiaWins')
    ..a<$core.int>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'citizenWins', $pb.PbFieldType.O3, protoName: 'citizenWins')
    ..a<$core.double>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'citizenAddScore', $pb.PbFieldType.OD, protoName: 'citizenAddScore')
    ..a<$core.double>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mafiaAddScore', $pb.PbFieldType.OD, protoName: 'mafiaAddScore')
    ..a<$core.double>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donAddScore', $pb.PbFieldType.OD, protoName: 'donAddScore')
    ..a<$core.double>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sheriffAddScore', $pb.PbFieldType.OD, protoName: 'sheriffAddScore')
    ..a<$core.double>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'citizenScore', $pb.PbFieldType.OD, protoName: 'citizenScore')
    ..a<$core.double>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mafiaScore', $pb.PbFieldType.OD, protoName: 'mafiaScore')
    ..a<$core.double>(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'donScore', $pb.PbFieldType.OD, protoName: 'donScore')
    ..a<$core.double>(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sheriffScore', $pb.PbFieldType.OD, protoName: 'sheriffScore')
    ..hasRequiredFields = false
  ;

  ClubRatingRow._() : super();
  factory ClubRatingRow({
    $core.String? nickname,
    $core.double? score,
    $core.double? addScore,
    $core.int? firstDie,
    $core.int? donWins,
    $core.int? sheriffWins,
    $core.Iterable<ClubRatingRow_GameItem>? item,
    $core.int? wins,
    $core.int? ci,
    $core.int? totalGames,
    $core.int? citizenGames,
    $core.int? donGames,
    $core.int? sheriffGames,
    $core.int? mafiaGames,
    $core.int? mafiaWins,
    $core.int? citizenWins,
    $core.double? citizenAddScore,
    $core.double? mafiaAddScore,
    $core.double? donAddScore,
    $core.double? sheriffAddScore,
    $core.double? citizenScore,
    $core.double? mafiaScore,
    $core.double? donScore,
    $core.double? sheriffScore,
  }) {
    final _result = create();
    if (nickname != null) {
      _result.nickname = nickname;
    }
    if (score != null) {
      _result.score = score;
    }
    if (addScore != null) {
      _result.addScore = addScore;
    }
    if (firstDie != null) {
      _result.firstDie = firstDie;
    }
    if (donWins != null) {
      _result.donWins = donWins;
    }
    if (sheriffWins != null) {
      _result.sheriffWins = sheriffWins;
    }
    if (item != null) {
      _result.item.addAll(item);
    }
    if (wins != null) {
      _result.wins = wins;
    }
    if (ci != null) {
      _result.ci = ci;
    }
    if (totalGames != null) {
      _result.totalGames = totalGames;
    }
    if (citizenGames != null) {
      _result.citizenGames = citizenGames;
    }
    if (donGames != null) {
      _result.donGames = donGames;
    }
    if (sheriffGames != null) {
      _result.sheriffGames = sheriffGames;
    }
    if (mafiaGames != null) {
      _result.mafiaGames = mafiaGames;
    }
    if (mafiaWins != null) {
      _result.mafiaWins = mafiaWins;
    }
    if (citizenWins != null) {
      _result.citizenWins = citizenWins;
    }
    if (citizenAddScore != null) {
      _result.citizenAddScore = citizenAddScore;
    }
    if (mafiaAddScore != null) {
      _result.mafiaAddScore = mafiaAddScore;
    }
    if (donAddScore != null) {
      _result.donAddScore = donAddScore;
    }
    if (sheriffAddScore != null) {
      _result.sheriffAddScore = sheriffAddScore;
    }
    if (citizenScore != null) {
      _result.citizenScore = citizenScore;
    }
    if (mafiaScore != null) {
      _result.mafiaScore = mafiaScore;
    }
    if (donScore != null) {
      _result.donScore = donScore;
    }
    if (sheriffScore != null) {
      _result.sheriffScore = sheriffScore;
    }
    return _result;
  }
  factory ClubRatingRow.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClubRatingRow.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClubRatingRow clone() => ClubRatingRow()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClubRatingRow copyWith(void Function(ClubRatingRow) updates) => super.copyWith((message) => updates(message as ClubRatingRow)) as ClubRatingRow; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClubRatingRow create() => ClubRatingRow._();
  ClubRatingRow createEmptyInstance() => create();
  static $pb.PbList<ClubRatingRow> createRepeated() => $pb.PbList<ClubRatingRow>();
  @$core.pragma('dart2js:noInline')
  static ClubRatingRow getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClubRatingRow>(create);
  static ClubRatingRow? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get nickname => $_getSZ(0);
  @$pb.TagNumber(1)
  set nickname($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNickname() => $_has(0);
  @$pb.TagNumber(1)
  void clearNickname() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get score => $_getN(1);
  @$pb.TagNumber(2)
  set score($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearScore() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get addScore => $_getN(2);
  @$pb.TagNumber(3)
  set addScore($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAddScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearAddScore() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get firstDie => $_getIZ(3);
  @$pb.TagNumber(4)
  set firstDie($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFirstDie() => $_has(3);
  @$pb.TagNumber(4)
  void clearFirstDie() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get donWins => $_getIZ(4);
  @$pb.TagNumber(5)
  set donWins($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDonWins() => $_has(4);
  @$pb.TagNumber(5)
  void clearDonWins() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get sheriffWins => $_getIZ(5);
  @$pb.TagNumber(6)
  set sheriffWins($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSheriffWins() => $_has(5);
  @$pb.TagNumber(6)
  void clearSheriffWins() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<ClubRatingRow_GameItem> get item => $_getList(6);

  @$pb.TagNumber(8)
  $core.int get wins => $_getIZ(7);
  @$pb.TagNumber(8)
  set wins($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasWins() => $_has(7);
  @$pb.TagNumber(8)
  void clearWins() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get ci => $_getIZ(8);
  @$pb.TagNumber(9)
  set ci($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCi() => $_has(8);
  @$pb.TagNumber(9)
  void clearCi() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get totalGames => $_getIZ(9);
  @$pb.TagNumber(10)
  set totalGames($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTotalGames() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalGames() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get citizenGames => $_getIZ(10);
  @$pb.TagNumber(11)
  set citizenGames($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCitizenGames() => $_has(10);
  @$pb.TagNumber(11)
  void clearCitizenGames() => clearField(11);

  @$pb.TagNumber(12)
  $core.int get donGames => $_getIZ(11);
  @$pb.TagNumber(12)
  set donGames($core.int v) { $_setSignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasDonGames() => $_has(11);
  @$pb.TagNumber(12)
  void clearDonGames() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get sheriffGames => $_getIZ(12);
  @$pb.TagNumber(13)
  set sheriffGames($core.int v) { $_setSignedInt32(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasSheriffGames() => $_has(12);
  @$pb.TagNumber(13)
  void clearSheriffGames() => clearField(13);

  @$pb.TagNumber(14)
  $core.int get mafiaGames => $_getIZ(13);
  @$pb.TagNumber(14)
  set mafiaGames($core.int v) { $_setSignedInt32(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasMafiaGames() => $_has(13);
  @$pb.TagNumber(14)
  void clearMafiaGames() => clearField(14);

  @$pb.TagNumber(15)
  $core.int get mafiaWins => $_getIZ(14);
  @$pb.TagNumber(15)
  set mafiaWins($core.int v) { $_setSignedInt32(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasMafiaWins() => $_has(14);
  @$pb.TagNumber(15)
  void clearMafiaWins() => clearField(15);

  @$pb.TagNumber(16)
  $core.int get citizenWins => $_getIZ(15);
  @$pb.TagNumber(16)
  set citizenWins($core.int v) { $_setSignedInt32(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasCitizenWins() => $_has(15);
  @$pb.TagNumber(16)
  void clearCitizenWins() => clearField(16);

  @$pb.TagNumber(17)
  $core.double get citizenAddScore => $_getN(16);
  @$pb.TagNumber(17)
  set citizenAddScore($core.double v) { $_setDouble(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasCitizenAddScore() => $_has(16);
  @$pb.TagNumber(17)
  void clearCitizenAddScore() => clearField(17);

  @$pb.TagNumber(18)
  $core.double get mafiaAddScore => $_getN(17);
  @$pb.TagNumber(18)
  set mafiaAddScore($core.double v) { $_setDouble(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasMafiaAddScore() => $_has(17);
  @$pb.TagNumber(18)
  void clearMafiaAddScore() => clearField(18);

  @$pb.TagNumber(19)
  $core.double get donAddScore => $_getN(18);
  @$pb.TagNumber(19)
  set donAddScore($core.double v) { $_setDouble(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasDonAddScore() => $_has(18);
  @$pb.TagNumber(19)
  void clearDonAddScore() => clearField(19);

  @$pb.TagNumber(20)
  $core.double get sheriffAddScore => $_getN(19);
  @$pb.TagNumber(20)
  set sheriffAddScore($core.double v) { $_setDouble(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasSheriffAddScore() => $_has(19);
  @$pb.TagNumber(20)
  void clearSheriffAddScore() => clearField(20);

  @$pb.TagNumber(21)
  $core.double get citizenScore => $_getN(20);
  @$pb.TagNumber(21)
  set citizenScore($core.double v) { $_setDouble(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasCitizenScore() => $_has(20);
  @$pb.TagNumber(21)
  void clearCitizenScore() => clearField(21);

  @$pb.TagNumber(22)
  $core.double get mafiaScore => $_getN(21);
  @$pb.TagNumber(22)
  set mafiaScore($core.double v) { $_setDouble(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasMafiaScore() => $_has(21);
  @$pb.TagNumber(22)
  void clearMafiaScore() => clearField(22);

  @$pb.TagNumber(23)
  $core.double get donScore => $_getN(22);
  @$pb.TagNumber(23)
  set donScore($core.double v) { $_setDouble(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasDonScore() => $_has(22);
  @$pb.TagNumber(23)
  void clearDonScore() => clearField(23);

  @$pb.TagNumber(24)
  $core.double get sheriffScore => $_getN(23);
  @$pb.TagNumber(24)
  set sheriffScore($core.double v) { $_setDouble(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasSheriffScore() => $_has(23);
  @$pb.TagNumber(24)
  void clearSheriffScore() => clearField(24);
}

class AddGameEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddGameEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gameId', $pb.PbFieldType.O3, protoName: 'gameId')
    ..hasRequiredFields = false
  ;

  AddGameEventOut._() : super();
  factory AddGameEventOut({
    $core.int? gameId,
  }) {
    final _result = create();
    if (gameId != null) {
      _result.gameId = gameId;
    }
    return _result;
  }
  factory AddGameEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddGameEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddGameEventOut clone() => AddGameEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddGameEventOut copyWith(void Function(AddGameEventOut) updates) => super.copyWith((message) => updates(message as AddGameEventOut)) as AddGameEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddGameEventOut create() => AddGameEventOut._();
  AddGameEventOut createEmptyInstance() => create();
  static $pb.PbList<AddGameEventOut> createRepeated() => $pb.PbList<AddGameEventOut>();
  @$core.pragma('dart2js:noInline')
  static AddGameEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddGameEventOut>(create);
  static AddGameEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get gameId => $_getIZ(0);
  @$pb.TagNumber(1)
  set gameId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => clearField(1);
}

class CiScheme extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CiScheme', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  CiScheme._() : super();
  factory CiScheme({
    $core.int? id,
    $core.String? name,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory CiScheme.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CiScheme.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CiScheme clone() => CiScheme()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CiScheme copyWith(void Function(CiScheme) updates) => super.copyWith((message) => updates(message as CiScheme)) as CiScheme; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CiScheme create() => CiScheme._();
  CiScheme createEmptyInstance() => create();
  static $pb.PbList<CiScheme> createRepeated() => $pb.PbList<CiScheme>();
  @$core.pragma('dart2js:noInline')
  static CiScheme getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CiScheme>(create);
  static CiScheme? _defaultInstance;

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
}

class AvailableCiEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AvailableCiEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..pc<CiScheme>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'schemes', $pb.PbFieldType.PM, subBuilder: CiScheme.create)
    ..hasRequiredFields = false
  ;

  AvailableCiEventOut._() : super();
  factory AvailableCiEventOut({
    $core.Iterable<CiScheme>? schemes,
  }) {
    final _result = create();
    if (schemes != null) {
      _result.schemes.addAll(schemes);
    }
    return _result;
  }
  factory AvailableCiEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AvailableCiEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AvailableCiEventOut clone() => AvailableCiEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AvailableCiEventOut copyWith(void Function(AvailableCiEventOut) updates) => super.copyWith((message) => updates(message as AvailableCiEventOut)) as AvailableCiEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AvailableCiEventOut create() => AvailableCiEventOut._();
  AvailableCiEventOut createEmptyInstance() => create();
  static $pb.PbList<AvailableCiEventOut> createRepeated() => $pb.PbList<AvailableCiEventOut>();
  @$core.pragma('dart2js:noInline')
  static AvailableCiEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AvailableCiEventOut>(create);
  static AvailableCiEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CiScheme> get schemes => $_getList(0);
}

class SetFinalPlayersEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetFinalPlayersEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..p<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.K3)
    ..hasRequiredFields = false
  ;

  SetFinalPlayersEvent._() : super();
  factory SetFinalPlayersEvent({
    $core.Iterable<$core.int>? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id.addAll(id);
    }
    return _result;
  }
  factory SetFinalPlayersEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetFinalPlayersEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetFinalPlayersEvent clone() => SetFinalPlayersEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetFinalPlayersEvent copyWith(void Function(SetFinalPlayersEvent) updates) => super.copyWith((message) => updates(message as SetFinalPlayersEvent)) as SetFinalPlayersEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetFinalPlayersEvent create() => SetFinalPlayersEvent._();
  SetFinalPlayersEvent createEmptyInstance() => create();
  static $pb.PbList<SetFinalPlayersEvent> createRepeated() => $pb.PbList<SetFinalPlayersEvent>();
  @$core.pragma('dart2js:noInline')
  static SetFinalPlayersEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetFinalPlayersEvent>(create);
  static SetFinalPlayersEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get id => $_getList(0);
}

class ClubGameResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClubGameResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..p<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addScore', $pb.PbFieldType.K3, protoName: 'addScore')
    ..p<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'players', $pb.PbFieldType.K3)
    ..e<GameWin>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'win', $pb.PbFieldType.OE, defaultOrMaker: GameWin.city, valueOf: GameWin.valueOf, enumValues: GameWin.values)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstDie', $pb.PbFieldType.O3, protoName: 'firstDie')
    ..e<BestMove>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bestMove', $pb.PbFieldType.OE, protoName: 'bestMove', defaultOrMaker: BestMove.miss, valueOf: BestMove.valueOf, enumValues: BestMove.values)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'date')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referee', $pb.PbFieldType.O3)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mafia1', $pb.PbFieldType.O3)
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mafia2', $pb.PbFieldType.O3)
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'don', $pb.PbFieldType.O3)
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sheriff', $pb.PbFieldType.O3)
    ..a<$core.int>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ciId', $pb.PbFieldType.O3, protoName: 'ciId')
    ..hasRequiredFields = false
  ;

  ClubGameResult._() : super();
  factory ClubGameResult({
    $core.Iterable<$core.int>? addScore,
    $core.Iterable<$core.int>? players,
    GameWin? win,
    $core.int? firstDie,
    BestMove? bestMove,
    $core.String? date,
    $core.int? referee,
    $core.int? mafia1,
    $core.int? mafia2,
    $core.int? don,
    $core.int? sheriff,
    $core.int? ciId,
  }) {
    final _result = create();
    if (addScore != null) {
      _result.addScore.addAll(addScore);
    }
    if (players != null) {
      _result.players.addAll(players);
    }
    if (win != null) {
      _result.win = win;
    }
    if (firstDie != null) {
      _result.firstDie = firstDie;
    }
    if (bestMove != null) {
      _result.bestMove = bestMove;
    }
    if (date != null) {
      _result.date = date;
    }
    if (referee != null) {
      _result.referee = referee;
    }
    if (mafia1 != null) {
      _result.mafia1 = mafia1;
    }
    if (mafia2 != null) {
      _result.mafia2 = mafia2;
    }
    if (don != null) {
      _result.don = don;
    }
    if (sheriff != null) {
      _result.sheriff = sheriff;
    }
    if (ciId != null) {
      _result.ciId = ciId;
    }
    return _result;
  }
  factory ClubGameResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClubGameResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClubGameResult clone() => ClubGameResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClubGameResult copyWith(void Function(ClubGameResult) updates) => super.copyWith((message) => updates(message as ClubGameResult)) as ClubGameResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClubGameResult create() => ClubGameResult._();
  ClubGameResult createEmptyInstance() => create();
  static $pb.PbList<ClubGameResult> createRepeated() => $pb.PbList<ClubGameResult>();
  @$core.pragma('dart2js:noInline')
  static ClubGameResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClubGameResult>(create);
  static ClubGameResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get addScore => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get players => $_getList(1);

  @$pb.TagNumber(3)
  GameWin get win => $_getN(2);
  @$pb.TagNumber(3)
  set win(GameWin v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasWin() => $_has(2);
  @$pb.TagNumber(3)
  void clearWin() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get firstDie => $_getIZ(3);
  @$pb.TagNumber(4)
  set firstDie($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFirstDie() => $_has(3);
  @$pb.TagNumber(4)
  void clearFirstDie() => clearField(4);

  @$pb.TagNumber(5)
  BestMove get bestMove => $_getN(4);
  @$pb.TagNumber(5)
  set bestMove(BestMove v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasBestMove() => $_has(4);
  @$pb.TagNumber(5)
  void clearBestMove() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get date => $_getSZ(5);
  @$pb.TagNumber(6)
  set date($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearDate() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get referee => $_getIZ(6);
  @$pb.TagNumber(7)
  set referee($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasReferee() => $_has(6);
  @$pb.TagNumber(7)
  void clearReferee() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get mafia1 => $_getIZ(7);
  @$pb.TagNumber(8)
  set mafia1($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMafia1() => $_has(7);
  @$pb.TagNumber(8)
  void clearMafia1() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get mafia2 => $_getIZ(8);
  @$pb.TagNumber(9)
  set mafia2($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMafia2() => $_has(8);
  @$pb.TagNumber(9)
  void clearMafia2() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get don => $_getIZ(9);
  @$pb.TagNumber(10)
  set don($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasDon() => $_has(9);
  @$pb.TagNumber(10)
  void clearDon() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get sheriff => $_getIZ(10);
  @$pb.TagNumber(11)
  set sheriff($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSheriff() => $_has(10);
  @$pb.TagNumber(11)
  void clearSheriff() => clearField(11);

  @$pb.TagNumber(12)
  $core.int get ciId => $_getIZ(11);
  @$pb.TagNumber(12)
  set ciId($core.int v) { $_setSignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCiId() => $_has(11);
  @$pb.TagNumber(12)
  void clearCiId() => clearField(12);
}

class ClubsEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClubsEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..pc<Club>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'club', $pb.PbFieldType.PM, subBuilder: Club.create)
    ..hasRequiredFields = false
  ;

  ClubsEventOut._() : super();
  factory ClubsEventOut({
    $core.Iterable<Club>? club,
  }) {
    final _result = create();
    if (club != null) {
      _result.club.addAll(club);
    }
    return _result;
  }
  factory ClubsEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClubsEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClubsEventOut clone() => ClubsEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClubsEventOut copyWith(void Function(ClubsEventOut) updates) => super.copyWith((message) => updates(message as ClubsEventOut)) as ClubsEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClubsEventOut create() => ClubsEventOut._();
  ClubsEventOut createEmptyInstance() => create();
  static $pb.PbList<ClubsEventOut> createRepeated() => $pb.PbList<ClubsEventOut>();
  @$core.pragma('dart2js:noInline')
  static ClubsEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClubsEventOut>(create);
  static ClubsEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Club> get club => $_getList(0);
}

class SeatingContent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SeatingContent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..pc<PlayerRole>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'roles', $pb.PbFieldType.KE, valueOf: PlayerRole.valueOf, enumValues: PlayerRole.values, defaultEnumValue: PlayerRole.citizen)
    ..pc<PlayerStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.KE, valueOf: PlayerStatus.valueOf, enumValues: PlayerStatus.values, defaultEnumValue: PlayerStatus.alive)
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'images')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'names')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'game', $pb.PbFieldType.O3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalGames', $pb.PbFieldType.O3, protoName: 'totalGames')
    ..hasRequiredFields = false
  ;

  SeatingContent._() : super();
  factory SeatingContent({
    $core.Iterable<PlayerRole>? roles,
    $core.Iterable<PlayerStatus>? status,
    $core.Iterable<$core.String>? images,
    $core.Iterable<$core.String>? names,
    $core.int? game,
    $core.int? totalGames,
  }) {
    final _result = create();
    if (roles != null) {
      _result.roles.addAll(roles);
    }
    if (status != null) {
      _result.status.addAll(status);
    }
    if (images != null) {
      _result.images.addAll(images);
    }
    if (names != null) {
      _result.names.addAll(names);
    }
    if (game != null) {
      _result.game = game;
    }
    if (totalGames != null) {
      _result.totalGames = totalGames;
    }
    return _result;
  }
  factory SeatingContent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SeatingContent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SeatingContent clone() => SeatingContent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SeatingContent copyWith(void Function(SeatingContent) updates) => super.copyWith((message) => updates(message as SeatingContent)) as SeatingContent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SeatingContent create() => SeatingContent._();
  SeatingContent createEmptyInstance() => create();
  static $pb.PbList<SeatingContent> createRepeated() => $pb.PbList<SeatingContent>();
  @$core.pragma('dart2js:noInline')
  static SeatingContent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SeatingContent>(create);
  static SeatingContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PlayerRole> get roles => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<PlayerStatus> get status => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.String> get images => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$core.String> get names => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get game => $_getIZ(4);
  @$pb.TagNumber(5)
  set game($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGame() => $_has(4);
  @$pb.TagNumber(5)
  void clearGame() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get totalGames => $_getIZ(5);
  @$pb.TagNumber(6)
  set totalGames($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalGames() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalGames() => clearField(6);
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
    ..e<LoginByTokenEventOut_Error>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: LoginByTokenEventOut_Error.noError, valueOf: LoginByTokenEventOut_Error.valueOf, enumValues: LoginByTokenEventOut_Error.values)
    ..hasRequiredFields = false
  ;

  LoginByTokenEventOut._() : super();
  factory LoginByTokenEventOut({
    $core.String? token,
    $core.String? recoveryToken,
    LoginByTokenEventOut_Error? error,
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

  @$pb.TagNumber(3)
  LoginByTokenEventOut_Error get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(LoginByTokenEventOut_Error v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => clearField(3);
}

class TournamentDescription extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TournamentDescription', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gomafiaUrl', protoName: 'gomafiaUrl')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vkGroupUrl', protoName: 'vkGroupUrl')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vkOwnerUrl', protoName: 'vkOwnerUrl')
    ..hasRequiredFields = false
  ;

  TournamentDescription._() : super();
  factory TournamentDescription({
    $core.String? gomafiaUrl,
    $core.String? vkGroupUrl,
    $core.String? vkOwnerUrl,
  }) {
    final _result = create();
    if (gomafiaUrl != null) {
      _result.gomafiaUrl = gomafiaUrl;
    }
    if (vkGroupUrl != null) {
      _result.vkGroupUrl = vkGroupUrl;
    }
    if (vkOwnerUrl != null) {
      _result.vkOwnerUrl = vkOwnerUrl;
    }
    return _result;
  }
  factory TournamentDescription.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TournamentDescription.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TournamentDescription clone() => TournamentDescription()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TournamentDescription copyWith(void Function(TournamentDescription) updates) => super.copyWith((message) => updates(message as TournamentDescription)) as TournamentDescription; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TournamentDescription create() => TournamentDescription._();
  TournamentDescription createEmptyInstance() => create();
  static $pb.PbList<TournamentDescription> createRepeated() => $pb.PbList<TournamentDescription>();
  @$core.pragma('dart2js:noInline')
  static TournamentDescription getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TournamentDescription>(create);
  static TournamentDescription? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get gomafiaUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set gomafiaUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGomafiaUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearGomafiaUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get vkGroupUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set vkGroupUrl($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVkGroupUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearVkGroupUrl() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get vkOwnerUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set vkOwnerUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVkOwnerUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearVkOwnerUrl() => clearField(3);
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
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SignUpEventOut._() : super();
  factory SignUpEventOut({
    $core.String? token,
    $core.String? recoveryToken,
    SignUpEventOut_Error? error,
    $core.int? id,
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
    if (id != null) {
      _result.id = id;
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

  @$pb.TagNumber(4)
  $core.int get id => $_getIZ(3);
  @$pb.TagNumber(4)
  set id($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasId() => $_has(3);
  @$pb.TagNumber(4)
  void clearId() => clearField(4);
}

class EmailVerificationEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EmailVerificationEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..hasRequiredFields = false
  ;

  EmailVerificationEvent._() : super();
  factory EmailVerificationEvent({
    $core.int? id,
    $core.String? token,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (token != null) {
      _result.token = token;
    }
    return _result;
  }
  factory EmailVerificationEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmailVerificationEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmailVerificationEvent clone() => EmailVerificationEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmailVerificationEvent copyWith(void Function(EmailVerificationEvent) updates) => super.copyWith((message) => updates(message as EmailVerificationEvent)) as EmailVerificationEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EmailVerificationEvent create() => EmailVerificationEvent._();
  EmailVerificationEvent createEmptyInstance() => create();
  static $pb.PbList<EmailVerificationEvent> createRepeated() => $pb.PbList<EmailVerificationEvent>();
  @$core.pragma('dart2js:noInline')
  static EmailVerificationEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmailVerificationEvent>(create);
  static EmailVerificationEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(2)
  set token($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearToken() => clearField(2);
}

class CreateTournamentEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateTournamentEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateStart', protoName: 'dateStart')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateEnd', protoName: 'dateEnd')
    ..hasRequiredFields = false
  ;

  CreateTournamentEvent._() : super();
  factory CreateTournamentEvent({
    $core.String? name,
    $core.String? dateStart,
    $core.String? dateEnd,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (dateStart != null) {
      _result.dateStart = dateStart;
    }
    if (dateEnd != null) {
      _result.dateEnd = dateEnd;
    }
    return _result;
  }
  factory CreateTournamentEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTournamentEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTournamentEvent clone() => CreateTournamentEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTournamentEvent copyWith(void Function(CreateTournamentEvent) updates) => super.copyWith((message) => updates(message as CreateTournamentEvent)) as CreateTournamentEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateTournamentEvent create() => CreateTournamentEvent._();
  CreateTournamentEvent createEmptyInstance() => create();
  static $pb.PbList<CreateTournamentEvent> createRepeated() => $pb.PbList<CreateTournamentEvent>();
  @$core.pragma('dart2js:noInline')
  static CreateTournamentEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTournamentEvent>(create);
  static CreateTournamentEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get dateStart => $_getSZ(1);
  @$pb.TagNumber(2)
  set dateStart($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDateStart() => $_has(1);
  @$pb.TagNumber(2)
  void clearDateStart() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get dateEnd => $_getSZ(2);
  @$pb.TagNumber(3)
  set dateEnd($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDateEnd() => $_has(2);
  @$pb.TagNumber(3)
  void clearDateEnd() => clearField(3);
}

class CreateTournamentEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateTournamentEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  CreateTournamentEventOut._() : super();
  factory CreateTournamentEventOut({
    $core.int? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory CreateTournamentEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTournamentEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTournamentEventOut clone() => CreateTournamentEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTournamentEventOut copyWith(void Function(CreateTournamentEventOut) updates) => super.copyWith((message) => updates(message as CreateTournamentEventOut)) as CreateTournamentEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateTournamentEventOut create() => CreateTournamentEventOut._();
  CreateTournamentEventOut createEmptyInstance() => create();
  static $pb.PbList<CreateTournamentEventOut> createRepeated() => $pb.PbList<CreateTournamentEventOut>();
  @$core.pragma('dart2js:noInline')
  static CreateTournamentEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTournamentEventOut>(create);
  static CreateTournamentEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class AddPlayerEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddPlayerEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOM<Player>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'player', subBuilder: Player.create)
    ..hasRequiredFields = false
  ;

  AddPlayerEvent._() : super();
  factory AddPlayerEvent({
    Player? player,
  }) {
    final _result = create();
    if (player != null) {
      _result.player = player;
    }
    return _result;
  }
  factory AddPlayerEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddPlayerEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddPlayerEvent clone() => AddPlayerEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddPlayerEvent copyWith(void Function(AddPlayerEvent) updates) => super.copyWith((message) => updates(message as AddPlayerEvent)) as AddPlayerEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddPlayerEvent create() => AddPlayerEvent._();
  AddPlayerEvent createEmptyInstance() => create();
  static $pb.PbList<AddPlayerEvent> createRepeated() => $pb.PbList<AddPlayerEvent>();
  @$core.pragma('dart2js:noInline')
  static AddPlayerEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddPlayerEvent>(create);
  static AddPlayerEvent? _defaultInstance;

  @$pb.TagNumber(1)
  Player get player => $_getN(0);
  @$pb.TagNumber(1)
  set player(Player v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer() => clearField(1);
  @$pb.TagNumber(1)
  Player ensurePlayer() => $_ensure(0);
}

class CannotMeetEditionEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CannotMeetEditionEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOM<Player>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'player1', subBuilder: Player.create)
    ..aOM<Player>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'player2', subBuilder: Player.create)
    ..hasRequiredFields = false
  ;

  CannotMeetEditionEvent._() : super();
  factory CannotMeetEditionEvent({
    Player? player1,
    Player? player2,
  }) {
    final _result = create();
    if (player1 != null) {
      _result.player1 = player1;
    }
    if (player2 != null) {
      _result.player2 = player2;
    }
    return _result;
  }
  factory CannotMeetEditionEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CannotMeetEditionEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CannotMeetEditionEvent clone() => CannotMeetEditionEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CannotMeetEditionEvent copyWith(void Function(CannotMeetEditionEvent) updates) => super.copyWith((message) => updates(message as CannotMeetEditionEvent)) as CannotMeetEditionEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CannotMeetEditionEvent create() => CannotMeetEditionEvent._();
  CannotMeetEditionEvent createEmptyInstance() => create();
  static $pb.PbList<CannotMeetEditionEvent> createRepeated() => $pb.PbList<CannotMeetEditionEvent>();
  @$core.pragma('dart2js:noInline')
  static CannotMeetEditionEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CannotMeetEditionEvent>(create);
  static CannotMeetEditionEvent? _defaultInstance;

  @$pb.TagNumber(1)
  Player get player1 => $_getN(0);
  @$pb.TagNumber(1)
  set player1(Player v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayer1() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer1() => clearField(1);
  @$pb.TagNumber(1)
  Player ensurePlayer1() => $_ensure(0);

  @$pb.TagNumber(2)
  Player get player2 => $_getN(1);
  @$pb.TagNumber(2)
  set player2(Player v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlayer2() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlayer2() => clearField(2);
  @$pb.TagNumber(2)
  Player ensurePlayer2() => $_ensure(1);
}

class CannotMeetEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CannotMeetEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..pc<CannotMeetEditionEvent>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pairs', $pb.PbFieldType.PM, subBuilder: CannotMeetEditionEvent.create)
    ..hasRequiredFields = false
  ;

  CannotMeetEventOut._() : super();
  factory CannotMeetEventOut({
    $core.Iterable<CannotMeetEditionEvent>? pairs,
  }) {
    final _result = create();
    if (pairs != null) {
      _result.pairs.addAll(pairs);
    }
    return _result;
  }
  factory CannotMeetEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CannotMeetEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CannotMeetEventOut clone() => CannotMeetEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CannotMeetEventOut copyWith(void Function(CannotMeetEventOut) updates) => super.copyWith((message) => updates(message as CannotMeetEventOut)) as CannotMeetEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CannotMeetEventOut create() => CannotMeetEventOut._();
  CannotMeetEventOut createEmptyInstance() => create();
  static $pb.PbList<CannotMeetEventOut> createRepeated() => $pb.PbList<CannotMeetEventOut>();
  @$core.pragma('dart2js:noInline')
  static CannotMeetEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CannotMeetEventOut>(create);
  static CannotMeetEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CannotMeetEditionEvent> get pairs => $_getList(0);
}

class GetAvailablePlayerEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAvailablePlayerEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..pc<Player>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'players', $pb.PbFieldType.PM, subBuilder: Player.create)
    ..hasRequiredFields = false
  ;

  GetAvailablePlayerEventOut._() : super();
  factory GetAvailablePlayerEventOut({
    $core.Iterable<Player>? players,
  }) {
    final _result = create();
    if (players != null) {
      _result.players.addAll(players);
    }
    return _result;
  }
  factory GetAvailablePlayerEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAvailablePlayerEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAvailablePlayerEventOut clone() => GetAvailablePlayerEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAvailablePlayerEventOut copyWith(void Function(GetAvailablePlayerEventOut) updates) => super.copyWith((message) => updates(message as GetAvailablePlayerEventOut)) as GetAvailablePlayerEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAvailablePlayerEventOut create() => GetAvailablePlayerEventOut._();
  GetAvailablePlayerEventOut createEmptyInstance() => create();
  static $pb.PbList<GetAvailablePlayerEventOut> createRepeated() => $pb.PbList<GetAvailablePlayerEventOut>();
  @$core.pragma('dart2js:noInline')
  static GetAvailablePlayerEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAvailablePlayerEventOut>(create);
  static GetAvailablePlayerEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Player> get players => $_getList(0);
}

class TournamentSettings extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TournamentSettings', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'defaultGamesCount', $pb.PbFieldType.O3, protoName: 'defaultGamesCount')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'swissGamesCount', $pb.PbFieldType.O3, protoName: 'swissGamesCount')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'finalGamesCount', $pb.PbFieldType.O3, protoName: 'finalGamesCount')
    ..hasRequiredFields = false
  ;

  TournamentSettings._() : super();
  factory TournamentSettings({
    $core.int? defaultGamesCount,
    $core.int? swissGamesCount,
    $core.int? finalGamesCount,
  }) {
    final _result = create();
    if (defaultGamesCount != null) {
      _result.defaultGamesCount = defaultGamesCount;
    }
    if (swissGamesCount != null) {
      _result.swissGamesCount = swissGamesCount;
    }
    if (finalGamesCount != null) {
      _result.finalGamesCount = finalGamesCount;
    }
    return _result;
  }
  factory TournamentSettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TournamentSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TournamentSettings clone() => TournamentSettings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TournamentSettings copyWith(void Function(TournamentSettings) updates) => super.copyWith((message) => updates(message as TournamentSettings)) as TournamentSettings; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TournamentSettings create() => TournamentSettings._();
  TournamentSettings createEmptyInstance() => create();
  static $pb.PbList<TournamentSettings> createRepeated() => $pb.PbList<TournamentSettings>();
  @$core.pragma('dart2js:noInline')
  static TournamentSettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TournamentSettings>(create);
  static TournamentSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get defaultGamesCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set defaultGamesCount($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDefaultGamesCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearDefaultGamesCount() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get swissGamesCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set swissGamesCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSwissGamesCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearSwissGamesCount() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get finalGamesCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set finalGamesCount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFinalGamesCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearFinalGamesCount() => clearField(3);
}

class Profile extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Profile', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName', protoName: 'firstName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'secondName', protoName: 'secondName')
    ..hasRequiredFields = false
  ;

  Profile._() : super();
  factory Profile({
    $core.String? firstName,
    $core.String? secondName,
  }) {
    final _result = create();
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (secondName != null) {
      _result.secondName = secondName;
    }
    return _result;
  }
  factory Profile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Profile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Profile clone() => Profile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Profile copyWith(void Function(Profile) updates) => super.copyWith((message) => updates(message as Profile)) as Profile; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Profile create() => Profile._();
  Profile createEmptyInstance() => create();
  static $pb.PbList<Profile> createRepeated() => $pb.PbList<Profile>();
  @$core.pragma('dart2js:noInline')
  static Profile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Profile>(create);
  static Profile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firstName => $_getSZ(0);
  @$pb.TagNumber(1)
  set firstName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFirstName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get secondName => $_getSZ(1);
  @$pb.TagNumber(2)
  set secondName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSecondName() => $_has(1);
  @$pb.TagNumber(2)
  void clearSecondName() => clearField(2);
}

class CreatePlayerEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreatePlayerEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  CreatePlayerEventOut._() : super();
  factory CreatePlayerEventOut({
    $core.int? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory CreatePlayerEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePlayerEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePlayerEventOut clone() => CreatePlayerEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePlayerEventOut copyWith(void Function(CreatePlayerEventOut) updates) => super.copyWith((message) => updates(message as CreatePlayerEventOut)) as CreatePlayerEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreatePlayerEventOut create() => CreatePlayerEventOut._();
  CreatePlayerEventOut createEmptyInstance() => create();
  static $pb.PbList<CreatePlayerEventOut> createRepeated() => $pb.PbList<CreatePlayerEventOut>();
  @$core.pragma('dart2js:noInline')
  static CreatePlayerEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePlayerEventOut>(create);
  static CreatePlayerEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class CreatePlayerEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreatePlayerEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOM<Player>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'player', subBuilder: Player.create)
    ..hasRequiredFields = false
  ;

  CreatePlayerEvent._() : super();
  factory CreatePlayerEvent({
    Player? player,
  }) {
    final _result = create();
    if (player != null) {
      _result.player = player;
    }
    return _result;
  }
  factory CreatePlayerEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePlayerEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePlayerEvent clone() => CreatePlayerEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePlayerEvent copyWith(void Function(CreatePlayerEvent) updates) => super.copyWith((message) => updates(message as CreatePlayerEvent)) as CreatePlayerEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreatePlayerEvent create() => CreatePlayerEvent._();
  CreatePlayerEvent createEmptyInstance() => create();
  static $pb.PbList<CreatePlayerEvent> createRepeated() => $pb.PbList<CreatePlayerEvent>();
  @$core.pragma('dart2js:noInline')
  static CreatePlayerEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePlayerEvent>(create);
  static CreatePlayerEvent? _defaultInstance;

  @$pb.TagNumber(1)
  Player get player => $_getN(0);
  @$pb.TagNumber(1)
  set player(Player v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer() => clearField(1);
  @$pb.TagNumber(1)
  Player ensurePlayer() => $_ensure(0);
}

class Player extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Player', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nickname')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fsmNickname', protoName: 'fsmNickname')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mafbankNickname', protoName: 'mafbankNickname')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'image')
    ..hasRequiredFields = false
  ;

  Player._() : super();
  factory Player({
    $core.int? id,
    $core.String? nickname,
    $core.String? fsmNickname,
    $core.String? mafbankNickname,
    $core.String? image,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (nickname != null) {
      _result.nickname = nickname;
    }
    if (fsmNickname != null) {
      _result.fsmNickname = fsmNickname;
    }
    if (mafbankNickname != null) {
      _result.mafbankNickname = mafbankNickname;
    }
    if (image != null) {
      _result.image = image;
    }
    return _result;
  }
  factory Player.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Player.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Player clone() => Player()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Player copyWith(void Function(Player) updates) => super.copyWith((message) => updates(message as Player)) as Player; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Player create() => Player._();
  Player createEmptyInstance() => create();
  static $pb.PbList<Player> createRepeated() => $pb.PbList<Player>();
  @$core.pragma('dart2js:noInline')
  static Player getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Player>(create);
  static Player? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get nickname => $_getSZ(1);
  @$pb.TagNumber(2)
  set nickname($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNickname() => $_has(1);
  @$pb.TagNumber(2)
  void clearNickname() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get fsmNickname => $_getSZ(2);
  @$pb.TagNumber(3)
  set fsmNickname($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFsmNickname() => $_has(2);
  @$pb.TagNumber(3)
  void clearFsmNickname() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get mafbankNickname => $_getSZ(3);
  @$pb.TagNumber(4)
  set mafbankNickname($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMafbankNickname() => $_has(3);
  @$pb.TagNumber(4)
  void clearMafbankNickname() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get image => $_getSZ(4);
  @$pb.TagNumber(5)
  set image($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasImage() => $_has(4);
  @$pb.TagNumber(5)
  void clearImage() => clearField(5);
}

class EmailVerificationEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EmailVerificationEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..e<EmailVerificationEventOut_Status>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: EmailVerificationEventOut_Status.success, valueOf: EmailVerificationEventOut_Status.valueOf, enumValues: EmailVerificationEventOut_Status.values)
    ..hasRequiredFields = false
  ;

  EmailVerificationEventOut._() : super();
  factory EmailVerificationEventOut({
    EmailVerificationEventOut_Status? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory EmailVerificationEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmailVerificationEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmailVerificationEventOut clone() => EmailVerificationEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmailVerificationEventOut copyWith(void Function(EmailVerificationEventOut) updates) => super.copyWith((message) => updates(message as EmailVerificationEventOut)) as EmailVerificationEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EmailVerificationEventOut create() => EmailVerificationEventOut._();
  EmailVerificationEventOut createEmptyInstance() => create();
  static $pb.PbList<EmailVerificationEventOut> createRepeated() => $pb.PbList<EmailVerificationEventOut>();
  @$core.pragma('dart2js:noInline')
  static EmailVerificationEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmailVerificationEventOut>(create);
  static EmailVerificationEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  EmailVerificationEventOut_Status get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(EmailVerificationEventOut_Status v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
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

class GetTournamentsEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTournamentsEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..pc<Tournament>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tournaments', $pb.PbFieldType.PM, subBuilder: Tournament.create)
    ..hasRequiredFields = false
  ;

  GetTournamentsEventOut._() : super();
  factory GetTournamentsEventOut({
    $core.Iterable<Tournament>? tournaments,
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
  $core.List<Tournament> get tournaments => $_getList(0);
}

class Tournament extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tournament', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<Tournament_Status>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: Tournament_Status.waitForBilling, valueOf: Tournament_Status.valueOf, enumValues: Tournament_Status.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateStart', protoName: 'dateStart')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateEnd', protoName: 'dateEnd')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gamesCount', $pb.PbFieldType.O3, protoName: 'gamesCount')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billedPlayers', $pb.PbFieldType.O3, protoName: 'billedPlayers')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billedTranslation', protoName: 'billedTranslation')
    ..hasRequiredFields = false
  ;

  Tournament._() : super();
  factory Tournament({
    $core.int? id,
    $core.String? name,
    Tournament_Status? status,
    $core.String? dateStart,
    $core.String? dateEnd,
    $core.int? gamesCount,
    $core.int? billedPlayers,
    $core.bool? billedTranslation,
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
    if (gamesCount != null) {
      _result.gamesCount = gamesCount;
    }
    if (billedPlayers != null) {
      _result.billedPlayers = billedPlayers;
    }
    if (billedTranslation != null) {
      _result.billedTranslation = billedTranslation;
    }
    return _result;
  }
  factory Tournament.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tournament.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tournament clone() => Tournament()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tournament copyWith(void Function(Tournament) updates) => super.copyWith((message) => updates(message as Tournament)) as Tournament; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tournament create() => Tournament._();
  Tournament createEmptyInstance() => create();
  static $pb.PbList<Tournament> createRepeated() => $pb.PbList<Tournament>();
  @$core.pragma('dart2js:noInline')
  static Tournament getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tournament>(create);
  static Tournament? _defaultInstance;

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
  Tournament_Status get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(Tournament_Status v) { setField(3, v); }
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

  @$pb.TagNumber(6)
  $core.int get gamesCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set gamesCount($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasGamesCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearGamesCount() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get billedPlayers => $_getIZ(6);
  @$pb.TagNumber(7)
  set billedPlayers($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBilledPlayers() => $_has(6);
  @$pb.TagNumber(7)
  void clearBilledPlayers() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get billedTranslation => $_getBF(7);
  @$pb.TagNumber(8)
  set billedTranslation($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBilledTranslation() => $_has(7);
  @$pb.TagNumber(8)
  void clearBilledTranslation() => clearField(8);
}

class ErrorOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ErrorOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ErrorOut._() : super();
  factory ErrorOut({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ErrorOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ErrorOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ErrorOut clone() => ErrorOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ErrorOut copyWith(void Function(ErrorOut) updates) => super.copyWith((message) => updates(message as ErrorOut)) as ErrorOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ErrorOut create() => ErrorOut._();
  ErrorOut createEmptyInstance() => create();
  static $pb.PbList<ErrorOut> createRepeated() => $pb.PbList<ErrorOut>();
  @$core.pragma('dart2js:noInline')
  static ErrorOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ErrorOut>(create);
  static ErrorOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class BillTournamentEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BillTournamentEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'players', $pb.PbFieldType.O3)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasTranslation', protoName: 'hasTranslation')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redirectPath', protoName: 'redirectPath')
    ..hasRequiredFields = false
  ;

  BillTournamentEvent._() : super();
  factory BillTournamentEvent({
    $core.int? players,
    $core.bool? hasTranslation,
    $core.String? redirectPath,
  }) {
    final _result = create();
    if (players != null) {
      _result.players = players;
    }
    if (hasTranslation != null) {
      _result.hasTranslation = hasTranslation;
    }
    if (redirectPath != null) {
      _result.redirectPath = redirectPath;
    }
    return _result;
  }
  factory BillTournamentEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BillTournamentEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BillTournamentEvent clone() => BillTournamentEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BillTournamentEvent copyWith(void Function(BillTournamentEvent) updates) => super.copyWith((message) => updates(message as BillTournamentEvent)) as BillTournamentEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BillTournamentEvent create() => BillTournamentEvent._();
  BillTournamentEvent createEmptyInstance() => create();
  static $pb.PbList<BillTournamentEvent> createRepeated() => $pb.PbList<BillTournamentEvent>();
  @$core.pragma('dart2js:noInline')
  static BillTournamentEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BillTournamentEvent>(create);
  static BillTournamentEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get players => $_getIZ(0);
  @$pb.TagNumber(1)
  set players($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayers() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayers() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get hasTranslation => $_getBF(1);
  @$pb.TagNumber(2)
  set hasTranslation($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHasTranslation() => $_has(1);
  @$pb.TagNumber(2)
  void clearHasTranslation() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get redirectPath => $_getSZ(2);
  @$pb.TagNumber(3)
  set redirectPath($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRedirectPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearRedirectPath() => clearField(3);
}

class BillClubEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BillClubEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'days', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redirectPath', protoName: 'redirectPath')
    ..hasRequiredFields = false
  ;

  BillClubEvent._() : super();
  factory BillClubEvent({
    $core.int? days,
    $core.String? redirectPath,
  }) {
    final _result = create();
    if (days != null) {
      _result.days = days;
    }
    if (redirectPath != null) {
      _result.redirectPath = redirectPath;
    }
    return _result;
  }
  factory BillClubEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BillClubEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BillClubEvent clone() => BillClubEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BillClubEvent copyWith(void Function(BillClubEvent) updates) => super.copyWith((message) => updates(message as BillClubEvent)) as BillClubEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BillClubEvent create() => BillClubEvent._();
  BillClubEvent createEmptyInstance() => create();
  static $pb.PbList<BillClubEvent> createRepeated() => $pb.PbList<BillClubEvent>();
  @$core.pragma('dart2js:noInline')
  static BillClubEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BillClubEvent>(create);
  static BillClubEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get days => $_getIZ(0);
  @$pb.TagNumber(1)
  set days($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDays() => $_has(0);
  @$pb.TagNumber(1)
  void clearDays() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get redirectPath => $_getSZ(1);
  @$pb.TagNumber(2)
  set redirectPath($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRedirectPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearRedirectPath() => clearField(2);
}

class BillTournamentEventOut extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BillTournamentEventOut', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redirectLink', protoName: 'redirectLink')
    ..hasRequiredFields = false
  ;

  BillTournamentEventOut._() : super();
  factory BillTournamentEventOut({
    $core.String? redirectLink,
  }) {
    final _result = create();
    if (redirectLink != null) {
      _result.redirectLink = redirectLink;
    }
    return _result;
  }
  factory BillTournamentEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BillTournamentEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BillTournamentEventOut clone() => BillTournamentEventOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BillTournamentEventOut copyWith(void Function(BillTournamentEventOut) updates) => super.copyWith((message) => updates(message as BillTournamentEventOut)) as BillTournamentEventOut; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BillTournamentEventOut create() => BillTournamentEventOut._();
  BillTournamentEventOut createEmptyInstance() => create();
  static $pb.PbList<BillTournamentEventOut> createRepeated() => $pb.PbList<BillTournamentEventOut>();
  @$core.pragma('dart2js:noInline')
  static BillTournamentEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BillTournamentEventOut>(create);
  static BillTournamentEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get redirectLink => $_getSZ(0);
  @$pb.TagNumber(1)
  set redirectLink($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRedirectLink() => $_has(0);
  @$pb.TagNumber(1)
  void clearRedirectLink() => clearField(1);
}

