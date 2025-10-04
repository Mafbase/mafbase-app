// This is a generated file - do not edit.
//
// Generated from seating-generator-proto/mafia.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'mafia.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'mafia.pbenum.dart';

class LoginEvent extends $pb.GeneratedMessage {
  factory LoginEvent({
    $core.String? email,
    $core.String? password,
  }) {
    final result = create();
    if (email != null) result.email = email;
    if (password != null) result.password = password;
    return result;
  }

  LoginEvent._();

  factory LoginEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginEvent copyWith(void Function(LoginEvent) updates) =>
      super.copyWith((message) => updates(message as LoginEvent)) as LoginEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginEvent create() => LoginEvent._();
  @$core.override
  LoginEvent createEmptyInstance() => create();
  static $pb.PbList<LoginEvent> createRepeated() => $pb.PbList<LoginEvent>();
  @$core.pragma('dart2js:noInline')
  static LoginEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginEvent>(create);
  static LoginEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);
}

class TableSeating extends $pb.GeneratedMessage {
  factory TableSeating({
    $core.Iterable<$core.String>? nickname,
    $core.String? referee,
    $core.int? table,
  }) {
    final result = create();
    if (nickname != null) result.nickname.addAll(nickname);
    if (referee != null) result.referee = referee;
    if (table != null) result.table = table;
    return result;
  }

  TableSeating._();

  factory TableSeating.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TableSeating.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TableSeating',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'nickname')
    ..aOS(2, _omitFieldNames ? '' : 'referee')
    ..aI(3, _omitFieldNames ? '' : 'table')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TableSeating clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TableSeating copyWith(void Function(TableSeating) updates) =>
      super.copyWith((message) => updates(message as TableSeating))
          as TableSeating;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TableSeating create() => TableSeating._();
  @$core.override
  TableSeating createEmptyInstance() => create();
  static $pb.PbList<TableSeating> createRepeated() =>
      $pb.PbList<TableSeating>();
  @$core.pragma('dart2js:noInline')
  static TableSeating getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TableSeating>(create);
  static TableSeating? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get nickname => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get referee => $_getSZ(1);
  @$pb.TagNumber(2)
  set referee($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReferee() => $_has(1);
  @$pb.TagNumber(2)
  void clearReferee() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get table => $_getIZ(2);
  @$pb.TagNumber(3)
  set table($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTable() => $_has(2);
  @$pb.TagNumber(3)
  void clearTable() => $_clearField(3);
}

class TableSeatingResult extends $pb.GeneratedMessage {
  factory TableSeatingResult({
    $core.Iterable<PlayerRole>? role,
    $core.Iterable<$core.double>? score,
    $core.int? died,
    GameWin? win,
    BestMove? bestMove,
    $core.Iterable<$core.double>? addScore,
  }) {
    final result = create();
    if (role != null) result.role.addAll(role);
    if (score != null) result.score.addAll(score);
    if (died != null) result.died = died;
    if (win != null) result.win = win;
    if (bestMove != null) result.bestMove = bestMove;
    if (addScore != null) result.addScore.addAll(addScore);
    return result;
  }

  TableSeatingResult._();

  factory TableSeatingResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TableSeatingResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TableSeatingResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..pc<PlayerRole>(1, _omitFieldNames ? '' : 'role', $pb.PbFieldType.KE,
        valueOf: PlayerRole.valueOf,
        enumValues: PlayerRole.values,
        defaultEnumValue: PlayerRole.citizen)
    ..p<$core.double>(2, _omitFieldNames ? '' : 'score', $pb.PbFieldType.KD)
    ..aI(3, _omitFieldNames ? '' : 'died')
    ..aE<GameWin>(4, _omitFieldNames ? '' : 'win', enumValues: GameWin.values)
    ..aE<BestMove>(5, _omitFieldNames ? '' : 'bestMove',
        protoName: 'bestMove', enumValues: BestMove.values)
    ..p<$core.double>(6, _omitFieldNames ? '' : 'addScore', $pb.PbFieldType.KD,
        protoName: 'addScore')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TableSeatingResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TableSeatingResult copyWith(void Function(TableSeatingResult) updates) =>
      super.copyWith((message) => updates(message as TableSeatingResult))
          as TableSeatingResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TableSeatingResult create() => TableSeatingResult._();
  @$core.override
  TableSeatingResult createEmptyInstance() => create();
  static $pb.PbList<TableSeatingResult> createRepeated() =>
      $pb.PbList<TableSeatingResult>();
  @$core.pragma('dart2js:noInline')
  static TableSeatingResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TableSeatingResult>(create);
  static TableSeatingResult? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PlayerRole> get role => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.double> get score => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get died => $_getIZ(2);
  @$pb.TagNumber(3)
  set died($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDied() => $_has(2);
  @$pb.TagNumber(3)
  void clearDied() => $_clearField(3);

  @$pb.TagNumber(4)
  GameWin get win => $_getN(3);
  @$pb.TagNumber(4)
  set win(GameWin value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasWin() => $_has(3);
  @$pb.TagNumber(4)
  void clearWin() => $_clearField(4);

  @$pb.TagNumber(5)
  BestMove get bestMove => $_getN(4);
  @$pb.TagNumber(5)
  set bestMove(BestMove value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasBestMove() => $_has(4);
  @$pb.TagNumber(5)
  void clearBestMove() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.double> get addScore => $_getList(5);
}

class UpdateHideDateRequest extends $pb.GeneratedMessage {
  factory UpdateHideDateRequest({
    $core.String? date,
  }) {
    final result = create();
    if (date != null) result.date = date;
    return result;
  }

  UpdateHideDateRequest._();

  factory UpdateHideDateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateHideDateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateHideDateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'date')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateHideDateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateHideDateRequest copyWith(
          void Function(UpdateHideDateRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateHideDateRequest))
          as UpdateHideDateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateHideDateRequest create() => UpdateHideDateRequest._();
  @$core.override
  UpdateHideDateRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateHideDateRequest> createRepeated() =>
      $pb.PbList<UpdateHideDateRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateHideDateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateHideDateRequest>(create);
  static UpdateHideDateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get date => $_getSZ(0);
  @$pb.TagNumber(1)
  set date($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => $_clearField(1);
}

class TableSeatingItem extends $pb.GeneratedMessage {
  factory TableSeatingItem({
    $core.int? gameId,
    TableSeating? seating,
    TableSeatingResult? result,
    $core.int? game,
    $core.int? table,
  }) {
    final result$ = create();
    if (gameId != null) result$.gameId = gameId;
    if (seating != null) result$.seating = seating;
    if (result != null) result$.result = result;
    if (game != null) result$.game = game;
    if (table != null) result$.table = table;
    return result$;
  }

  TableSeatingItem._();

  factory TableSeatingItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TableSeatingItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TableSeatingItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'gameId', protoName: 'gameId')
    ..aOM<TableSeating>(2, _omitFieldNames ? '' : 'seating',
        subBuilder: TableSeating.create)
    ..aOM<TableSeatingResult>(3, _omitFieldNames ? '' : 'result',
        subBuilder: TableSeatingResult.create)
    ..aI(4, _omitFieldNames ? '' : 'game')
    ..aI(5, _omitFieldNames ? '' : 'table')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TableSeatingItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TableSeatingItem copyWith(void Function(TableSeatingItem) updates) =>
      super.copyWith((message) => updates(message as TableSeatingItem))
          as TableSeatingItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TableSeatingItem create() => TableSeatingItem._();
  @$core.override
  TableSeatingItem createEmptyInstance() => create();
  static $pb.PbList<TableSeatingItem> createRepeated() =>
      $pb.PbList<TableSeatingItem>();
  @$core.pragma('dart2js:noInline')
  static TableSeatingItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TableSeatingItem>(create);
  static TableSeatingItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get gameId => $_getIZ(0);
  @$pb.TagNumber(1)
  set gameId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => $_clearField(1);

  @$pb.TagNumber(2)
  TableSeating get seating => $_getN(1);
  @$pb.TagNumber(2)
  set seating(TableSeating value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSeating() => $_has(1);
  @$pb.TagNumber(2)
  void clearSeating() => $_clearField(2);
  @$pb.TagNumber(2)
  TableSeating ensureSeating() => $_ensure(1);

  @$pb.TagNumber(3)
  TableSeatingResult get result => $_getN(2);
  @$pb.TagNumber(3)
  set result(TableSeatingResult value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasResult() => $_has(2);
  @$pb.TagNumber(3)
  void clearResult() => $_clearField(3);
  @$pb.TagNumber(3)
  TableSeatingResult ensureResult() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get game => $_getIZ(3);
  @$pb.TagNumber(4)
  set game($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasGame() => $_has(3);
  @$pb.TagNumber(4)
  void clearGame() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get table => $_getIZ(4);
  @$pb.TagNumber(5)
  set table($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTable() => $_has(4);
  @$pb.TagNumber(5)
  void clearTable() => $_clearField(5);
}

class SeatingEventOut extends $pb.GeneratedMessage {
  factory SeatingEventOut({
    $core.Iterable<TableSeatingItem>? item,
  }) {
    final result = create();
    if (item != null) result.item.addAll(item);
    return result;
  }

  SeatingEventOut._();

  factory SeatingEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SeatingEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SeatingEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..pPM<TableSeatingItem>(1, _omitFieldNames ? '' : 'item',
        subBuilder: TableSeatingItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SeatingEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SeatingEventOut copyWith(void Function(SeatingEventOut) updates) =>
      super.copyWith((message) => updates(message as SeatingEventOut))
          as SeatingEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SeatingEventOut create() => SeatingEventOut._();
  @$core.override
  SeatingEventOut createEmptyInstance() => create();
  static $pb.PbList<SeatingEventOut> createRepeated() =>
      $pb.PbList<SeatingEventOut>();
  @$core.pragma('dart2js:noInline')
  static SeatingEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SeatingEventOut>(create);
  static SeatingEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TableSeatingItem> get item => $_getList(0);
}

class LoginEventOut extends $pb.GeneratedMessage {
  factory LoginEventOut({
    $core.String? token,
    $core.String? recoveryToken,
    LoginEventOut_Error? error,
    $core.int? id,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (recoveryToken != null) result.recoveryToken = recoveryToken;
    if (error != null) result.error = error;
    if (id != null) result.id = id;
    return result;
  }

  LoginEventOut._();

  factory LoginEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'recoveryToken', protoName: 'recoveryToken')
    ..aE<LoginEventOut_Error>(3, _omitFieldNames ? '' : 'error',
        enumValues: LoginEventOut_Error.values)
    ..aI(4, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginEventOut copyWith(void Function(LoginEventOut) updates) =>
      super.copyWith((message) => updates(message as LoginEventOut))
          as LoginEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginEventOut create() => LoginEventOut._();
  @$core.override
  LoginEventOut createEmptyInstance() => create();
  static $pb.PbList<LoginEventOut> createRepeated() =>
      $pb.PbList<LoginEventOut>();
  @$core.pragma('dart2js:noInline')
  static LoginEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginEventOut>(create);
  static LoginEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get recoveryToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set recoveryToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRecoveryToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecoveryToken() => $_clearField(2);

  @$pb.TagNumber(3)
  LoginEventOut_Error get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(LoginEventOut_Error value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get id => $_getIZ(3);
  @$pb.TagNumber(4)
  set id($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasId() => $_has(3);
  @$pb.TagNumber(4)
  void clearId() => $_clearField(4);
}

class ChangeSeatingContent extends $pb.GeneratedMessage {
  factory ChangeSeatingContent({
    $core.int? player,
    $core.String? imageUrl,
    PlayerRole? role,
    PlayerStatus? status,
    $core.int? selectedGame,
  }) {
    final result = create();
    if (player != null) result.player = player;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (role != null) result.role = role;
    if (status != null) result.status = status;
    if (selectedGame != null) result.selectedGame = selectedGame;
    return result;
  }

  ChangeSeatingContent._();

  factory ChangeSeatingContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChangeSeatingContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChangeSeatingContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'player')
    ..aOS(2, _omitFieldNames ? '' : 'imageUrl', protoName: 'imageUrl')
    ..aE<PlayerRole>(3, _omitFieldNames ? '' : 'role',
        enumValues: PlayerRole.values)
    ..aE<PlayerStatus>(4, _omitFieldNames ? '' : 'status',
        enumValues: PlayerStatus.values)
    ..aI(5, _omitFieldNames ? '' : 'selectedGame', protoName: 'selectedGame')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangeSeatingContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangeSeatingContent copyWith(void Function(ChangeSeatingContent) updates) =>
      super.copyWith((message) => updates(message as ChangeSeatingContent))
          as ChangeSeatingContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangeSeatingContent create() => ChangeSeatingContent._();
  @$core.override
  ChangeSeatingContent createEmptyInstance() => create();
  static $pb.PbList<ChangeSeatingContent> createRepeated() =>
      $pb.PbList<ChangeSeatingContent>();
  @$core.pragma('dart2js:noInline')
  static ChangeSeatingContent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChangeSeatingContent>(create);
  static ChangeSeatingContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get player => $_getIZ(0);
  @$pb.TagNumber(1)
  set player($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPlayer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get imageUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set imageUrl($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasImageUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  PlayerRole get role => $_getN(2);
  @$pb.TagNumber(3)
  set role(PlayerRole value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => $_clearField(3);

  @$pb.TagNumber(4)
  PlayerStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(PlayerStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get selectedGame => $_getIZ(4);
  @$pb.TagNumber(5)
  set selectedGame($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSelectedGame() => $_has(4);
  @$pb.TagNumber(5)
  void clearSelectedGame() => $_clearField(5);
}

class Club extends $pb.GeneratedMessage {
  factory Club({
    $core.int? id,
    $core.String? name,
    $core.String? description,
    $core.String? imageUrl,
    $core.String? groupLink,
    $core.String? city,
    $core.String? billedFor,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (groupLink != null) result.groupLink = groupLink;
    if (city != null) result.city = city;
    if (billedFor != null) result.billedFor = billedFor;
    return result;
  }

  Club._();

  factory Club.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Club.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Club',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'imageUrl', protoName: 'imageUrl')
    ..aOS(5, _omitFieldNames ? '' : 'groupLink', protoName: 'groupLink')
    ..aOS(6, _omitFieldNames ? '' : 'city')
    ..aOS(7, _omitFieldNames ? '' : 'billedFor', protoName: 'billedFor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Club clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Club copyWith(void Function(Club) updates) =>
      super.copyWith((message) => updates(message as Club)) as Club;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Club create() => Club._();
  @$core.override
  Club createEmptyInstance() => create();
  static $pb.PbList<Club> createRepeated() => $pb.PbList<Club>();
  @$core.pragma('dart2js:noInline')
  static Club getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Club>(create);
  static Club? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get imageUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set imageUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasImageUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearImageUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get groupLink => $_getSZ(4);
  @$pb.TagNumber(5)
  set groupLink($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasGroupLink() => $_has(4);
  @$pb.TagNumber(5)
  void clearGroupLink() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get city => $_getSZ(5);
  @$pb.TagNumber(6)
  set city($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCity() => $_has(5);
  @$pb.TagNumber(6)
  void clearCity() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get billedFor => $_getSZ(6);
  @$pb.TagNumber(7)
  set billedFor($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBilledFor() => $_has(6);
  @$pb.TagNumber(7)
  void clearBilledFor() => $_clearField(7);
}

class ClubRatingEventOut extends $pb.GeneratedMessage {
  factory ClubRatingEventOut({
    $core.Iterable<ClubRatingRow>? row,
    $core.String? clubName,
    $core.int? games,
    $core.int? mafiaWins,
    $core.int? citizenWins,
  }) {
    final result = create();
    if (row != null) result.row.addAll(row);
    if (clubName != null) result.clubName = clubName;
    if (games != null) result.games = games;
    if (mafiaWins != null) result.mafiaWins = mafiaWins;
    if (citizenWins != null) result.citizenWins = citizenWins;
    return result;
  }

  ClubRatingEventOut._();

  factory ClubRatingEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ClubRatingEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClubRatingEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..pPM<ClubRatingRow>(1, _omitFieldNames ? '' : 'row',
        subBuilder: ClubRatingRow.create)
    ..aOS(2, _omitFieldNames ? '' : 'clubName', protoName: 'clubName')
    ..aI(3, _omitFieldNames ? '' : 'games')
    ..aI(4, _omitFieldNames ? '' : 'mafiaWins', protoName: 'mafiaWins')
    ..aI(5, _omitFieldNames ? '' : 'citizenWins', protoName: 'citizenWins')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClubRatingEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClubRatingEventOut copyWith(void Function(ClubRatingEventOut) updates) =>
      super.copyWith((message) => updates(message as ClubRatingEventOut))
          as ClubRatingEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClubRatingEventOut create() => ClubRatingEventOut._();
  @$core.override
  ClubRatingEventOut createEmptyInstance() => create();
  static $pb.PbList<ClubRatingEventOut> createRepeated() =>
      $pb.PbList<ClubRatingEventOut>();
  @$core.pragma('dart2js:noInline')
  static ClubRatingEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ClubRatingEventOut>(create);
  static ClubRatingEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ClubRatingRow> get row => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get clubName => $_getSZ(1);
  @$pb.TagNumber(2)
  set clubName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasClubName() => $_has(1);
  @$pb.TagNumber(2)
  void clearClubName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get games => $_getIZ(2);
  @$pb.TagNumber(3)
  set games($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasGames() => $_has(2);
  @$pb.TagNumber(3)
  void clearGames() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get mafiaWins => $_getIZ(3);
  @$pb.TagNumber(4)
  set mafiaWins($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMafiaWins() => $_has(3);
  @$pb.TagNumber(4)
  void clearMafiaWins() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get citizenWins => $_getIZ(4);
  @$pb.TagNumber(5)
  set citizenWins($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCitizenWins() => $_has(4);
  @$pb.TagNumber(5)
  void clearCitizenWins() => $_clearField(5);
}

class ClubRatingRow_GameItem extends $pb.GeneratedMessage {
  factory ClubRatingRow_GameItem({
    $core.int? gameId,
    $core.double? score,
  }) {
    final result = create();
    if (gameId != null) result.gameId = gameId;
    if (score != null) result.score = score;
    return result;
  }

  ClubRatingRow_GameItem._();

  factory ClubRatingRow_GameItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ClubRatingRow_GameItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClubRatingRow.GameItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'gameId', protoName: 'gameId')
    ..aD(2, _omitFieldNames ? '' : 'score')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClubRatingRow_GameItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClubRatingRow_GameItem copyWith(
          void Function(ClubRatingRow_GameItem) updates) =>
      super.copyWith((message) => updates(message as ClubRatingRow_GameItem))
          as ClubRatingRow_GameItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClubRatingRow_GameItem create() => ClubRatingRow_GameItem._();
  @$core.override
  ClubRatingRow_GameItem createEmptyInstance() => create();
  static $pb.PbList<ClubRatingRow_GameItem> createRepeated() =>
      $pb.PbList<ClubRatingRow_GameItem>();
  @$core.pragma('dart2js:noInline')
  static ClubRatingRow_GameItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ClubRatingRow_GameItem>(create);
  static ClubRatingRow_GameItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get gameId => $_getIZ(0);
  @$pb.TagNumber(1)
  set gameId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get score => $_getN(1);
  @$pb.TagNumber(2)
  set score($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearScore() => $_clearField(2);
}

class ClubRatingRow extends $pb.GeneratedMessage {
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
    $core.int? playerId,
    $core.int? refereeCount,
    $core.double? minusScore,
    $core.double? citizenMinusScore,
    $core.double? mafiaMinusScore,
    $core.double? donMinusScore,
    $core.double? sheriffMinusScore,
    $core.double? bestMoveCitizen,
    $core.double? bestMoveSheriff,
  }) {
    final result = create();
    if (nickname != null) result.nickname = nickname;
    if (score != null) result.score = score;
    if (addScore != null) result.addScore = addScore;
    if (firstDie != null) result.firstDie = firstDie;
    if (donWins != null) result.donWins = donWins;
    if (sheriffWins != null) result.sheriffWins = sheriffWins;
    if (item != null) result.item.addAll(item);
    if (wins != null) result.wins = wins;
    if (ci != null) result.ci = ci;
    if (totalGames != null) result.totalGames = totalGames;
    if (citizenGames != null) result.citizenGames = citizenGames;
    if (donGames != null) result.donGames = donGames;
    if (sheriffGames != null) result.sheriffGames = sheriffGames;
    if (mafiaGames != null) result.mafiaGames = mafiaGames;
    if (mafiaWins != null) result.mafiaWins = mafiaWins;
    if (citizenWins != null) result.citizenWins = citizenWins;
    if (citizenAddScore != null) result.citizenAddScore = citizenAddScore;
    if (mafiaAddScore != null) result.mafiaAddScore = mafiaAddScore;
    if (donAddScore != null) result.donAddScore = donAddScore;
    if (sheriffAddScore != null) result.sheriffAddScore = sheriffAddScore;
    if (citizenScore != null) result.citizenScore = citizenScore;
    if (mafiaScore != null) result.mafiaScore = mafiaScore;
    if (donScore != null) result.donScore = donScore;
    if (sheriffScore != null) result.sheriffScore = sheriffScore;
    if (playerId != null) result.playerId = playerId;
    if (refereeCount != null) result.refereeCount = refereeCount;
    if (minusScore != null) result.minusScore = minusScore;
    if (citizenMinusScore != null) result.citizenMinusScore = citizenMinusScore;
    if (mafiaMinusScore != null) result.mafiaMinusScore = mafiaMinusScore;
    if (donMinusScore != null) result.donMinusScore = donMinusScore;
    if (sheriffMinusScore != null) result.sheriffMinusScore = sheriffMinusScore;
    if (bestMoveCitizen != null) result.bestMoveCitizen = bestMoveCitizen;
    if (bestMoveSheriff != null) result.bestMoveSheriff = bestMoveSheriff;
    return result;
  }

  ClubRatingRow._();

  factory ClubRatingRow.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ClubRatingRow.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClubRatingRow',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nickname')
    ..aD(2, _omitFieldNames ? '' : 'score')
    ..aD(3, _omitFieldNames ? '' : 'addScore', protoName: 'addScore')
    ..aI(4, _omitFieldNames ? '' : 'firstDie', protoName: 'firstDie')
    ..aI(5, _omitFieldNames ? '' : 'donWins', protoName: 'donWins')
    ..aI(6, _omitFieldNames ? '' : 'sheriffWins', protoName: 'sheriffWins')
    ..pPM<ClubRatingRow_GameItem>(7, _omitFieldNames ? '' : 'item',
        subBuilder: ClubRatingRow_GameItem.create)
    ..aI(8, _omitFieldNames ? '' : 'wins')
    ..aI(9, _omitFieldNames ? '' : 'ci')
    ..aI(10, _omitFieldNames ? '' : 'totalGames', protoName: 'totalGames')
    ..aI(11, _omitFieldNames ? '' : 'citizenGames', protoName: 'citizenGames')
    ..aI(12, _omitFieldNames ? '' : 'donGames', protoName: 'donGames')
    ..aI(13, _omitFieldNames ? '' : 'sheriffGames', protoName: 'sheriffGames')
    ..aI(14, _omitFieldNames ? '' : 'mafiaGames', protoName: 'mafiaGames')
    ..aI(15, _omitFieldNames ? '' : 'mafiaWins', protoName: 'mafiaWins')
    ..aI(16, _omitFieldNames ? '' : 'citizenWins', protoName: 'citizenWins')
    ..aD(17, _omitFieldNames ? '' : 'citizenAddScore',
        protoName: 'citizenAddScore')
    ..aD(18, _omitFieldNames ? '' : 'mafiaAddScore', protoName: 'mafiaAddScore')
    ..aD(19, _omitFieldNames ? '' : 'donAddScore', protoName: 'donAddScore')
    ..aD(20, _omitFieldNames ? '' : 'sheriffAddScore',
        protoName: 'sheriffAddScore')
    ..aD(21, _omitFieldNames ? '' : 'citizenScore', protoName: 'citizenScore')
    ..aD(22, _omitFieldNames ? '' : 'mafiaScore', protoName: 'mafiaScore')
    ..aD(23, _omitFieldNames ? '' : 'donScore', protoName: 'donScore')
    ..aD(24, _omitFieldNames ? '' : 'sheriffScore', protoName: 'sheriffScore')
    ..aI(25, _omitFieldNames ? '' : 'playerId', protoName: 'playerId')
    ..aI(26, _omitFieldNames ? '' : 'refereeCount', protoName: 'refereeCount')
    ..aD(27, _omitFieldNames ? '' : 'minusScore', protoName: 'minusScore')
    ..aD(28, _omitFieldNames ? '' : 'citizenMinusScore',
        protoName: 'citizenMinusScore')
    ..aD(29, _omitFieldNames ? '' : 'mafiaMinusScore',
        protoName: 'mafiaMinusScore')
    ..aD(30, _omitFieldNames ? '' : 'donMinusScore', protoName: 'donMinusScore')
    ..aD(31, _omitFieldNames ? '' : 'sheriffMinusScore',
        protoName: 'sheriffMinusScore')
    ..aD(32, _omitFieldNames ? '' : 'bestMoveCitizen',
        protoName: 'bestMoveCitizen')
    ..aD(33, _omitFieldNames ? '' : 'bestMoveSheriff',
        protoName: 'bestMoveSheriff')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClubRatingRow clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClubRatingRow copyWith(void Function(ClubRatingRow) updates) =>
      super.copyWith((message) => updates(message as ClubRatingRow))
          as ClubRatingRow;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClubRatingRow create() => ClubRatingRow._();
  @$core.override
  ClubRatingRow createEmptyInstance() => create();
  static $pb.PbList<ClubRatingRow> createRepeated() =>
      $pb.PbList<ClubRatingRow>();
  @$core.pragma('dart2js:noInline')
  static ClubRatingRow getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ClubRatingRow>(create);
  static ClubRatingRow? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get nickname => $_getSZ(0);
  @$pb.TagNumber(1)
  set nickname($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNickname() => $_has(0);
  @$pb.TagNumber(1)
  void clearNickname() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get score => $_getN(1);
  @$pb.TagNumber(2)
  set score($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearScore() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get addScore => $_getN(2);
  @$pb.TagNumber(3)
  set addScore($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAddScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearAddScore() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get firstDie => $_getIZ(3);
  @$pb.TagNumber(4)
  set firstDie($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFirstDie() => $_has(3);
  @$pb.TagNumber(4)
  void clearFirstDie() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get donWins => $_getIZ(4);
  @$pb.TagNumber(5)
  set donWins($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDonWins() => $_has(4);
  @$pb.TagNumber(5)
  void clearDonWins() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get sheriffWins => $_getIZ(5);
  @$pb.TagNumber(6)
  set sheriffWins($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSheriffWins() => $_has(5);
  @$pb.TagNumber(6)
  void clearSheriffWins() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<ClubRatingRow_GameItem> get item => $_getList(6);

  @$pb.TagNumber(8)
  $core.int get wins => $_getIZ(7);
  @$pb.TagNumber(8)
  set wins($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasWins() => $_has(7);
  @$pb.TagNumber(8)
  void clearWins() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get ci => $_getIZ(8);
  @$pb.TagNumber(9)
  set ci($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCi() => $_has(8);
  @$pb.TagNumber(9)
  void clearCi() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get totalGames => $_getIZ(9);
  @$pb.TagNumber(10)
  set totalGames($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTotalGames() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalGames() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get citizenGames => $_getIZ(10);
  @$pb.TagNumber(11)
  set citizenGames($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCitizenGames() => $_has(10);
  @$pb.TagNumber(11)
  void clearCitizenGames() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get donGames => $_getIZ(11);
  @$pb.TagNumber(12)
  set donGames($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasDonGames() => $_has(11);
  @$pb.TagNumber(12)
  void clearDonGames() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get sheriffGames => $_getIZ(12);
  @$pb.TagNumber(13)
  set sheriffGames($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasSheriffGames() => $_has(12);
  @$pb.TagNumber(13)
  void clearSheriffGames() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get mafiaGames => $_getIZ(13);
  @$pb.TagNumber(14)
  set mafiaGames($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasMafiaGames() => $_has(13);
  @$pb.TagNumber(14)
  void clearMafiaGames() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get mafiaWins => $_getIZ(14);
  @$pb.TagNumber(15)
  set mafiaWins($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasMafiaWins() => $_has(14);
  @$pb.TagNumber(15)
  void clearMafiaWins() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get citizenWins => $_getIZ(15);
  @$pb.TagNumber(16)
  set citizenWins($core.int value) => $_setSignedInt32(15, value);
  @$pb.TagNumber(16)
  $core.bool hasCitizenWins() => $_has(15);
  @$pb.TagNumber(16)
  void clearCitizenWins() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.double get citizenAddScore => $_getN(16);
  @$pb.TagNumber(17)
  set citizenAddScore($core.double value) => $_setDouble(16, value);
  @$pb.TagNumber(17)
  $core.bool hasCitizenAddScore() => $_has(16);
  @$pb.TagNumber(17)
  void clearCitizenAddScore() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.double get mafiaAddScore => $_getN(17);
  @$pb.TagNumber(18)
  set mafiaAddScore($core.double value) => $_setDouble(17, value);
  @$pb.TagNumber(18)
  $core.bool hasMafiaAddScore() => $_has(17);
  @$pb.TagNumber(18)
  void clearMafiaAddScore() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.double get donAddScore => $_getN(18);
  @$pb.TagNumber(19)
  set donAddScore($core.double value) => $_setDouble(18, value);
  @$pb.TagNumber(19)
  $core.bool hasDonAddScore() => $_has(18);
  @$pb.TagNumber(19)
  void clearDonAddScore() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.double get sheriffAddScore => $_getN(19);
  @$pb.TagNumber(20)
  set sheriffAddScore($core.double value) => $_setDouble(19, value);
  @$pb.TagNumber(20)
  $core.bool hasSheriffAddScore() => $_has(19);
  @$pb.TagNumber(20)
  void clearSheriffAddScore() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.double get citizenScore => $_getN(20);
  @$pb.TagNumber(21)
  set citizenScore($core.double value) => $_setDouble(20, value);
  @$pb.TagNumber(21)
  $core.bool hasCitizenScore() => $_has(20);
  @$pb.TagNumber(21)
  void clearCitizenScore() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.double get mafiaScore => $_getN(21);
  @$pb.TagNumber(22)
  set mafiaScore($core.double value) => $_setDouble(21, value);
  @$pb.TagNumber(22)
  $core.bool hasMafiaScore() => $_has(21);
  @$pb.TagNumber(22)
  void clearMafiaScore() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.double get donScore => $_getN(22);
  @$pb.TagNumber(23)
  set donScore($core.double value) => $_setDouble(22, value);
  @$pb.TagNumber(23)
  $core.bool hasDonScore() => $_has(22);
  @$pb.TagNumber(23)
  void clearDonScore() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.double get sheriffScore => $_getN(23);
  @$pb.TagNumber(24)
  set sheriffScore($core.double value) => $_setDouble(23, value);
  @$pb.TagNumber(24)
  $core.bool hasSheriffScore() => $_has(23);
  @$pb.TagNumber(24)
  void clearSheriffScore() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.int get playerId => $_getIZ(24);
  @$pb.TagNumber(25)
  set playerId($core.int value) => $_setSignedInt32(24, value);
  @$pb.TagNumber(25)
  $core.bool hasPlayerId() => $_has(24);
  @$pb.TagNumber(25)
  void clearPlayerId() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.int get refereeCount => $_getIZ(25);
  @$pb.TagNumber(26)
  set refereeCount($core.int value) => $_setSignedInt32(25, value);
  @$pb.TagNumber(26)
  $core.bool hasRefereeCount() => $_has(25);
  @$pb.TagNumber(26)
  void clearRefereeCount() => $_clearField(26);

  @$pb.TagNumber(27)
  $core.double get minusScore => $_getN(26);
  @$pb.TagNumber(27)
  set minusScore($core.double value) => $_setDouble(26, value);
  @$pb.TagNumber(27)
  $core.bool hasMinusScore() => $_has(26);
  @$pb.TagNumber(27)
  void clearMinusScore() => $_clearField(27);

  @$pb.TagNumber(28)
  $core.double get citizenMinusScore => $_getN(27);
  @$pb.TagNumber(28)
  set citizenMinusScore($core.double value) => $_setDouble(27, value);
  @$pb.TagNumber(28)
  $core.bool hasCitizenMinusScore() => $_has(27);
  @$pb.TagNumber(28)
  void clearCitizenMinusScore() => $_clearField(28);

  @$pb.TagNumber(29)
  $core.double get mafiaMinusScore => $_getN(28);
  @$pb.TagNumber(29)
  set mafiaMinusScore($core.double value) => $_setDouble(28, value);
  @$pb.TagNumber(29)
  $core.bool hasMafiaMinusScore() => $_has(28);
  @$pb.TagNumber(29)
  void clearMafiaMinusScore() => $_clearField(29);

  @$pb.TagNumber(30)
  $core.double get donMinusScore => $_getN(29);
  @$pb.TagNumber(30)
  set donMinusScore($core.double value) => $_setDouble(29, value);
  @$pb.TagNumber(30)
  $core.bool hasDonMinusScore() => $_has(29);
  @$pb.TagNumber(30)
  void clearDonMinusScore() => $_clearField(30);

  @$pb.TagNumber(31)
  $core.double get sheriffMinusScore => $_getN(30);
  @$pb.TagNumber(31)
  set sheriffMinusScore($core.double value) => $_setDouble(30, value);
  @$pb.TagNumber(31)
  $core.bool hasSheriffMinusScore() => $_has(30);
  @$pb.TagNumber(31)
  void clearSheriffMinusScore() => $_clearField(31);

  @$pb.TagNumber(32)
  $core.double get bestMoveCitizen => $_getN(31);
  @$pb.TagNumber(32)
  set bestMoveCitizen($core.double value) => $_setDouble(31, value);
  @$pb.TagNumber(32)
  $core.bool hasBestMoveCitizen() => $_has(31);
  @$pb.TagNumber(32)
  void clearBestMoveCitizen() => $_clearField(32);

  @$pb.TagNumber(33)
  $core.double get bestMoveSheriff => $_getN(32);
  @$pb.TagNumber(33)
  set bestMoveSheriff($core.double value) => $_setDouble(32, value);
  @$pb.TagNumber(33)
  $core.bool hasBestMoveSheriff() => $_has(32);
  @$pb.TagNumber(33)
  void clearBestMoveSheriff() => $_clearField(33);
}

class AddGameEventOut extends $pb.GeneratedMessage {
  factory AddGameEventOut({
    $core.int? gameId,
  }) {
    final result = create();
    if (gameId != null) result.gameId = gameId;
    return result;
  }

  AddGameEventOut._();

  factory AddGameEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddGameEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddGameEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'gameId', protoName: 'gameId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddGameEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddGameEventOut copyWith(void Function(AddGameEventOut) updates) =>
      super.copyWith((message) => updates(message as AddGameEventOut))
          as AddGameEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddGameEventOut create() => AddGameEventOut._();
  @$core.override
  AddGameEventOut createEmptyInstance() => create();
  static $pb.PbList<AddGameEventOut> createRepeated() =>
      $pb.PbList<AddGameEventOut>();
  @$core.pragma('dart2js:noInline')
  static AddGameEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddGameEventOut>(create);
  static AddGameEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get gameId => $_getIZ(0);
  @$pb.TagNumber(1)
  set gameId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => $_clearField(1);
}

class CiScheme extends $pb.GeneratedMessage {
  factory CiScheme({
    $core.int? id,
    $core.String? name,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    return result;
  }

  CiScheme._();

  factory CiScheme.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CiScheme.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CiScheme',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CiScheme clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CiScheme copyWith(void Function(CiScheme) updates) =>
      super.copyWith((message) => updates(message as CiScheme)) as CiScheme;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CiScheme create() => CiScheme._();
  @$core.override
  CiScheme createEmptyInstance() => create();
  static $pb.PbList<CiScheme> createRepeated() => $pb.PbList<CiScheme>();
  @$core.pragma('dart2js:noInline')
  static CiScheme getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CiScheme>(create);
  static CiScheme? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

class AvailableCiEventOut extends $pb.GeneratedMessage {
  factory AvailableCiEventOut({
    $core.Iterable<CiScheme>? schemes,
  }) {
    final result = create();
    if (schemes != null) result.schemes.addAll(schemes);
    return result;
  }

  AvailableCiEventOut._();

  factory AvailableCiEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AvailableCiEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AvailableCiEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..pPM<CiScheme>(1, _omitFieldNames ? '' : 'schemes',
        subBuilder: CiScheme.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AvailableCiEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AvailableCiEventOut copyWith(void Function(AvailableCiEventOut) updates) =>
      super.copyWith((message) => updates(message as AvailableCiEventOut))
          as AvailableCiEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AvailableCiEventOut create() => AvailableCiEventOut._();
  @$core.override
  AvailableCiEventOut createEmptyInstance() => create();
  static $pb.PbList<AvailableCiEventOut> createRepeated() =>
      $pb.PbList<AvailableCiEventOut>();
  @$core.pragma('dart2js:noInline')
  static AvailableCiEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AvailableCiEventOut>(create);
  static AvailableCiEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CiScheme> get schemes => $_getList(0);
}

class SetFinalPlayersEvent extends $pb.GeneratedMessage {
  factory SetFinalPlayersEvent({
    $core.Iterable<$core.int>? id,
  }) {
    final result = create();
    if (id != null) result.id.addAll(id);
    return result;
  }

  SetFinalPlayersEvent._();

  factory SetFinalPlayersEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetFinalPlayersEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetFinalPlayersEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.K3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetFinalPlayersEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetFinalPlayersEvent copyWith(void Function(SetFinalPlayersEvent) updates) =>
      super.copyWith((message) => updates(message as SetFinalPlayersEvent))
          as SetFinalPlayersEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetFinalPlayersEvent create() => SetFinalPlayersEvent._();
  @$core.override
  SetFinalPlayersEvent createEmptyInstance() => create();
  static $pb.PbList<SetFinalPlayersEvent> createRepeated() =>
      $pb.PbList<SetFinalPlayersEvent>();
  @$core.pragma('dart2js:noInline')
  static SetFinalPlayersEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetFinalPlayersEvent>(create);
  static SetFinalPlayersEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.int> get id => $_getList(0);
}

class ClubGameResult extends $pb.GeneratedMessage {
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
    RatingScheme? ratingScheme,
  }) {
    final result = create();
    if (addScore != null) result.addScore.addAll(addScore);
    if (players != null) result.players.addAll(players);
    if (win != null) result.win = win;
    if (firstDie != null) result.firstDie = firstDie;
    if (bestMove != null) result.bestMove = bestMove;
    if (date != null) result.date = date;
    if (referee != null) result.referee = referee;
    if (mafia1 != null) result.mafia1 = mafia1;
    if (mafia2 != null) result.mafia2 = mafia2;
    if (don != null) result.don = don;
    if (sheriff != null) result.sheriff = sheriff;
    if (ciId != null) result.ciId = ciId;
    if (ratingScheme != null) result.ratingScheme = ratingScheme;
    return result;
  }

  ClubGameResult._();

  factory ClubGameResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ClubGameResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClubGameResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'addScore', $pb.PbFieldType.K3,
        protoName: 'addScore')
    ..p<$core.int>(2, _omitFieldNames ? '' : 'players', $pb.PbFieldType.K3)
    ..aE<GameWin>(3, _omitFieldNames ? '' : 'win', enumValues: GameWin.values)
    ..aI(4, _omitFieldNames ? '' : 'firstDie', protoName: 'firstDie')
    ..aE<BestMove>(5, _omitFieldNames ? '' : 'bestMove',
        protoName: 'bestMove', enumValues: BestMove.values)
    ..aOS(6, _omitFieldNames ? '' : 'date')
    ..aI(7, _omitFieldNames ? '' : 'referee')
    ..aI(8, _omitFieldNames ? '' : 'mafia1')
    ..aI(9, _omitFieldNames ? '' : 'mafia2')
    ..aI(10, _omitFieldNames ? '' : 'don')
    ..aI(11, _omitFieldNames ? '' : 'sheriff')
    ..aI(12, _omitFieldNames ? '' : 'ciId', protoName: 'ciId')
    ..aE<RatingScheme>(13, _omitFieldNames ? '' : 'ratingScheme',
        protoName: 'ratingScheme', enumValues: RatingScheme.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClubGameResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClubGameResult copyWith(void Function(ClubGameResult) updates) =>
      super.copyWith((message) => updates(message as ClubGameResult))
          as ClubGameResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClubGameResult create() => ClubGameResult._();
  @$core.override
  ClubGameResult createEmptyInstance() => create();
  static $pb.PbList<ClubGameResult> createRepeated() =>
      $pb.PbList<ClubGameResult>();
  @$core.pragma('dart2js:noInline')
  static ClubGameResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ClubGameResult>(create);
  static ClubGameResult? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.int> get addScore => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.int> get players => $_getList(1);

  @$pb.TagNumber(3)
  GameWin get win => $_getN(2);
  @$pb.TagNumber(3)
  set win(GameWin value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasWin() => $_has(2);
  @$pb.TagNumber(3)
  void clearWin() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get firstDie => $_getIZ(3);
  @$pb.TagNumber(4)
  set firstDie($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFirstDie() => $_has(3);
  @$pb.TagNumber(4)
  void clearFirstDie() => $_clearField(4);

  @$pb.TagNumber(5)
  BestMove get bestMove => $_getN(4);
  @$pb.TagNumber(5)
  set bestMove(BestMove value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasBestMove() => $_has(4);
  @$pb.TagNumber(5)
  void clearBestMove() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get date => $_getSZ(5);
  @$pb.TagNumber(6)
  set date($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearDate() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get referee => $_getIZ(6);
  @$pb.TagNumber(7)
  set referee($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasReferee() => $_has(6);
  @$pb.TagNumber(7)
  void clearReferee() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get mafia1 => $_getIZ(7);
  @$pb.TagNumber(8)
  set mafia1($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMafia1() => $_has(7);
  @$pb.TagNumber(8)
  void clearMafia1() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get mafia2 => $_getIZ(8);
  @$pb.TagNumber(9)
  set mafia2($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMafia2() => $_has(8);
  @$pb.TagNumber(9)
  void clearMafia2() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get don => $_getIZ(9);
  @$pb.TagNumber(10)
  set don($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDon() => $_has(9);
  @$pb.TagNumber(10)
  void clearDon() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get sheriff => $_getIZ(10);
  @$pb.TagNumber(11)
  set sheriff($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSheriff() => $_has(10);
  @$pb.TagNumber(11)
  void clearSheriff() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get ciId => $_getIZ(11);
  @$pb.TagNumber(12)
  set ciId($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCiId() => $_has(11);
  @$pb.TagNumber(12)
  void clearCiId() => $_clearField(12);

  @$pb.TagNumber(13)
  RatingScheme get ratingScheme => $_getN(12);
  @$pb.TagNumber(13)
  set ratingScheme(RatingScheme value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasRatingScheme() => $_has(12);
  @$pb.TagNumber(13)
  void clearRatingScheme() => $_clearField(13);
}

class ClubsEventOut extends $pb.GeneratedMessage {
  factory ClubsEventOut({
    $core.Iterable<Club>? club,
  }) {
    final result = create();
    if (club != null) result.club.addAll(club);
    return result;
  }

  ClubsEventOut._();

  factory ClubsEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ClubsEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClubsEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..pPM<Club>(1, _omitFieldNames ? '' : 'club', subBuilder: Club.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClubsEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClubsEventOut copyWith(void Function(ClubsEventOut) updates) =>
      super.copyWith((message) => updates(message as ClubsEventOut))
          as ClubsEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClubsEventOut create() => ClubsEventOut._();
  @$core.override
  ClubsEventOut createEmptyInstance() => create();
  static $pb.PbList<ClubsEventOut> createRepeated() =>
      $pb.PbList<ClubsEventOut>();
  @$core.pragma('dart2js:noInline')
  static ClubsEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ClubsEventOut>(create);
  static ClubsEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Club> get club => $_getList(0);
}

class SeatingContent extends $pb.GeneratedMessage {
  factory SeatingContent({
    $core.Iterable<PlayerRole>? roles,
    $core.Iterable<PlayerStatus>? status,
    $core.Iterable<$core.String>? images,
    $core.Iterable<$core.String>? names,
    $core.int? game,
    $core.int? totalGames,
  }) {
    final result = create();
    if (roles != null) result.roles.addAll(roles);
    if (status != null) result.status.addAll(status);
    if (images != null) result.images.addAll(images);
    if (names != null) result.names.addAll(names);
    if (game != null) result.game = game;
    if (totalGames != null) result.totalGames = totalGames;
    return result;
  }

  SeatingContent._();

  factory SeatingContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SeatingContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SeatingContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..pc<PlayerRole>(1, _omitFieldNames ? '' : 'roles', $pb.PbFieldType.KE,
        valueOf: PlayerRole.valueOf,
        enumValues: PlayerRole.values,
        defaultEnumValue: PlayerRole.citizen)
    ..pc<PlayerStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.KE,
        valueOf: PlayerStatus.valueOf,
        enumValues: PlayerStatus.values,
        defaultEnumValue: PlayerStatus.alive)
    ..pPS(3, _omitFieldNames ? '' : 'images')
    ..pPS(4, _omitFieldNames ? '' : 'names')
    ..aI(5, _omitFieldNames ? '' : 'game')
    ..aI(6, _omitFieldNames ? '' : 'totalGames', protoName: 'totalGames')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SeatingContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SeatingContent copyWith(void Function(SeatingContent) updates) =>
      super.copyWith((message) => updates(message as SeatingContent))
          as SeatingContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SeatingContent create() => SeatingContent._();
  @$core.override
  SeatingContent createEmptyInstance() => create();
  static $pb.PbList<SeatingContent> createRepeated() =>
      $pb.PbList<SeatingContent>();
  @$core.pragma('dart2js:noInline')
  static SeatingContent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SeatingContent>(create);
  static SeatingContent? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PlayerRole> get roles => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<PlayerStatus> get status => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get images => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get names => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get game => $_getIZ(4);
  @$pb.TagNumber(5)
  set game($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasGame() => $_has(4);
  @$pb.TagNumber(5)
  void clearGame() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get totalGames => $_getIZ(5);
  @$pb.TagNumber(6)
  set totalGames($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalGames() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalGames() => $_clearField(6);
}

class LoginByTokenEvent extends $pb.GeneratedMessage {
  factory LoginByTokenEvent({
    $core.String? token,
  }) {
    final result = create();
    if (token != null) result.token = token;
    return result;
  }

  LoginByTokenEvent._();

  factory LoginByTokenEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginByTokenEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginByTokenEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginByTokenEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginByTokenEvent copyWith(void Function(LoginByTokenEvent) updates) =>
      super.copyWith((message) => updates(message as LoginByTokenEvent))
          as LoginByTokenEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginByTokenEvent create() => LoginByTokenEvent._();
  @$core.override
  LoginByTokenEvent createEmptyInstance() => create();
  static $pb.PbList<LoginByTokenEvent> createRepeated() =>
      $pb.PbList<LoginByTokenEvent>();
  @$core.pragma('dart2js:noInline')
  static LoginByTokenEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginByTokenEvent>(create);
  static LoginByTokenEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);
}

class LoginByTokenEventOut extends $pb.GeneratedMessage {
  factory LoginByTokenEventOut({
    $core.String? token,
    $core.String? recoveryToken,
    LoginByTokenEventOut_Error? error,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (recoveryToken != null) result.recoveryToken = recoveryToken;
    if (error != null) result.error = error;
    return result;
  }

  LoginByTokenEventOut._();

  factory LoginByTokenEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginByTokenEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginByTokenEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'recoveryToken', protoName: 'recoveryToken')
    ..aE<LoginByTokenEventOut_Error>(3, _omitFieldNames ? '' : 'error',
        enumValues: LoginByTokenEventOut_Error.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginByTokenEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginByTokenEventOut copyWith(void Function(LoginByTokenEventOut) updates) =>
      super.copyWith((message) => updates(message as LoginByTokenEventOut))
          as LoginByTokenEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginByTokenEventOut create() => LoginByTokenEventOut._();
  @$core.override
  LoginByTokenEventOut createEmptyInstance() => create();
  static $pb.PbList<LoginByTokenEventOut> createRepeated() =>
      $pb.PbList<LoginByTokenEventOut>();
  @$core.pragma('dart2js:noInline')
  static LoginByTokenEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginByTokenEventOut>(create);
  static LoginByTokenEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get recoveryToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set recoveryToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRecoveryToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecoveryToken() => $_clearField(2);

  @$pb.TagNumber(3)
  LoginByTokenEventOut_Error get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(LoginByTokenEventOut_Error value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
}

class TournamentDescription extends $pb.GeneratedMessage {
  factory TournamentDescription({
    $core.String? gomafiaUrl,
    $core.String? vkGroupUrl,
    $core.String? vkOwnerUrl,
  }) {
    final result = create();
    if (gomafiaUrl != null) result.gomafiaUrl = gomafiaUrl;
    if (vkGroupUrl != null) result.vkGroupUrl = vkGroupUrl;
    if (vkOwnerUrl != null) result.vkOwnerUrl = vkOwnerUrl;
    return result;
  }

  TournamentDescription._();

  factory TournamentDescription.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TournamentDescription.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TournamentDescription',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'gomafiaUrl', protoName: 'gomafiaUrl')
    ..aOS(2, _omitFieldNames ? '' : 'vkGroupUrl', protoName: 'vkGroupUrl')
    ..aOS(3, _omitFieldNames ? '' : 'vkOwnerUrl', protoName: 'vkOwnerUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TournamentDescription clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TournamentDescription copyWith(
          void Function(TournamentDescription) updates) =>
      super.copyWith((message) => updates(message as TournamentDescription))
          as TournamentDescription;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TournamentDescription create() => TournamentDescription._();
  @$core.override
  TournamentDescription createEmptyInstance() => create();
  static $pb.PbList<TournamentDescription> createRepeated() =>
      $pb.PbList<TournamentDescription>();
  @$core.pragma('dart2js:noInline')
  static TournamentDescription getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TournamentDescription>(create);
  static TournamentDescription? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get gomafiaUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set gomafiaUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGomafiaUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearGomafiaUrl() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get vkGroupUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set vkGroupUrl($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVkGroupUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearVkGroupUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get vkOwnerUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set vkOwnerUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVkOwnerUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearVkOwnerUrl() => $_clearField(3);
}

class SignUpEvent extends $pb.GeneratedMessage {
  factory SignUpEvent({
    $core.String? email,
    $core.String? password,
  }) {
    final result = create();
    if (email != null) result.email = email;
    if (password != null) result.password = password;
    return result;
  }

  SignUpEvent._();

  factory SignUpEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SignUpEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignUpEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignUpEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignUpEvent copyWith(void Function(SignUpEvent) updates) =>
      super.copyWith((message) => updates(message as SignUpEvent))
          as SignUpEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignUpEvent create() => SignUpEvent._();
  @$core.override
  SignUpEvent createEmptyInstance() => create();
  static $pb.PbList<SignUpEvent> createRepeated() => $pb.PbList<SignUpEvent>();
  @$core.pragma('dart2js:noInline')
  static SignUpEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignUpEvent>(create);
  static SignUpEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);
}

class SignUpEventOut extends $pb.GeneratedMessage {
  factory SignUpEventOut({
    $core.String? token,
    $core.String? recoveryToken,
    SignUpEventOut_Error? error,
    $core.int? id,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (recoveryToken != null) result.recoveryToken = recoveryToken;
    if (error != null) result.error = error;
    if (id != null) result.id = id;
    return result;
  }

  SignUpEventOut._();

  factory SignUpEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SignUpEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignUpEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'recoveryToken', protoName: 'recoveryToken')
    ..aE<SignUpEventOut_Error>(3, _omitFieldNames ? '' : 'error',
        enumValues: SignUpEventOut_Error.values)
    ..aI(4, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignUpEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignUpEventOut copyWith(void Function(SignUpEventOut) updates) =>
      super.copyWith((message) => updates(message as SignUpEventOut))
          as SignUpEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignUpEventOut create() => SignUpEventOut._();
  @$core.override
  SignUpEventOut createEmptyInstance() => create();
  static $pb.PbList<SignUpEventOut> createRepeated() =>
      $pb.PbList<SignUpEventOut>();
  @$core.pragma('dart2js:noInline')
  static SignUpEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignUpEventOut>(create);
  static SignUpEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get recoveryToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set recoveryToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRecoveryToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecoveryToken() => $_clearField(2);

  @$pb.TagNumber(3)
  SignUpEventOut_Error get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(SignUpEventOut_Error value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get id => $_getIZ(3);
  @$pb.TagNumber(4)
  set id($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasId() => $_has(3);
  @$pb.TagNumber(4)
  void clearId() => $_clearField(4);
}

class EmailVerificationEvent extends $pb.GeneratedMessage {
  factory EmailVerificationEvent({
    $core.int? id,
    $core.String? token,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (token != null) result.token = token;
    return result;
  }

  EmailVerificationEvent._();

  factory EmailVerificationEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EmailVerificationEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EmailVerificationEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmailVerificationEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmailVerificationEvent copyWith(
          void Function(EmailVerificationEvent) updates) =>
      super.copyWith((message) => updates(message as EmailVerificationEvent))
          as EmailVerificationEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailVerificationEvent create() => EmailVerificationEvent._();
  @$core.override
  EmailVerificationEvent createEmptyInstance() => create();
  static $pb.PbList<EmailVerificationEvent> createRepeated() =>
      $pb.PbList<EmailVerificationEvent>();
  @$core.pragma('dart2js:noInline')
  static EmailVerificationEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EmailVerificationEvent>(create);
  static EmailVerificationEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(2)
  set token($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearToken() => $_clearField(2);
}

class CreateTournamentEvent extends $pb.GeneratedMessage {
  factory CreateTournamentEvent({
    $core.String? name,
    $core.String? dateStart,
    $core.String? dateEnd,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (dateStart != null) result.dateStart = dateStart;
    if (dateEnd != null) result.dateEnd = dateEnd;
    return result;
  }

  CreateTournamentEvent._();

  factory CreateTournamentEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateTournamentEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTournamentEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'dateStart', protoName: 'dateStart')
    ..aOS(3, _omitFieldNames ? '' : 'dateEnd', protoName: 'dateEnd')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTournamentEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTournamentEvent copyWith(
          void Function(CreateTournamentEvent) updates) =>
      super.copyWith((message) => updates(message as CreateTournamentEvent))
          as CreateTournamentEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTournamentEvent create() => CreateTournamentEvent._();
  @$core.override
  CreateTournamentEvent createEmptyInstance() => create();
  static $pb.PbList<CreateTournamentEvent> createRepeated() =>
      $pb.PbList<CreateTournamentEvent>();
  @$core.pragma('dart2js:noInline')
  static CreateTournamentEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTournamentEvent>(create);
  static CreateTournamentEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get dateStart => $_getSZ(1);
  @$pb.TagNumber(2)
  set dateStart($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDateStart() => $_has(1);
  @$pb.TagNumber(2)
  void clearDateStart() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get dateEnd => $_getSZ(2);
  @$pb.TagNumber(3)
  set dateEnd($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDateEnd() => $_has(2);
  @$pb.TagNumber(3)
  void clearDateEnd() => $_clearField(3);
}

class CreateTournamentEventOut extends $pb.GeneratedMessage {
  factory CreateTournamentEventOut({
    $core.int? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  CreateTournamentEventOut._();

  factory CreateTournamentEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateTournamentEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTournamentEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTournamentEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTournamentEventOut copyWith(
          void Function(CreateTournamentEventOut) updates) =>
      super.copyWith((message) => updates(message as CreateTournamentEventOut))
          as CreateTournamentEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTournamentEventOut create() => CreateTournamentEventOut._();
  @$core.override
  CreateTournamentEventOut createEmptyInstance() => create();
  static $pb.PbList<CreateTournamentEventOut> createRepeated() =>
      $pb.PbList<CreateTournamentEventOut>();
  @$core.pragma('dart2js:noInline')
  static CreateTournamentEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTournamentEventOut>(create);
  static CreateTournamentEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class AddPlayerEvent extends $pb.GeneratedMessage {
  factory AddPlayerEvent({
    Player? player,
  }) {
    final result = create();
    if (player != null) result.player = player;
    return result;
  }

  AddPlayerEvent._();

  factory AddPlayerEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddPlayerEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddPlayerEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOM<Player>(1, _omitFieldNames ? '' : 'player', subBuilder: Player.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddPlayerEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddPlayerEvent copyWith(void Function(AddPlayerEvent) updates) =>
      super.copyWith((message) => updates(message as AddPlayerEvent))
          as AddPlayerEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddPlayerEvent create() => AddPlayerEvent._();
  @$core.override
  AddPlayerEvent createEmptyInstance() => create();
  static $pb.PbList<AddPlayerEvent> createRepeated() =>
      $pb.PbList<AddPlayerEvent>();
  @$core.pragma('dart2js:noInline')
  static AddPlayerEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddPlayerEvent>(create);
  static AddPlayerEvent? _defaultInstance;

  @$pb.TagNumber(1)
  Player get player => $_getN(0);
  @$pb.TagNumber(1)
  set player(Player value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPlayer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer() => $_clearField(1);
  @$pb.TagNumber(1)
  Player ensurePlayer() => $_ensure(0);
}

class CannotMeetEditionEvent extends $pb.GeneratedMessage {
  factory CannotMeetEditionEvent({
    Player? player1,
    Player? player2,
  }) {
    final result = create();
    if (player1 != null) result.player1 = player1;
    if (player2 != null) result.player2 = player2;
    return result;
  }

  CannotMeetEditionEvent._();

  factory CannotMeetEditionEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CannotMeetEditionEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CannotMeetEditionEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOM<Player>(1, _omitFieldNames ? '' : 'player1',
        subBuilder: Player.create)
    ..aOM<Player>(2, _omitFieldNames ? '' : 'player2',
        subBuilder: Player.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CannotMeetEditionEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CannotMeetEditionEvent copyWith(
          void Function(CannotMeetEditionEvent) updates) =>
      super.copyWith((message) => updates(message as CannotMeetEditionEvent))
          as CannotMeetEditionEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CannotMeetEditionEvent create() => CannotMeetEditionEvent._();
  @$core.override
  CannotMeetEditionEvent createEmptyInstance() => create();
  static $pb.PbList<CannotMeetEditionEvent> createRepeated() =>
      $pb.PbList<CannotMeetEditionEvent>();
  @$core.pragma('dart2js:noInline')
  static CannotMeetEditionEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CannotMeetEditionEvent>(create);
  static CannotMeetEditionEvent? _defaultInstance;

  @$pb.TagNumber(1)
  Player get player1 => $_getN(0);
  @$pb.TagNumber(1)
  set player1(Player value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPlayer1() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer1() => $_clearField(1);
  @$pb.TagNumber(1)
  Player ensurePlayer1() => $_ensure(0);

  @$pb.TagNumber(2)
  Player get player2 => $_getN(1);
  @$pb.TagNumber(2)
  set player2(Player value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPlayer2() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlayer2() => $_clearField(2);
  @$pb.TagNumber(2)
  Player ensurePlayer2() => $_ensure(1);
}

class CannotMeetEventOut extends $pb.GeneratedMessage {
  factory CannotMeetEventOut({
    $core.Iterable<CannotMeetEditionEvent>? pairs,
  }) {
    final result = create();
    if (pairs != null) result.pairs.addAll(pairs);
    return result;
  }

  CannotMeetEventOut._();

  factory CannotMeetEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CannotMeetEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CannotMeetEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..pPM<CannotMeetEditionEvent>(1, _omitFieldNames ? '' : 'pairs',
        subBuilder: CannotMeetEditionEvent.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CannotMeetEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CannotMeetEventOut copyWith(void Function(CannotMeetEventOut) updates) =>
      super.copyWith((message) => updates(message as CannotMeetEventOut))
          as CannotMeetEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CannotMeetEventOut create() => CannotMeetEventOut._();
  @$core.override
  CannotMeetEventOut createEmptyInstance() => create();
  static $pb.PbList<CannotMeetEventOut> createRepeated() =>
      $pb.PbList<CannotMeetEventOut>();
  @$core.pragma('dart2js:noInline')
  static CannotMeetEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CannotMeetEventOut>(create);
  static CannotMeetEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CannotMeetEditionEvent> get pairs => $_getList(0);
}

class GetAvailablePlayerEventOut extends $pb.GeneratedMessage {
  factory GetAvailablePlayerEventOut({
    $core.Iterable<Player>? players,
  }) {
    final result = create();
    if (players != null) result.players.addAll(players);
    return result;
  }

  GetAvailablePlayerEventOut._();

  factory GetAvailablePlayerEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAvailablePlayerEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAvailablePlayerEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..pPM<Player>(1, _omitFieldNames ? '' : 'players',
        subBuilder: Player.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAvailablePlayerEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAvailablePlayerEventOut copyWith(
          void Function(GetAvailablePlayerEventOut) updates) =>
      super.copyWith(
              (message) => updates(message as GetAvailablePlayerEventOut))
          as GetAvailablePlayerEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAvailablePlayerEventOut create() => GetAvailablePlayerEventOut._();
  @$core.override
  GetAvailablePlayerEventOut createEmptyInstance() => create();
  static $pb.PbList<GetAvailablePlayerEventOut> createRepeated() =>
      $pb.PbList<GetAvailablePlayerEventOut>();
  @$core.pragma('dart2js:noInline')
  static GetAvailablePlayerEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAvailablePlayerEventOut>(create);
  static GetAvailablePlayerEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Player> get players => $_getList(0);
}

class TournamentSettings extends $pb.GeneratedMessage {
  factory TournamentSettings({
    $core.int? defaultGamesCount,
    $core.int? swissGamesCount,
    $core.int? finalGamesCount,
    $core.Iterable<$core.int>? buckets,
    $core.bool? hideResult,
  }) {
    final result = create();
    if (defaultGamesCount != null) result.defaultGamesCount = defaultGamesCount;
    if (swissGamesCount != null) result.swissGamesCount = swissGamesCount;
    if (finalGamesCount != null) result.finalGamesCount = finalGamesCount;
    if (buckets != null) result.buckets.addAll(buckets);
    if (hideResult != null) result.hideResult = hideResult;
    return result;
  }

  TournamentSettings._();

  factory TournamentSettings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TournamentSettings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TournamentSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'defaultGamesCount',
        protoName: 'defaultGamesCount')
    ..aI(2, _omitFieldNames ? '' : 'swissGamesCount',
        protoName: 'swissGamesCount')
    ..aI(3, _omitFieldNames ? '' : 'finalGamesCount',
        protoName: 'finalGamesCount')
    ..p<$core.int>(4, _omitFieldNames ? '' : 'buckets', $pb.PbFieldType.K3)
    ..aOB(5, _omitFieldNames ? '' : 'hideResult', protoName: 'hideResult')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TournamentSettings clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TournamentSettings copyWith(void Function(TournamentSettings) updates) =>
      super.copyWith((message) => updates(message as TournamentSettings))
          as TournamentSettings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TournamentSettings create() => TournamentSettings._();
  @$core.override
  TournamentSettings createEmptyInstance() => create();
  static $pb.PbList<TournamentSettings> createRepeated() =>
      $pb.PbList<TournamentSettings>();
  @$core.pragma('dart2js:noInline')
  static TournamentSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TournamentSettings>(create);
  static TournamentSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get defaultGamesCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set defaultGamesCount($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDefaultGamesCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearDefaultGamesCount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get swissGamesCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set swissGamesCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSwissGamesCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearSwissGamesCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get finalGamesCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set finalGamesCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFinalGamesCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearFinalGamesCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.int> get buckets => $_getList(3);

  @$pb.TagNumber(5)
  $core.bool get hideResult => $_getBF(4);
  @$pb.TagNumber(5)
  set hideResult($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHideResult() => $_has(4);
  @$pb.TagNumber(5)
  void clearHideResult() => $_clearField(5);
}

class Profile extends $pb.GeneratedMessage {
  factory Profile({
    $core.String? firstName,
    $core.String? secondName,
  }) {
    final result = create();
    if (firstName != null) result.firstName = firstName;
    if (secondName != null) result.secondName = secondName;
    return result;
  }

  Profile._();

  factory Profile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Profile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Profile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'firstName', protoName: 'firstName')
    ..aOS(2, _omitFieldNames ? '' : 'secondName', protoName: 'secondName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Profile clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Profile copyWith(void Function(Profile) updates) =>
      super.copyWith((message) => updates(message as Profile)) as Profile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Profile create() => Profile._();
  @$core.override
  Profile createEmptyInstance() => create();
  static $pb.PbList<Profile> createRepeated() => $pb.PbList<Profile>();
  @$core.pragma('dart2js:noInline')
  static Profile getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Profile>(create);
  static Profile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firstName => $_getSZ(0);
  @$pb.TagNumber(1)
  set firstName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFirstName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get secondName => $_getSZ(1);
  @$pb.TagNumber(2)
  set secondName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSecondName() => $_has(1);
  @$pb.TagNumber(2)
  void clearSecondName() => $_clearField(2);
}

class CreatePlayerEventOut extends $pb.GeneratedMessage {
  factory CreatePlayerEventOut({
    $core.int? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  CreatePlayerEventOut._();

  factory CreatePlayerEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreatePlayerEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreatePlayerEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePlayerEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePlayerEventOut copyWith(void Function(CreatePlayerEventOut) updates) =>
      super.copyWith((message) => updates(message as CreatePlayerEventOut))
          as CreatePlayerEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePlayerEventOut create() => CreatePlayerEventOut._();
  @$core.override
  CreatePlayerEventOut createEmptyInstance() => create();
  static $pb.PbList<CreatePlayerEventOut> createRepeated() =>
      $pb.PbList<CreatePlayerEventOut>();
  @$core.pragma('dart2js:noInline')
  static CreatePlayerEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreatePlayerEventOut>(create);
  static CreatePlayerEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class CreatePlayerEvent extends $pb.GeneratedMessage {
  factory CreatePlayerEvent({
    Player? player,
  }) {
    final result = create();
    if (player != null) result.player = player;
    return result;
  }

  CreatePlayerEvent._();

  factory CreatePlayerEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreatePlayerEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreatePlayerEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOM<Player>(1, _omitFieldNames ? '' : 'player', subBuilder: Player.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePlayerEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePlayerEvent copyWith(void Function(CreatePlayerEvent) updates) =>
      super.copyWith((message) => updates(message as CreatePlayerEvent))
          as CreatePlayerEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePlayerEvent create() => CreatePlayerEvent._();
  @$core.override
  CreatePlayerEvent createEmptyInstance() => create();
  static $pb.PbList<CreatePlayerEvent> createRepeated() =>
      $pb.PbList<CreatePlayerEvent>();
  @$core.pragma('dart2js:noInline')
  static CreatePlayerEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreatePlayerEvent>(create);
  static CreatePlayerEvent? _defaultInstance;

  @$pb.TagNumber(1)
  Player get player => $_getN(0);
  @$pb.TagNumber(1)
  set player(Player value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPlayer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer() => $_clearField(1);
  @$pb.TagNumber(1)
  Player ensurePlayer() => $_ensure(0);
}

class Player extends $pb.GeneratedMessage {
  factory Player({
    $core.int? id,
    $core.String? nickname,
    $core.String? fsmNickname,
    $core.String? mafbankNickname,
    $core.String? image,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (nickname != null) result.nickname = nickname;
    if (fsmNickname != null) result.fsmNickname = fsmNickname;
    if (mafbankNickname != null) result.mafbankNickname = mafbankNickname;
    if (image != null) result.image = image;
    return result;
  }

  Player._();

  factory Player.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Player.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Player',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'nickname')
    ..aOS(3, _omitFieldNames ? '' : 'fsmNickname', protoName: 'fsmNickname')
    ..aOS(4, _omitFieldNames ? '' : 'mafbankNickname',
        protoName: 'mafbankNickname')
    ..aOS(5, _omitFieldNames ? '' : 'image')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Player clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Player copyWith(void Function(Player) updates) =>
      super.copyWith((message) => updates(message as Player)) as Player;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Player create() => Player._();
  @$core.override
  Player createEmptyInstance() => create();
  static $pb.PbList<Player> createRepeated() => $pb.PbList<Player>();
  @$core.pragma('dart2js:noInline')
  static Player getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Player>(create);
  static Player? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get nickname => $_getSZ(1);
  @$pb.TagNumber(2)
  set nickname($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNickname() => $_has(1);
  @$pb.TagNumber(2)
  void clearNickname() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get fsmNickname => $_getSZ(2);
  @$pb.TagNumber(3)
  set fsmNickname($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFsmNickname() => $_has(2);
  @$pb.TagNumber(3)
  void clearFsmNickname() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get mafbankNickname => $_getSZ(3);
  @$pb.TagNumber(4)
  set mafbankNickname($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMafbankNickname() => $_has(3);
  @$pb.TagNumber(4)
  void clearMafbankNickname() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get image => $_getSZ(4);
  @$pb.TagNumber(5)
  set image($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasImage() => $_has(4);
  @$pb.TagNumber(5)
  void clearImage() => $_clearField(5);
}

class CreateSwissRound extends $pb.GeneratedMessage {
  factory CreateSwissRound({
    $core.int? game,
  }) {
    final result = create();
    if (game != null) result.game = game;
    return result;
  }

  CreateSwissRound._();

  factory CreateSwissRound.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateSwissRound.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateSwissRound',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'game')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateSwissRound clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateSwissRound copyWith(void Function(CreateSwissRound) updates) =>
      super.copyWith((message) => updates(message as CreateSwissRound))
          as CreateSwissRound;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateSwissRound create() => CreateSwissRound._();
  @$core.override
  CreateSwissRound createEmptyInstance() => create();
  static $pb.PbList<CreateSwissRound> createRepeated() =>
      $pb.PbList<CreateSwissRound>();
  @$core.pragma('dart2js:noInline')
  static CreateSwissRound getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateSwissRound>(create);
  static CreateSwissRound? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get game => $_getIZ(0);
  @$pb.TagNumber(1)
  set game($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGame() => $_has(0);
  @$pb.TagNumber(1)
  void clearGame() => $_clearField(1);
}

class EmailVerificationEventOut extends $pb.GeneratedMessage {
  factory EmailVerificationEventOut({
    EmailVerificationEventOut_Status? status,
  }) {
    final result = create();
    if (status != null) result.status = status;
    return result;
  }

  EmailVerificationEventOut._();

  factory EmailVerificationEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EmailVerificationEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EmailVerificationEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aE<EmailVerificationEventOut_Status>(1, _omitFieldNames ? '' : 'status',
        enumValues: EmailVerificationEventOut_Status.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmailVerificationEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmailVerificationEventOut copyWith(
          void Function(EmailVerificationEventOut) updates) =>
      super.copyWith((message) => updates(message as EmailVerificationEventOut))
          as EmailVerificationEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailVerificationEventOut create() => EmailVerificationEventOut._();
  @$core.override
  EmailVerificationEventOut createEmptyInstance() => create();
  static $pb.PbList<EmailVerificationEventOut> createRepeated() =>
      $pb.PbList<EmailVerificationEventOut>();
  @$core.pragma('dart2js:noInline')
  static EmailVerificationEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EmailVerificationEventOut>(create);
  static EmailVerificationEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  EmailVerificationEventOut_Status get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(EmailVerificationEventOut_Status value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class GetFinalPlayersOut extends $pb.GeneratedMessage {
  factory GetFinalPlayersOut({
    $core.Iterable<Player>? player,
  }) {
    final result = create();
    if (player != null) result.player.addAll(player);
    return result;
  }

  GetFinalPlayersOut._();

  factory GetFinalPlayersOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFinalPlayersOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFinalPlayersOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..pPM<Player>(1, _omitFieldNames ? '' : 'player', subBuilder: Player.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFinalPlayersOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFinalPlayersOut copyWith(void Function(GetFinalPlayersOut) updates) =>
      super.copyWith((message) => updates(message as GetFinalPlayersOut))
          as GetFinalPlayersOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFinalPlayersOut create() => GetFinalPlayersOut._();
  @$core.override
  GetFinalPlayersOut createEmptyInstance() => create();
  static $pb.PbList<GetFinalPlayersOut> createRepeated() =>
      $pb.PbList<GetFinalPlayersOut>();
  @$core.pragma('dart2js:noInline')
  static GetFinalPlayersOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFinalPlayersOut>(create);
  static GetFinalPlayersOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Player> get player => $_getList(0);
}

class SeatingForTranslationEvent extends $pb.GeneratedMessage {
  factory SeatingForTranslationEvent({
    $core.int? tournamentId,
    $core.int? table,
    $core.int? game,
  }) {
    final result = create();
    if (tournamentId != null) result.tournamentId = tournamentId;
    if (table != null) result.table = table;
    if (game != null) result.game = game;
    return result;
  }

  SeatingForTranslationEvent._();

  factory SeatingForTranslationEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SeatingForTranslationEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SeatingForTranslationEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'tournamentId', protoName: 'tournamentId')
    ..aI(2, _omitFieldNames ? '' : 'table')
    ..aI(3, _omitFieldNames ? '' : 'game')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SeatingForTranslationEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SeatingForTranslationEvent copyWith(
          void Function(SeatingForTranslationEvent) updates) =>
      super.copyWith(
              (message) => updates(message as SeatingForTranslationEvent))
          as SeatingForTranslationEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SeatingForTranslationEvent create() => SeatingForTranslationEvent._();
  @$core.override
  SeatingForTranslationEvent createEmptyInstance() => create();
  static $pb.PbList<SeatingForTranslationEvent> createRepeated() =>
      $pb.PbList<SeatingForTranslationEvent>();
  @$core.pragma('dart2js:noInline')
  static SeatingForTranslationEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SeatingForTranslationEvent>(create);
  static SeatingForTranslationEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get tournamentId => $_getIZ(0);
  @$pb.TagNumber(1)
  set tournamentId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTournamentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTournamentId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get table => $_getIZ(1);
  @$pb.TagNumber(2)
  set table($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTable() => $_has(1);
  @$pb.TagNumber(2)
  void clearTable() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get game => $_getIZ(2);
  @$pb.TagNumber(3)
  set game($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasGame() => $_has(2);
  @$pb.TagNumber(3)
  void clearGame() => $_clearField(3);
}

class SeatingForTranslationEventOut extends $pb.GeneratedMessage {
  factory SeatingForTranslationEventOut({
    $core.Iterable<$core.String>? players,
  }) {
    final result = create();
    if (players != null) result.players.addAll(players);
    return result;
  }

  SeatingForTranslationEventOut._();

  factory SeatingForTranslationEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SeatingForTranslationEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SeatingForTranslationEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'players')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SeatingForTranslationEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SeatingForTranslationEventOut copyWith(
          void Function(SeatingForTranslationEventOut) updates) =>
      super.copyWith(
              (message) => updates(message as SeatingForTranslationEventOut))
          as SeatingForTranslationEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SeatingForTranslationEventOut create() =>
      SeatingForTranslationEventOut._();
  @$core.override
  SeatingForTranslationEventOut createEmptyInstance() => create();
  static $pb.PbList<SeatingForTranslationEventOut> createRepeated() =>
      $pb.PbList<SeatingForTranslationEventOut>();
  @$core.pragma('dart2js:noInline')
  static SeatingForTranslationEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SeatingForTranslationEventOut>(create);
  static SeatingForTranslationEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get players => $_getList(0);
}

class InsertSeatingEvent extends $pb.GeneratedMessage {
  factory InsertSeatingEvent({
    $core.List<$core.int>? bytes,
    $core.int? tournamentId,
  }) {
    final result = create();
    if (bytes != null) result.bytes = bytes;
    if (tournamentId != null) result.tournamentId = tournamentId;
    return result;
  }

  InsertSeatingEvent._();

  factory InsertSeatingEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsertSeatingEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsertSeatingEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'bytes', $pb.PbFieldType.OY)
    ..aI(2, _omitFieldNames ? '' : 'tournamentId', protoName: 'tournamentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsertSeatingEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsertSeatingEvent copyWith(void Function(InsertSeatingEvent) updates) =>
      super.copyWith((message) => updates(message as InsertSeatingEvent))
          as InsertSeatingEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsertSeatingEvent create() => InsertSeatingEvent._();
  @$core.override
  InsertSeatingEvent createEmptyInstance() => create();
  static $pb.PbList<InsertSeatingEvent> createRepeated() =>
      $pb.PbList<InsertSeatingEvent>();
  @$core.pragma('dart2js:noInline')
  static InsertSeatingEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsertSeatingEvent>(create);
  static InsertSeatingEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get bytes => $_getN(0);
  @$pb.TagNumber(1)
  set bytes($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBytes() => $_has(0);
  @$pb.TagNumber(1)
  void clearBytes() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get tournamentId => $_getIZ(1);
  @$pb.TagNumber(2)
  set tournamentId($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTournamentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTournamentId() => $_clearField(2);
}

class GetTournamentsEventOut extends $pb.GeneratedMessage {
  factory GetTournamentsEventOut({
    $core.Iterable<Tournament>? tournaments,
  }) {
    final result = create();
    if (tournaments != null) result.tournaments.addAll(tournaments);
    return result;
  }

  GetTournamentsEventOut._();

  factory GetTournamentsEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTournamentsEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTournamentsEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..pPM<Tournament>(1, _omitFieldNames ? '' : 'tournaments',
        subBuilder: Tournament.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTournamentsEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTournamentsEventOut copyWith(
          void Function(GetTournamentsEventOut) updates) =>
      super.copyWith((message) => updates(message as GetTournamentsEventOut))
          as GetTournamentsEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTournamentsEventOut create() => GetTournamentsEventOut._();
  @$core.override
  GetTournamentsEventOut createEmptyInstance() => create();
  static $pb.PbList<GetTournamentsEventOut> createRepeated() =>
      $pb.PbList<GetTournamentsEventOut>();
  @$core.pragma('dart2js:noInline')
  static GetTournamentsEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTournamentsEventOut>(create);
  static GetTournamentsEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Tournament> get tournaments => $_getList(0);
}

class Tournament extends $pb.GeneratedMessage {
  factory Tournament({
    $core.int? id,
    $core.String? name,
    Tournament_Status? status,
    $core.String? dateStart,
    $core.String? dateEnd,
    $core.int? gamesCount,
    $core.int? billedPlayers,
    $core.bool? billedTranslation,
    $core.bool? notificationEnabled,
    TournamentDescription? description,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (status != null) result.status = status;
    if (dateStart != null) result.dateStart = dateStart;
    if (dateEnd != null) result.dateEnd = dateEnd;
    if (gamesCount != null) result.gamesCount = gamesCount;
    if (billedPlayers != null) result.billedPlayers = billedPlayers;
    if (billedTranslation != null) result.billedTranslation = billedTranslation;
    if (notificationEnabled != null)
      result.notificationEnabled = notificationEnabled;
    if (description != null) result.description = description;
    return result;
  }

  Tournament._();

  factory Tournament.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Tournament.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Tournament',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aE<Tournament_Status>(3, _omitFieldNames ? '' : 'status',
        enumValues: Tournament_Status.values)
    ..aOS(4, _omitFieldNames ? '' : 'dateStart', protoName: 'dateStart')
    ..aOS(5, _omitFieldNames ? '' : 'dateEnd', protoName: 'dateEnd')
    ..aI(6, _omitFieldNames ? '' : 'gamesCount', protoName: 'gamesCount')
    ..aI(7, _omitFieldNames ? '' : 'billedPlayers', protoName: 'billedPlayers')
    ..aOB(8, _omitFieldNames ? '' : 'billedTranslation',
        protoName: 'billedTranslation')
    ..aOB(9, _omitFieldNames ? '' : 'notificationEnabled',
        protoName: 'notificationEnabled')
    ..aOM<TournamentDescription>(10, _omitFieldNames ? '' : 'description',
        subBuilder: TournamentDescription.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Tournament clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Tournament copyWith(void Function(Tournament) updates) =>
      super.copyWith((message) => updates(message as Tournament)) as Tournament;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Tournament create() => Tournament._();
  @$core.override
  Tournament createEmptyInstance() => create();
  static $pb.PbList<Tournament> createRepeated() => $pb.PbList<Tournament>();
  @$core.pragma('dart2js:noInline')
  static Tournament getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Tournament>(create);
  static Tournament? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  Tournament_Status get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(Tournament_Status value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get dateStart => $_getSZ(3);
  @$pb.TagNumber(4)
  set dateStart($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDateStart() => $_has(3);
  @$pb.TagNumber(4)
  void clearDateStart() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get dateEnd => $_getSZ(4);
  @$pb.TagNumber(5)
  set dateEnd($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDateEnd() => $_has(4);
  @$pb.TagNumber(5)
  void clearDateEnd() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get gamesCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set gamesCount($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasGamesCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearGamesCount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get billedPlayers => $_getIZ(6);
  @$pb.TagNumber(7)
  set billedPlayers($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBilledPlayers() => $_has(6);
  @$pb.TagNumber(7)
  void clearBilledPlayers() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get billedTranslation => $_getBF(7);
  @$pb.TagNumber(8)
  set billedTranslation($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBilledTranslation() => $_has(7);
  @$pb.TagNumber(8)
  void clearBilledTranslation() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get notificationEnabled => $_getBF(8);
  @$pb.TagNumber(9)
  set notificationEnabled($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasNotificationEnabled() => $_has(8);
  @$pb.TagNumber(9)
  void clearNotificationEnabled() => $_clearField(9);

  @$pb.TagNumber(10)
  TournamentDescription get description => $_getN(9);
  @$pb.TagNumber(10)
  set description(TournamentDescription value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescription() => $_clearField(10);
  @$pb.TagNumber(10)
  TournamentDescription ensureDescription() => $_ensure(9);
}

class ErrorOut extends $pb.GeneratedMessage {
  factory ErrorOut({
    $core.String? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  ErrorOut._();

  factory ErrorOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ErrorOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ErrorOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ErrorOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ErrorOut copyWith(void Function(ErrorOut) updates) =>
      super.copyWith((message) => updates(message as ErrorOut)) as ErrorOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ErrorOut create() => ErrorOut._();
  @$core.override
  ErrorOut createEmptyInstance() => create();
  static $pb.PbList<ErrorOut> createRepeated() => $pb.PbList<ErrorOut>();
  @$core.pragma('dart2js:noInline')
  static ErrorOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ErrorOut>(create);
  static ErrorOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

class BillTournamentEvent extends $pb.GeneratedMessage {
  factory BillTournamentEvent({
    $core.int? players,
    $core.bool? hasTranslation,
    $core.String? redirectPath,
  }) {
    final result = create();
    if (players != null) result.players = players;
    if (hasTranslation != null) result.hasTranslation = hasTranslation;
    if (redirectPath != null) result.redirectPath = redirectPath;
    return result;
  }

  BillTournamentEvent._();

  factory BillTournamentEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BillTournamentEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BillTournamentEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'players')
    ..aOB(2, _omitFieldNames ? '' : 'hasTranslation',
        protoName: 'hasTranslation')
    ..aOS(3, _omitFieldNames ? '' : 'redirectPath', protoName: 'redirectPath')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BillTournamentEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BillTournamentEvent copyWith(void Function(BillTournamentEvent) updates) =>
      super.copyWith((message) => updates(message as BillTournamentEvent))
          as BillTournamentEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BillTournamentEvent create() => BillTournamentEvent._();
  @$core.override
  BillTournamentEvent createEmptyInstance() => create();
  static $pb.PbList<BillTournamentEvent> createRepeated() =>
      $pb.PbList<BillTournamentEvent>();
  @$core.pragma('dart2js:noInline')
  static BillTournamentEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BillTournamentEvent>(create);
  static BillTournamentEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get players => $_getIZ(0);
  @$pb.TagNumber(1)
  set players($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPlayers() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayers() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get hasTranslation => $_getBF(1);
  @$pb.TagNumber(2)
  set hasTranslation($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasHasTranslation() => $_has(1);
  @$pb.TagNumber(2)
  void clearHasTranslation() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get redirectPath => $_getSZ(2);
  @$pb.TagNumber(3)
  set redirectPath($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRedirectPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearRedirectPath() => $_clearField(3);
}

class BillClubEvent extends $pb.GeneratedMessage {
  factory BillClubEvent({
    $core.int? days,
    $core.String? redirectPath,
  }) {
    final result = create();
    if (days != null) result.days = days;
    if (redirectPath != null) result.redirectPath = redirectPath;
    return result;
  }

  BillClubEvent._();

  factory BillClubEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BillClubEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BillClubEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'days')
    ..aOS(2, _omitFieldNames ? '' : 'redirectPath', protoName: 'redirectPath')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BillClubEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BillClubEvent copyWith(void Function(BillClubEvent) updates) =>
      super.copyWith((message) => updates(message as BillClubEvent))
          as BillClubEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BillClubEvent create() => BillClubEvent._();
  @$core.override
  BillClubEvent createEmptyInstance() => create();
  static $pb.PbList<BillClubEvent> createRepeated() =>
      $pb.PbList<BillClubEvent>();
  @$core.pragma('dart2js:noInline')
  static BillClubEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BillClubEvent>(create);
  static BillClubEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get days => $_getIZ(0);
  @$pb.TagNumber(1)
  set days($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDays() => $_has(0);
  @$pb.TagNumber(1)
  void clearDays() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get redirectPath => $_getSZ(1);
  @$pb.TagNumber(2)
  set redirectPath($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRedirectPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearRedirectPath() => $_clearField(2);
}

class BillTournamentEventOut extends $pb.GeneratedMessage {
  factory BillTournamentEventOut({
    $core.String? redirectLink,
  }) {
    final result = create();
    if (redirectLink != null) result.redirectLink = redirectLink;
    return result;
  }

  BillTournamentEventOut._();

  factory BillTournamentEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BillTournamentEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BillTournamentEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'redirectLink', protoName: 'redirectLink')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BillTournamentEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BillTournamentEventOut copyWith(
          void Function(BillTournamentEventOut) updates) =>
      super.copyWith((message) => updates(message as BillTournamentEventOut))
          as BillTournamentEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BillTournamentEventOut create() => BillTournamentEventOut._();
  @$core.override
  BillTournamentEventOut createEmptyInstance() => create();
  static $pb.PbList<BillTournamentEventOut> createRepeated() =>
      $pb.PbList<BillTournamentEventOut>();
  @$core.pragma('dart2js:noInline')
  static BillTournamentEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BillTournamentEventOut>(create);
  static BillTournamentEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get redirectLink => $_getSZ(0);
  @$pb.TagNumber(1)
  set redirectLink($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRedirectLink() => $_has(0);
  @$pb.TagNumber(1)
  void clearRedirectLink() => $_clearField(1);
}

class StartGameInfoEvent extends $pb.GeneratedMessage {
  factory StartGameInfoEvent({
    $core.int? game,
    $core.String? localDate,
  }) {
    final result = create();
    if (game != null) result.game = game;
    if (localDate != null) result.localDate = localDate;
    return result;
  }

  StartGameInfoEvent._();

  factory StartGameInfoEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StartGameInfoEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StartGameInfoEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'game')
    ..aOS(2, _omitFieldNames ? '' : 'localDate', protoName: 'localDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StartGameInfoEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StartGameInfoEvent copyWith(void Function(StartGameInfoEvent) updates) =>
      super.copyWith((message) => updates(message as StartGameInfoEvent))
          as StartGameInfoEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartGameInfoEvent create() => StartGameInfoEvent._();
  @$core.override
  StartGameInfoEvent createEmptyInstance() => create();
  static $pb.PbList<StartGameInfoEvent> createRepeated() =>
      $pb.PbList<StartGameInfoEvent>();
  @$core.pragma('dart2js:noInline')
  static StartGameInfoEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StartGameInfoEvent>(create);
  static StartGameInfoEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get game => $_getIZ(0);
  @$pb.TagNumber(1)
  set game($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGame() => $_has(0);
  @$pb.TagNumber(1)
  void clearGame() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get localDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set localDate($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLocalDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocalDate() => $_clearField(2);
}

class CustomTextInfoEvent extends $pb.GeneratedMessage {
  factory CustomTextInfoEvent({
    $core.String? text,
  }) {
    final result = create();
    if (text != null) result.text = text;
    return result;
  }

  CustomTextInfoEvent._();

  factory CustomTextInfoEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CustomTextInfoEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CustomTextInfoEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CustomTextInfoEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CustomTextInfoEvent copyWith(void Function(CustomTextInfoEvent) updates) =>
      super.copyWith((message) => updates(message as CustomTextInfoEvent))
          as CustomTextInfoEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CustomTextInfoEvent create() => CustomTextInfoEvent._();
  @$core.override
  CustomTextInfoEvent createEmptyInstance() => create();
  static $pb.PbList<CustomTextInfoEvent> createRepeated() =>
      $pb.PbList<CustomTextInfoEvent>();
  @$core.pragma('dart2js:noInline')
  static CustomTextInfoEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CustomTextInfoEvent>(create);
  static CustomTextInfoEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);
}

class TakeGomafiaSeatingEvent extends $pb.GeneratedMessage {
  factory TakeGomafiaSeatingEvent({
    $core.int? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  TakeGomafiaSeatingEvent._();

  factory TakeGomafiaSeatingEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TakeGomafiaSeatingEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TakeGomafiaSeatingEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TakeGomafiaSeatingEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TakeGomafiaSeatingEvent copyWith(
          void Function(TakeGomafiaSeatingEvent) updates) =>
      super.copyWith((message) => updates(message as TakeGomafiaSeatingEvent))
          as TakeGomafiaSeatingEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TakeGomafiaSeatingEvent create() => TakeGomafiaSeatingEvent._();
  @$core.override
  TakeGomafiaSeatingEvent createEmptyInstance() => create();
  static $pb.PbList<TakeGomafiaSeatingEvent> createRepeated() =>
      $pb.PbList<TakeGomafiaSeatingEvent>();
  @$core.pragma('dart2js:noInline')
  static TakeGomafiaSeatingEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TakeGomafiaSeatingEvent>(create);
  static TakeGomafiaSeatingEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class TakeGomafiaSeatingEventOut extends $pb.GeneratedMessage {
  factory TakeGomafiaSeatingEventOut({
    $core.Iterable<$core.String>? notFound,
  }) {
    final result = create();
    if (notFound != null) result.notFound.addAll(notFound);
    return result;
  }

  TakeGomafiaSeatingEventOut._();

  factory TakeGomafiaSeatingEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TakeGomafiaSeatingEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TakeGomafiaSeatingEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'notFound', protoName: 'notFound')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TakeGomafiaSeatingEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TakeGomafiaSeatingEventOut copyWith(
          void Function(TakeGomafiaSeatingEventOut) updates) =>
      super.copyWith(
              (message) => updates(message as TakeGomafiaSeatingEventOut))
          as TakeGomafiaSeatingEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TakeGomafiaSeatingEventOut create() => TakeGomafiaSeatingEventOut._();
  @$core.override
  TakeGomafiaSeatingEventOut createEmptyInstance() => create();
  static $pb.PbList<TakeGomafiaSeatingEventOut> createRepeated() =>
      $pb.PbList<TakeGomafiaSeatingEventOut>();
  @$core.pragma('dart2js:noInline')
  static TakeGomafiaSeatingEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TakeGomafiaSeatingEventOut>(create);
  static TakeGomafiaSeatingEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get notFound => $_getList(0);
}

class User extends $pb.GeneratedMessage {
  factory User({
    $core.int? id,
    $core.String? email,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (email != null) result.email = email;
    return result;
  }

  User._();

  factory User.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory User.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'User',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User copyWith(void Function(User) updates) =>
      super.copyWith((message) => updates(message as User)) as User;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  @$core.override
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);
}

class TournamentOwnersEventOut extends $pb.GeneratedMessage {
  factory TournamentOwnersEventOut({
    $core.Iterable<User>? owners,
  }) {
    final result = create();
    if (owners != null) result.owners.addAll(owners);
    return result;
  }

  TournamentOwnersEventOut._();

  factory TournamentOwnersEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TournamentOwnersEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TournamentOwnersEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..pPM<User>(1, _omitFieldNames ? '' : 'owners', subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TournamentOwnersEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TournamentOwnersEventOut copyWith(
          void Function(TournamentOwnersEventOut) updates) =>
      super.copyWith((message) => updates(message as TournamentOwnersEventOut))
          as TournamentOwnersEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TournamentOwnersEventOut create() => TournamentOwnersEventOut._();
  @$core.override
  TournamentOwnersEventOut createEmptyInstance() => create();
  static $pb.PbList<TournamentOwnersEventOut> createRepeated() =>
      $pb.PbList<TournamentOwnersEventOut>();
  @$core.pragma('dart2js:noInline')
  static TournamentOwnersEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TournamentOwnersEventOut>(create);
  static TournamentOwnersEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<User> get owners => $_getList(0);
}

class UpdateOwnerEvent extends $pb.GeneratedMessage {
  factory UpdateOwnerEvent({
    $core.String? email,
  }) {
    final result = create();
    if (email != null) result.email = email;
    return result;
  }

  UpdateOwnerEvent._();

  factory UpdateOwnerEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateOwnerEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateOwnerEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateOwnerEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateOwnerEvent copyWith(void Function(UpdateOwnerEvent) updates) =>
      super.copyWith((message) => updates(message as UpdateOwnerEvent))
          as UpdateOwnerEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateOwnerEvent create() => UpdateOwnerEvent._();
  @$core.override
  UpdateOwnerEvent createEmptyInstance() => create();
  static $pb.PbList<UpdateOwnerEvent> createRepeated() =>
      $pb.PbList<UpdateOwnerEvent>();
  @$core.pragma('dart2js:noInline')
  static UpdateOwnerEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateOwnerEvent>(create);
  static UpdateOwnerEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);
}

class TranslationKeyEventOut extends $pb.GeneratedMessage {
  factory TranslationKeyEventOut({
    $core.String? key,
  }) {
    final result = create();
    if (key != null) result.key = key;
    return result;
  }

  TranslationKeyEventOut._();

  factory TranslationKeyEventOut.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TranslationKeyEventOut.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TranslationKeyEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TranslationKeyEventOut clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TranslationKeyEventOut copyWith(
          void Function(TranslationKeyEventOut) updates) =>
      super.copyWith((message) => updates(message as TranslationKeyEventOut))
          as TranslationKeyEventOut;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TranslationKeyEventOut create() => TranslationKeyEventOut._();
  @$core.override
  TranslationKeyEventOut createEmptyInstance() => create();
  static $pb.PbList<TranslationKeyEventOut> createRepeated() =>
      $pb.PbList<TranslationKeyEventOut>();
  @$core.pragma('dart2js:noInline')
  static TranslationKeyEventOut getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TranslationKeyEventOut>(create);
  static TranslationKeyEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
