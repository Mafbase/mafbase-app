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

import 'mafia.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'mafia.pbenum.dart';

class LoginEvent extends $pb.GeneratedMessage {
  factory LoginEvent({
    $core.String? email,
    $core.String? password,
  }) {
    final $result = create();
    if (email != null) {
      $result.email = email;
    }
    if (password != null) {
      $result.password = password;
    }
    return $result;
  }
  LoginEvent._() : super();
  factory LoginEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LoginEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LoginEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LoginEvent clone() => LoginEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LoginEvent copyWith(void Function(LoginEvent) updates) =>
      super.copyWith((message) => updates(message as LoginEvent)) as LoginEvent;

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
  set email($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) {
    $_setString(1, v);
  }

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
    final $result = create();
    if (nickname != null) {
      $result.nickname.addAll(nickname);
    }
    if (referee != null) {
      $result.referee = referee;
    }
    if (table != null) {
      $result.table = table;
    }
    return $result;
  }
  TableSeating._() : super();
  factory TableSeating.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TableSeating.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TableSeating',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'nickname')
    ..aOS(2, _omitFieldNames ? '' : 'referee')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'table', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TableSeating clone() => TableSeating()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TableSeating copyWith(void Function(TableSeating) updates) =>
      super.copyWith((message) => updates(message as TableSeating)) as TableSeating;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TableSeating create() => TableSeating._();
  TableSeating createEmptyInstance() => create();
  static $pb.PbList<TableSeating> createRepeated() => $pb.PbList<TableSeating>();
  @$core.pragma('dart2js:noInline')
  static TableSeating getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TableSeating>(create);
  static TableSeating? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get nickname => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get referee => $_getSZ(1);
  @$pb.TagNumber(2)
  set referee($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasReferee() => $_has(1);
  @$pb.TagNumber(2)
  void clearReferee() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get table => $_getIZ(2);
  @$pb.TagNumber(3)
  set table($core.int v) {
    $_setSignedInt32(2, v);
  }

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
    $core.Iterable<$core.double>? minusScore,
  }) {
    final $result = create();
    if (role != null) {
      $result.role.addAll(role);
    }
    if (score != null) {
      $result.score.addAll(score);
    }
    if (died != null) {
      $result.died = died;
    }
    if (win != null) {
      $result.win = win;
    }
    if (bestMove != null) {
      $result.bestMove = bestMove;
    }
    if (addScore != null) {
      $result.addScore.addAll(addScore);
    }
    if (minusScore != null) {
      $result.minusScore.addAll(minusScore);
    }
    return $result;
  }
  TableSeatingResult._() : super();
  factory TableSeatingResult.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TableSeatingResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TableSeatingResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<PlayerRole>(1, _omitFieldNames ? '' : 'role', $pb.PbFieldType.KE,
        valueOf: PlayerRole.valueOf, enumValues: PlayerRole.values, defaultEnumValue: PlayerRole.citizen)
    ..p<$core.double>(2, _omitFieldNames ? '' : 'score', $pb.PbFieldType.KD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'died', $pb.PbFieldType.O3)
    ..e<GameWin>(4, _omitFieldNames ? '' : 'win', $pb.PbFieldType.OE,
        defaultOrMaker: GameWin.city, valueOf: GameWin.valueOf, enumValues: GameWin.values)
    ..e<BestMove>(5, _omitFieldNames ? '' : 'bestMove', $pb.PbFieldType.OE,
        protoName: 'bestMove', defaultOrMaker: BestMove.miss, valueOf: BestMove.valueOf, enumValues: BestMove.values)
    ..p<$core.double>(6, _omitFieldNames ? '' : 'addScore', $pb.PbFieldType.KD, protoName: 'addScore')
    ..p<$core.double>(7, _omitFieldNames ? '' : 'minusScore', $pb.PbFieldType.KD, protoName: 'minusScore')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TableSeatingResult clone() => TableSeatingResult()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TableSeatingResult copyWith(void Function(TableSeatingResult) updates) =>
      super.copyWith((message) => updates(message as TableSeatingResult)) as TableSeatingResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TableSeatingResult create() => TableSeatingResult._();
  TableSeatingResult createEmptyInstance() => create();
  static $pb.PbList<TableSeatingResult> createRepeated() => $pb.PbList<TableSeatingResult>();
  @$core.pragma('dart2js:noInline')
  static TableSeatingResult getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TableSeatingResult>(create);
  static TableSeatingResult? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PlayerRole> get role => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.double> get score => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get died => $_getIZ(2);
  @$pb.TagNumber(3)
  set died($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDied() => $_has(2);
  @$pb.TagNumber(3)
  void clearDied() => $_clearField(3);

  @$pb.TagNumber(4)
  GameWin get win => $_getN(3);
  @$pb.TagNumber(4)
  set win(GameWin v) {
    $_setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasWin() => $_has(3);
  @$pb.TagNumber(4)
  void clearWin() => $_clearField(4);

  @$pb.TagNumber(5)
  BestMove get bestMove => $_getN(4);
  @$pb.TagNumber(5)
  set bestMove(BestMove v) {
    $_setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasBestMove() => $_has(4);
  @$pb.TagNumber(5)
  void clearBestMove() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.double> get addScore => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.double> get minusScore => $_getList(6);
}

class UpdateHideDateRequest extends $pb.GeneratedMessage {
  factory UpdateHideDateRequest({
    $core.String? date,
  }) {
    final $result = create();
    if (date != null) {
      $result.date = date;
    }
    return $result;
  }
  UpdateHideDateRequest._() : super();
  factory UpdateHideDateRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateHideDateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateHideDateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'date')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateHideDateRequest clone() => UpdateHideDateRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateHideDateRequest copyWith(void Function(UpdateHideDateRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateHideDateRequest)) as UpdateHideDateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateHideDateRequest create() => UpdateHideDateRequest._();
  UpdateHideDateRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateHideDateRequest> createRepeated() => $pb.PbList<UpdateHideDateRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateHideDateRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateHideDateRequest>(create);
  static UpdateHideDateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get date => $_getSZ(0);
  @$pb.TagNumber(1)
  set date($core.String v) {
    $_setString(0, v);
  }

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
    final $result = create();
    if (gameId != null) {
      $result.gameId = gameId;
    }
    if (seating != null) {
      $result.seating = seating;
    }
    if (result != null) {
      $result.result = result;
    }
    if (game != null) {
      $result.game = game;
    }
    if (table != null) {
      $result.table = table;
    }
    return $result;
  }
  TableSeatingItem._() : super();
  factory TableSeatingItem.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TableSeatingItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TableSeatingItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'gameId', $pb.PbFieldType.O3, protoName: 'gameId')
    ..aOM<TableSeating>(2, _omitFieldNames ? '' : 'seating', subBuilder: TableSeating.create)
    ..aOM<TableSeatingResult>(3, _omitFieldNames ? '' : 'result', subBuilder: TableSeatingResult.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'game', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'table', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TableSeatingItem clone() => TableSeatingItem()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TableSeatingItem copyWith(void Function(TableSeatingItem) updates) =>
      super.copyWith((message) => updates(message as TableSeatingItem)) as TableSeatingItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TableSeatingItem create() => TableSeatingItem._();
  TableSeatingItem createEmptyInstance() => create();
  static $pb.PbList<TableSeatingItem> createRepeated() => $pb.PbList<TableSeatingItem>();
  @$core.pragma('dart2js:noInline')
  static TableSeatingItem getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TableSeatingItem>(create);
  static TableSeatingItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get gameId => $_getIZ(0);
  @$pb.TagNumber(1)
  set gameId($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => $_clearField(1);

  @$pb.TagNumber(2)
  TableSeating get seating => $_getN(1);
  @$pb.TagNumber(2)
  set seating(TableSeating v) {
    $_setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSeating() => $_has(1);
  @$pb.TagNumber(2)
  void clearSeating() => $_clearField(2);
  @$pb.TagNumber(2)
  TableSeating ensureSeating() => $_ensure(1);

  @$pb.TagNumber(3)
  TableSeatingResult get result => $_getN(2);
  @$pb.TagNumber(3)
  set result(TableSeatingResult v) {
    $_setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasResult() => $_has(2);
  @$pb.TagNumber(3)
  void clearResult() => $_clearField(3);
  @$pb.TagNumber(3)
  TableSeatingResult ensureResult() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get game => $_getIZ(3);
  @$pb.TagNumber(4)
  set game($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasGame() => $_has(3);
  @$pb.TagNumber(4)
  void clearGame() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get table => $_getIZ(4);
  @$pb.TagNumber(5)
  set table($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasTable() => $_has(4);
  @$pb.TagNumber(5)
  void clearTable() => $_clearField(5);
}

class SeatingEventOut extends $pb.GeneratedMessage {
  factory SeatingEventOut({
    $core.Iterable<TableSeatingItem>? item,
  }) {
    final $result = create();
    if (item != null) {
      $result.item.addAll(item);
    }
    return $result;
  }
  SeatingEventOut._() : super();
  factory SeatingEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SeatingEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SeatingEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<TableSeatingItem>(1, _omitFieldNames ? '' : 'item', $pb.PbFieldType.PM, subBuilder: TableSeatingItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SeatingEventOut clone() => SeatingEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SeatingEventOut copyWith(void Function(SeatingEventOut) updates) =>
      super.copyWith((message) => updates(message as SeatingEventOut)) as SeatingEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SeatingEventOut create() => SeatingEventOut._();
  SeatingEventOut createEmptyInstance() => create();
  static $pb.PbList<SeatingEventOut> createRepeated() => $pb.PbList<SeatingEventOut>();
  @$core.pragma('dart2js:noInline')
  static SeatingEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SeatingEventOut>(create);
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
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (recoveryToken != null) {
      $result.recoveryToken = recoveryToken;
    }
    if (error != null) {
      $result.error = error;
    }
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  LoginEventOut._() : super();
  factory LoginEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LoginEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LoginEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'recoveryToken', protoName: 'recoveryToken')
    ..e<LoginEventOut_Error>(3, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE,
        defaultOrMaker: LoginEventOut_Error.noError,
        valueOf: LoginEventOut_Error.valueOf,
        enumValues: LoginEventOut_Error.values)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LoginEventOut clone() => LoginEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LoginEventOut copyWith(void Function(LoginEventOut) updates) =>
      super.copyWith((message) => updates(message as LoginEventOut)) as LoginEventOut;

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
  set token($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get recoveryToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set recoveryToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRecoveryToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecoveryToken() => $_clearField(2);

  @$pb.TagNumber(3)
  LoginEventOut_Error get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(LoginEventOut_Error v) {
    $_setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get id => $_getIZ(3);
  @$pb.TagNumber(4)
  set id($core.int v) {
    $_setSignedInt32(3, v);
  }

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
    final $result = create();
    if (player != null) {
      $result.player = player;
    }
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    if (role != null) {
      $result.role = role;
    }
    if (status != null) {
      $result.status = status;
    }
    if (selectedGame != null) {
      $result.selectedGame = selectedGame;
    }
    return $result;
  }
  ChangeSeatingContent._() : super();
  factory ChangeSeatingContent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ChangeSeatingContent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChangeSeatingContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'player', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'imageUrl', protoName: 'imageUrl')
    ..e<PlayerRole>(3, _omitFieldNames ? '' : 'role', $pb.PbFieldType.OE,
        defaultOrMaker: PlayerRole.citizen, valueOf: PlayerRole.valueOf, enumValues: PlayerRole.values)
    ..e<PlayerStatus>(4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: PlayerStatus.alive, valueOf: PlayerStatus.valueOf, enumValues: PlayerStatus.values)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'selectedGame', $pb.PbFieldType.O3, protoName: 'selectedGame')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ChangeSeatingContent clone() => ChangeSeatingContent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ChangeSeatingContent copyWith(void Function(ChangeSeatingContent) updates) =>
      super.copyWith((message) => updates(message as ChangeSeatingContent)) as ChangeSeatingContent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangeSeatingContent create() => ChangeSeatingContent._();
  ChangeSeatingContent createEmptyInstance() => create();
  static $pb.PbList<ChangeSeatingContent> createRepeated() => $pb.PbList<ChangeSeatingContent>();
  @$core.pragma('dart2js:noInline')
  static ChangeSeatingContent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangeSeatingContent>(create);
  static ChangeSeatingContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get player => $_getIZ(0);
  @$pb.TagNumber(1)
  set player($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPlayer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get imageUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set imageUrl($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasImageUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  PlayerRole get role => $_getN(2);
  @$pb.TagNumber(3)
  set role(PlayerRole v) {
    $_setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => $_clearField(3);

  @$pb.TagNumber(4)
  PlayerStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(PlayerStatus v) {
    $_setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get selectedGame => $_getIZ(4);
  @$pb.TagNumber(5)
  set selectedGame($core.int v) {
    $_setSignedInt32(4, v);
  }

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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (description != null) {
      $result.description = description;
    }
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    if (groupLink != null) {
      $result.groupLink = groupLink;
    }
    if (city != null) {
      $result.city = city;
    }
    if (billedFor != null) {
      $result.billedFor = billedFor;
    }
    return $result;
  }
  Club._() : super();
  factory Club.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Club.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Club',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'imageUrl', protoName: 'imageUrl')
    ..aOS(5, _omitFieldNames ? '' : 'groupLink', protoName: 'groupLink')
    ..aOS(6, _omitFieldNames ? '' : 'city')
    ..aOS(7, _omitFieldNames ? '' : 'billedFor', protoName: 'billedFor')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Club clone() => Club()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Club copyWith(void Function(Club) updates) => super.copyWith((message) => updates(message as Club)) as Club;

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
  set id($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get imageUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set imageUrl($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasImageUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearImageUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get groupLink => $_getSZ(4);
  @$pb.TagNumber(5)
  set groupLink($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasGroupLink() => $_has(4);
  @$pb.TagNumber(5)
  void clearGroupLink() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get city => $_getSZ(5);
  @$pb.TagNumber(6)
  set city($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasCity() => $_has(5);
  @$pb.TagNumber(6)
  void clearCity() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get billedFor => $_getSZ(6);
  @$pb.TagNumber(7)
  set billedFor($core.String v) {
    $_setString(6, v);
  }

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
    final $result = create();
    if (row != null) {
      $result.row.addAll(row);
    }
    if (clubName != null) {
      $result.clubName = clubName;
    }
    if (games != null) {
      $result.games = games;
    }
    if (mafiaWins != null) {
      $result.mafiaWins = mafiaWins;
    }
    if (citizenWins != null) {
      $result.citizenWins = citizenWins;
    }
    return $result;
  }
  ClubRatingEventOut._() : super();
  factory ClubRatingEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ClubRatingEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClubRatingEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<ClubRatingRow>(1, _omitFieldNames ? '' : 'row', $pb.PbFieldType.PM, subBuilder: ClubRatingRow.create)
    ..aOS(2, _omitFieldNames ? '' : 'clubName', protoName: 'clubName')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'games', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'mafiaWins', $pb.PbFieldType.O3, protoName: 'mafiaWins')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'citizenWins', $pb.PbFieldType.O3, protoName: 'citizenWins')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ClubRatingEventOut clone() => ClubRatingEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ClubRatingEventOut copyWith(void Function(ClubRatingEventOut) updates) =>
      super.copyWith((message) => updates(message as ClubRatingEventOut)) as ClubRatingEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClubRatingEventOut create() => ClubRatingEventOut._();
  ClubRatingEventOut createEmptyInstance() => create();
  static $pb.PbList<ClubRatingEventOut> createRepeated() => $pb.PbList<ClubRatingEventOut>();
  @$core.pragma('dart2js:noInline')
  static ClubRatingEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClubRatingEventOut>(create);
  static ClubRatingEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ClubRatingRow> get row => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get clubName => $_getSZ(1);
  @$pb.TagNumber(2)
  set clubName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasClubName() => $_has(1);
  @$pb.TagNumber(2)
  void clearClubName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get games => $_getIZ(2);
  @$pb.TagNumber(3)
  set games($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasGames() => $_has(2);
  @$pb.TagNumber(3)
  void clearGames() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get mafiaWins => $_getIZ(3);
  @$pb.TagNumber(4)
  set mafiaWins($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMafiaWins() => $_has(3);
  @$pb.TagNumber(4)
  void clearMafiaWins() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get citizenWins => $_getIZ(4);
  @$pb.TagNumber(5)
  set citizenWins($core.int v) {
    $_setSignedInt32(4, v);
  }

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
    final $result = create();
    if (gameId != null) {
      $result.gameId = gameId;
    }
    if (score != null) {
      $result.score = score;
    }
    return $result;
  }
  ClubRatingRow_GameItem._() : super();
  factory ClubRatingRow_GameItem.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ClubRatingRow_GameItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClubRatingRow.GameItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'gameId', $pb.PbFieldType.O3, protoName: 'gameId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'score', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ClubRatingRow_GameItem clone() => ClubRatingRow_GameItem()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ClubRatingRow_GameItem copyWith(void Function(ClubRatingRow_GameItem) updates) =>
      super.copyWith((message) => updates(message as ClubRatingRow_GameItem)) as ClubRatingRow_GameItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClubRatingRow_GameItem create() => ClubRatingRow_GameItem._();
  ClubRatingRow_GameItem createEmptyInstance() => create();
  static $pb.PbList<ClubRatingRow_GameItem> createRepeated() => $pb.PbList<ClubRatingRow_GameItem>();
  @$core.pragma('dart2js:noInline')
  static ClubRatingRow_GameItem getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClubRatingRow_GameItem>(create);
  static ClubRatingRow_GameItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get gameId => $_getIZ(0);
  @$pb.TagNumber(1)
  set gameId($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get score => $_getN(1);
  @$pb.TagNumber(2)
  set score($core.double v) {
    $_setDouble(1, v);
  }

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
    $core.Iterable<CustomColumnValue>? customColumns,
  }) {
    final $result = create();
    if (nickname != null) {
      $result.nickname = nickname;
    }
    if (score != null) {
      $result.score = score;
    }
    if (addScore != null) {
      $result.addScore = addScore;
    }
    if (firstDie != null) {
      $result.firstDie = firstDie;
    }
    if (donWins != null) {
      $result.donWins = donWins;
    }
    if (sheriffWins != null) {
      $result.sheriffWins = sheriffWins;
    }
    if (item != null) {
      $result.item.addAll(item);
    }
    if (wins != null) {
      $result.wins = wins;
    }
    if (ci != null) {
      $result.ci = ci;
    }
    if (totalGames != null) {
      $result.totalGames = totalGames;
    }
    if (citizenGames != null) {
      $result.citizenGames = citizenGames;
    }
    if (donGames != null) {
      $result.donGames = donGames;
    }
    if (sheriffGames != null) {
      $result.sheriffGames = sheriffGames;
    }
    if (mafiaGames != null) {
      $result.mafiaGames = mafiaGames;
    }
    if (mafiaWins != null) {
      $result.mafiaWins = mafiaWins;
    }
    if (citizenWins != null) {
      $result.citizenWins = citizenWins;
    }
    if (citizenAddScore != null) {
      $result.citizenAddScore = citizenAddScore;
    }
    if (mafiaAddScore != null) {
      $result.mafiaAddScore = mafiaAddScore;
    }
    if (donAddScore != null) {
      $result.donAddScore = donAddScore;
    }
    if (sheriffAddScore != null) {
      $result.sheriffAddScore = sheriffAddScore;
    }
    if (citizenScore != null) {
      $result.citizenScore = citizenScore;
    }
    if (mafiaScore != null) {
      $result.mafiaScore = mafiaScore;
    }
    if (donScore != null) {
      $result.donScore = donScore;
    }
    if (sheriffScore != null) {
      $result.sheriffScore = sheriffScore;
    }
    if (playerId != null) {
      $result.playerId = playerId;
    }
    if (refereeCount != null) {
      $result.refereeCount = refereeCount;
    }
    if (minusScore != null) {
      $result.minusScore = minusScore;
    }
    if (citizenMinusScore != null) {
      $result.citizenMinusScore = citizenMinusScore;
    }
    if (mafiaMinusScore != null) {
      $result.mafiaMinusScore = mafiaMinusScore;
    }
    if (donMinusScore != null) {
      $result.donMinusScore = donMinusScore;
    }
    if (sheriffMinusScore != null) {
      $result.sheriffMinusScore = sheriffMinusScore;
    }
    if (bestMoveCitizen != null) {
      $result.bestMoveCitizen = bestMoveCitizen;
    }
    if (bestMoveSheriff != null) {
      $result.bestMoveSheriff = bestMoveSheriff;
    }
    if (customColumns != null) {
      $result.customColumns.addAll(customColumns);
    }
    return $result;
  }
  ClubRatingRow._() : super();
  factory ClubRatingRow.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ClubRatingRow.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClubRatingRow',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nickname')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'score', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'addScore', $pb.PbFieldType.OD, protoName: 'addScore')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'firstDie', $pb.PbFieldType.O3, protoName: 'firstDie')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'donWins', $pb.PbFieldType.O3, protoName: 'donWins')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'sheriffWins', $pb.PbFieldType.O3, protoName: 'sheriffWins')
    ..pc<ClubRatingRow_GameItem>(7, _omitFieldNames ? '' : 'item', $pb.PbFieldType.PM,
        subBuilder: ClubRatingRow_GameItem.create)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'wins', $pb.PbFieldType.O3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'ci', $pb.PbFieldType.O3)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'totalGames', $pb.PbFieldType.O3, protoName: 'totalGames')
    ..a<$core.int>(11, _omitFieldNames ? '' : 'citizenGames', $pb.PbFieldType.O3, protoName: 'citizenGames')
    ..a<$core.int>(12, _omitFieldNames ? '' : 'donGames', $pb.PbFieldType.O3, protoName: 'donGames')
    ..a<$core.int>(13, _omitFieldNames ? '' : 'sheriffGames', $pb.PbFieldType.O3, protoName: 'sheriffGames')
    ..a<$core.int>(14, _omitFieldNames ? '' : 'mafiaGames', $pb.PbFieldType.O3, protoName: 'mafiaGames')
    ..a<$core.int>(15, _omitFieldNames ? '' : 'mafiaWins', $pb.PbFieldType.O3, protoName: 'mafiaWins')
    ..a<$core.int>(16, _omitFieldNames ? '' : 'citizenWins', $pb.PbFieldType.O3, protoName: 'citizenWins')
    ..a<$core.double>(17, _omitFieldNames ? '' : 'citizenAddScore', $pb.PbFieldType.OD, protoName: 'citizenAddScore')
    ..a<$core.double>(18, _omitFieldNames ? '' : 'mafiaAddScore', $pb.PbFieldType.OD, protoName: 'mafiaAddScore')
    ..a<$core.double>(19, _omitFieldNames ? '' : 'donAddScore', $pb.PbFieldType.OD, protoName: 'donAddScore')
    ..a<$core.double>(20, _omitFieldNames ? '' : 'sheriffAddScore', $pb.PbFieldType.OD, protoName: 'sheriffAddScore')
    ..a<$core.double>(21, _omitFieldNames ? '' : 'citizenScore', $pb.PbFieldType.OD, protoName: 'citizenScore')
    ..a<$core.double>(22, _omitFieldNames ? '' : 'mafiaScore', $pb.PbFieldType.OD, protoName: 'mafiaScore')
    ..a<$core.double>(23, _omitFieldNames ? '' : 'donScore', $pb.PbFieldType.OD, protoName: 'donScore')
    ..a<$core.double>(24, _omitFieldNames ? '' : 'sheriffScore', $pb.PbFieldType.OD, protoName: 'sheriffScore')
    ..a<$core.int>(25, _omitFieldNames ? '' : 'playerId', $pb.PbFieldType.O3, protoName: 'playerId')
    ..a<$core.int>(26, _omitFieldNames ? '' : 'refereeCount', $pb.PbFieldType.O3, protoName: 'refereeCount')
    ..a<$core.double>(27, _omitFieldNames ? '' : 'minusScore', $pb.PbFieldType.OD, protoName: 'minusScore')
    ..a<$core.double>(28, _omitFieldNames ? '' : 'citizenMinusScore', $pb.PbFieldType.OD,
        protoName: 'citizenMinusScore')
    ..a<$core.double>(29, _omitFieldNames ? '' : 'mafiaMinusScore', $pb.PbFieldType.OD, protoName: 'mafiaMinusScore')
    ..a<$core.double>(30, _omitFieldNames ? '' : 'donMinusScore', $pb.PbFieldType.OD, protoName: 'donMinusScore')
    ..a<$core.double>(31, _omitFieldNames ? '' : 'sheriffMinusScore', $pb.PbFieldType.OD,
        protoName: 'sheriffMinusScore')
    ..a<$core.double>(32, _omitFieldNames ? '' : 'bestMoveCitizen', $pb.PbFieldType.OD, protoName: 'bestMoveCitizen')
    ..a<$core.double>(33, _omitFieldNames ? '' : 'bestMoveSheriff', $pb.PbFieldType.OD, protoName: 'bestMoveSheriff')
    ..pc<CustomColumnValue>(34, _omitFieldNames ? '' : 'customColumns', $pb.PbFieldType.PM,
        protoName: 'customColumns', subBuilder: CustomColumnValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ClubRatingRow clone() => ClubRatingRow()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ClubRatingRow copyWith(void Function(ClubRatingRow) updates) =>
      super.copyWith((message) => updates(message as ClubRatingRow)) as ClubRatingRow;

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
  set nickname($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNickname() => $_has(0);
  @$pb.TagNumber(1)
  void clearNickname() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get score => $_getN(1);
  @$pb.TagNumber(2)
  set score($core.double v) {
    $_setDouble(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearScore() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get addScore => $_getN(2);
  @$pb.TagNumber(3)
  set addScore($core.double v) {
    $_setDouble(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAddScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearAddScore() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get firstDie => $_getIZ(3);
  @$pb.TagNumber(4)
  set firstDie($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasFirstDie() => $_has(3);
  @$pb.TagNumber(4)
  void clearFirstDie() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get donWins => $_getIZ(4);
  @$pb.TagNumber(5)
  set donWins($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasDonWins() => $_has(4);
  @$pb.TagNumber(5)
  void clearDonWins() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get sheriffWins => $_getIZ(5);
  @$pb.TagNumber(6)
  set sheriffWins($core.int v) {
    $_setSignedInt32(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasSheriffWins() => $_has(5);
  @$pb.TagNumber(6)
  void clearSheriffWins() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<ClubRatingRow_GameItem> get item => $_getList(6);

  @$pb.TagNumber(8)
  $core.int get wins => $_getIZ(7);
  @$pb.TagNumber(8)
  set wins($core.int v) {
    $_setSignedInt32(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasWins() => $_has(7);
  @$pb.TagNumber(8)
  void clearWins() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get ci => $_getIZ(8);
  @$pb.TagNumber(9)
  set ci($core.int v) {
    $_setSignedInt32(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasCi() => $_has(8);
  @$pb.TagNumber(9)
  void clearCi() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get totalGames => $_getIZ(9);
  @$pb.TagNumber(10)
  set totalGames($core.int v) {
    $_setSignedInt32(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasTotalGames() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalGames() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get citizenGames => $_getIZ(10);
  @$pb.TagNumber(11)
  set citizenGames($core.int v) {
    $_setSignedInt32(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasCitizenGames() => $_has(10);
  @$pb.TagNumber(11)
  void clearCitizenGames() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get donGames => $_getIZ(11);
  @$pb.TagNumber(12)
  set donGames($core.int v) {
    $_setSignedInt32(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasDonGames() => $_has(11);
  @$pb.TagNumber(12)
  void clearDonGames() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get sheriffGames => $_getIZ(12);
  @$pb.TagNumber(13)
  set sheriffGames($core.int v) {
    $_setSignedInt32(12, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasSheriffGames() => $_has(12);
  @$pb.TagNumber(13)
  void clearSheriffGames() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get mafiaGames => $_getIZ(13);
  @$pb.TagNumber(14)
  set mafiaGames($core.int v) {
    $_setSignedInt32(13, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasMafiaGames() => $_has(13);
  @$pb.TagNumber(14)
  void clearMafiaGames() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get mafiaWins => $_getIZ(14);
  @$pb.TagNumber(15)
  set mafiaWins($core.int v) {
    $_setSignedInt32(14, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasMafiaWins() => $_has(14);
  @$pb.TagNumber(15)
  void clearMafiaWins() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get citizenWins => $_getIZ(15);
  @$pb.TagNumber(16)
  set citizenWins($core.int v) {
    $_setSignedInt32(15, v);
  }

  @$pb.TagNumber(16)
  $core.bool hasCitizenWins() => $_has(15);
  @$pb.TagNumber(16)
  void clearCitizenWins() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.double get citizenAddScore => $_getN(16);
  @$pb.TagNumber(17)
  set citizenAddScore($core.double v) {
    $_setDouble(16, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasCitizenAddScore() => $_has(16);
  @$pb.TagNumber(17)
  void clearCitizenAddScore() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.double get mafiaAddScore => $_getN(17);
  @$pb.TagNumber(18)
  set mafiaAddScore($core.double v) {
    $_setDouble(17, v);
  }

  @$pb.TagNumber(18)
  $core.bool hasMafiaAddScore() => $_has(17);
  @$pb.TagNumber(18)
  void clearMafiaAddScore() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.double get donAddScore => $_getN(18);
  @$pb.TagNumber(19)
  set donAddScore($core.double v) {
    $_setDouble(18, v);
  }

  @$pb.TagNumber(19)
  $core.bool hasDonAddScore() => $_has(18);
  @$pb.TagNumber(19)
  void clearDonAddScore() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.double get sheriffAddScore => $_getN(19);
  @$pb.TagNumber(20)
  set sheriffAddScore($core.double v) {
    $_setDouble(19, v);
  }

  @$pb.TagNumber(20)
  $core.bool hasSheriffAddScore() => $_has(19);
  @$pb.TagNumber(20)
  void clearSheriffAddScore() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.double get citizenScore => $_getN(20);
  @$pb.TagNumber(21)
  set citizenScore($core.double v) {
    $_setDouble(20, v);
  }

  @$pb.TagNumber(21)
  $core.bool hasCitizenScore() => $_has(20);
  @$pb.TagNumber(21)
  void clearCitizenScore() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.double get mafiaScore => $_getN(21);
  @$pb.TagNumber(22)
  set mafiaScore($core.double v) {
    $_setDouble(21, v);
  }

  @$pb.TagNumber(22)
  $core.bool hasMafiaScore() => $_has(21);
  @$pb.TagNumber(22)
  void clearMafiaScore() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.double get donScore => $_getN(22);
  @$pb.TagNumber(23)
  set donScore($core.double v) {
    $_setDouble(22, v);
  }

  @$pb.TagNumber(23)
  $core.bool hasDonScore() => $_has(22);
  @$pb.TagNumber(23)
  void clearDonScore() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.double get sheriffScore => $_getN(23);
  @$pb.TagNumber(24)
  set sheriffScore($core.double v) {
    $_setDouble(23, v);
  }

  @$pb.TagNumber(24)
  $core.bool hasSheriffScore() => $_has(23);
  @$pb.TagNumber(24)
  void clearSheriffScore() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.int get playerId => $_getIZ(24);
  @$pb.TagNumber(25)
  set playerId($core.int v) {
    $_setSignedInt32(24, v);
  }

  @$pb.TagNumber(25)
  $core.bool hasPlayerId() => $_has(24);
  @$pb.TagNumber(25)
  void clearPlayerId() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.int get refereeCount => $_getIZ(25);
  @$pb.TagNumber(26)
  set refereeCount($core.int v) {
    $_setSignedInt32(25, v);
  }

  @$pb.TagNumber(26)
  $core.bool hasRefereeCount() => $_has(25);
  @$pb.TagNumber(26)
  void clearRefereeCount() => $_clearField(26);

  @$pb.TagNumber(27)
  $core.double get minusScore => $_getN(26);
  @$pb.TagNumber(27)
  set minusScore($core.double v) {
    $_setDouble(26, v);
  }

  @$pb.TagNumber(27)
  $core.bool hasMinusScore() => $_has(26);
  @$pb.TagNumber(27)
  void clearMinusScore() => $_clearField(27);

  @$pb.TagNumber(28)
  $core.double get citizenMinusScore => $_getN(27);
  @$pb.TagNumber(28)
  set citizenMinusScore($core.double v) {
    $_setDouble(27, v);
  }

  @$pb.TagNumber(28)
  $core.bool hasCitizenMinusScore() => $_has(27);
  @$pb.TagNumber(28)
  void clearCitizenMinusScore() => $_clearField(28);

  @$pb.TagNumber(29)
  $core.double get mafiaMinusScore => $_getN(28);
  @$pb.TagNumber(29)
  set mafiaMinusScore($core.double v) {
    $_setDouble(28, v);
  }

  @$pb.TagNumber(29)
  $core.bool hasMafiaMinusScore() => $_has(28);
  @$pb.TagNumber(29)
  void clearMafiaMinusScore() => $_clearField(29);

  @$pb.TagNumber(30)
  $core.double get donMinusScore => $_getN(29);
  @$pb.TagNumber(30)
  set donMinusScore($core.double v) {
    $_setDouble(29, v);
  }

  @$pb.TagNumber(30)
  $core.bool hasDonMinusScore() => $_has(29);
  @$pb.TagNumber(30)
  void clearDonMinusScore() => $_clearField(30);

  @$pb.TagNumber(31)
  $core.double get sheriffMinusScore => $_getN(30);
  @$pb.TagNumber(31)
  set sheriffMinusScore($core.double v) {
    $_setDouble(30, v);
  }

  @$pb.TagNumber(31)
  $core.bool hasSheriffMinusScore() => $_has(30);
  @$pb.TagNumber(31)
  void clearSheriffMinusScore() => $_clearField(31);

  @$pb.TagNumber(32)
  $core.double get bestMoveCitizen => $_getN(31);
  @$pb.TagNumber(32)
  set bestMoveCitizen($core.double v) {
    $_setDouble(31, v);
  }

  @$pb.TagNumber(32)
  $core.bool hasBestMoveCitizen() => $_has(31);
  @$pb.TagNumber(32)
  void clearBestMoveCitizen() => $_clearField(32);

  @$pb.TagNumber(33)
  $core.double get bestMoveSheriff => $_getN(32);
  @$pb.TagNumber(33)
  set bestMoveSheriff($core.double v) {
    $_setDouble(32, v);
  }

  @$pb.TagNumber(33)
  $core.bool hasBestMoveSheriff() => $_has(32);
  @$pb.TagNumber(33)
  void clearBestMoveSheriff() => $_clearField(33);

  @$pb.TagNumber(34)
  $pb.PbList<CustomColumnValue> get customColumns => $_getList(33);
}

class CustomColumnValue extends $pb.GeneratedMessage {
  factory CustomColumnValue({
    $core.String? title,
    $core.double? value,
  }) {
    final $result = create();
    if (title != null) {
      $result.title = title;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  CustomColumnValue._() : super();
  factory CustomColumnValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CustomColumnValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CustomColumnValue',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CustomColumnValue clone() => CustomColumnValue()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CustomColumnValue copyWith(void Function(CustomColumnValue) updates) =>
      super.copyWith((message) => updates(message as CustomColumnValue)) as CustomColumnValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CustomColumnValue create() => CustomColumnValue._();
  CustomColumnValue createEmptyInstance() => create();
  static $pb.PbList<CustomColumnValue> createRepeated() => $pb.PbList<CustomColumnValue>();
  @$core.pragma('dart2js:noInline')
  static CustomColumnValue getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CustomColumnValue>(create);
  static CustomColumnValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double v) {
    $_setDouble(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

class CustomColumnDefinition extends $pb.GeneratedMessage {
  factory CustomColumnDefinition({
    $core.int? id,
    $core.String? title,
    $core.String? formula,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (title != null) {
      $result.title = title;
    }
    if (formula != null) {
      $result.formula = formula;
    }
    return $result;
  }
  CustomColumnDefinition._() : super();
  factory CustomColumnDefinition.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CustomColumnDefinition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CustomColumnDefinition',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'formula')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CustomColumnDefinition clone() => CustomColumnDefinition()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CustomColumnDefinition copyWith(void Function(CustomColumnDefinition) updates) =>
      super.copyWith((message) => updates(message as CustomColumnDefinition)) as CustomColumnDefinition;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CustomColumnDefinition create() => CustomColumnDefinition._();
  CustomColumnDefinition createEmptyInstance() => create();
  static $pb.PbList<CustomColumnDefinition> createRepeated() => $pb.PbList<CustomColumnDefinition>();
  @$core.pragma('dart2js:noInline')
  static CustomColumnDefinition getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CustomColumnDefinition>(create);
  static CustomColumnDefinition? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get formula => $_getSZ(2);
  @$pb.TagNumber(3)
  set formula($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFormula() => $_has(2);
  @$pb.TagNumber(3)
  void clearFormula() => $_clearField(3);
}

class CustomColumnsEventOut extends $pb.GeneratedMessage {
  factory CustomColumnsEventOut({
    $core.Iterable<CustomColumnDefinition>? columns,
  }) {
    final $result = create();
    if (columns != null) {
      $result.columns.addAll(columns);
    }
    return $result;
  }
  CustomColumnsEventOut._() : super();
  factory CustomColumnsEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CustomColumnsEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CustomColumnsEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<CustomColumnDefinition>(1, _omitFieldNames ? '' : 'columns', $pb.PbFieldType.PM,
        subBuilder: CustomColumnDefinition.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CustomColumnsEventOut clone() => CustomColumnsEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CustomColumnsEventOut copyWith(void Function(CustomColumnsEventOut) updates) =>
      super.copyWith((message) => updates(message as CustomColumnsEventOut)) as CustomColumnsEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CustomColumnsEventOut create() => CustomColumnsEventOut._();
  CustomColumnsEventOut createEmptyInstance() => create();
  static $pb.PbList<CustomColumnsEventOut> createRepeated() => $pb.PbList<CustomColumnsEventOut>();
  @$core.pragma('dart2js:noInline')
  static CustomColumnsEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CustomColumnsEventOut>(create);
  static CustomColumnsEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CustomColumnDefinition> get columns => $_getList(0);
}

class CreateCustomColumnEvent extends $pb.GeneratedMessage {
  factory CreateCustomColumnEvent({
    $core.String? title,
    $core.String? formula,
  }) {
    final $result = create();
    if (title != null) {
      $result.title = title;
    }
    if (formula != null) {
      $result.formula = formula;
    }
    return $result;
  }
  CreateCustomColumnEvent._() : super();
  factory CreateCustomColumnEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateCustomColumnEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateCustomColumnEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'formula')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateCustomColumnEvent clone() => CreateCustomColumnEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateCustomColumnEvent copyWith(void Function(CreateCustomColumnEvent) updates) =>
      super.copyWith((message) => updates(message as CreateCustomColumnEvent)) as CreateCustomColumnEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateCustomColumnEvent create() => CreateCustomColumnEvent._();
  CreateCustomColumnEvent createEmptyInstance() => create();
  static $pb.PbList<CreateCustomColumnEvent> createRepeated() => $pb.PbList<CreateCustomColumnEvent>();
  @$core.pragma('dart2js:noInline')
  static CreateCustomColumnEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateCustomColumnEvent>(create);
  static CreateCustomColumnEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get formula => $_getSZ(1);
  @$pb.TagNumber(2)
  set formula($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFormula() => $_has(1);
  @$pb.TagNumber(2)
  void clearFormula() => $_clearField(2);
}

class UpdateCustomColumnEvent extends $pb.GeneratedMessage {
  factory UpdateCustomColumnEvent({
    $core.String? title,
    $core.String? formula,
  }) {
    final $result = create();
    if (title != null) {
      $result.title = title;
    }
    if (formula != null) {
      $result.formula = formula;
    }
    return $result;
  }
  UpdateCustomColumnEvent._() : super();
  factory UpdateCustomColumnEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateCustomColumnEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateCustomColumnEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'formula')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateCustomColumnEvent clone() => UpdateCustomColumnEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateCustomColumnEvent copyWith(void Function(UpdateCustomColumnEvent) updates) =>
      super.copyWith((message) => updates(message as UpdateCustomColumnEvent)) as UpdateCustomColumnEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCustomColumnEvent create() => UpdateCustomColumnEvent._();
  UpdateCustomColumnEvent createEmptyInstance() => create();
  static $pb.PbList<UpdateCustomColumnEvent> createRepeated() => $pb.PbList<UpdateCustomColumnEvent>();
  @$core.pragma('dart2js:noInline')
  static UpdateCustomColumnEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateCustomColumnEvent>(create);
  static UpdateCustomColumnEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get formula => $_getSZ(1);
  @$pb.TagNumber(2)
  set formula($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFormula() => $_has(1);
  @$pb.TagNumber(2)
  void clearFormula() => $_clearField(2);
}

class ValidateFormulaEvent extends $pb.GeneratedMessage {
  factory ValidateFormulaEvent({
    $core.String? formula,
  }) {
    final $result = create();
    if (formula != null) {
      $result.formula = formula;
    }
    return $result;
  }
  ValidateFormulaEvent._() : super();
  factory ValidateFormulaEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ValidateFormulaEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidateFormulaEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'formula')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ValidateFormulaEvent clone() => ValidateFormulaEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ValidateFormulaEvent copyWith(void Function(ValidateFormulaEvent) updates) =>
      super.copyWith((message) => updates(message as ValidateFormulaEvent)) as ValidateFormulaEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateFormulaEvent create() => ValidateFormulaEvent._();
  ValidateFormulaEvent createEmptyInstance() => create();
  static $pb.PbList<ValidateFormulaEvent> createRepeated() => $pb.PbList<ValidateFormulaEvent>();
  @$core.pragma('dart2js:noInline')
  static ValidateFormulaEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateFormulaEvent>(create);
  static ValidateFormulaEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get formula => $_getSZ(0);
  @$pb.TagNumber(1)
  set formula($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFormula() => $_has(0);
  @$pb.TagNumber(1)
  void clearFormula() => $_clearField(1);
}

class ValidateFormulaEventOut extends $pb.GeneratedMessage {
  factory ValidateFormulaEventOut({
    $core.bool? valid,
    $core.String? error,
  }) {
    final $result = create();
    if (valid != null) {
      $result.valid = valid;
    }
    if (error != null) {
      $result.error = error;
    }
    return $result;
  }
  ValidateFormulaEventOut._() : super();
  factory ValidateFormulaEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ValidateFormulaEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidateFormulaEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'valid')
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ValidateFormulaEventOut clone() => ValidateFormulaEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ValidateFormulaEventOut copyWith(void Function(ValidateFormulaEventOut) updates) =>
      super.copyWith((message) => updates(message as ValidateFormulaEventOut)) as ValidateFormulaEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateFormulaEventOut create() => ValidateFormulaEventOut._();
  ValidateFormulaEventOut createEmptyInstance() => create();
  static $pb.PbList<ValidateFormulaEventOut> createRepeated() => $pb.PbList<ValidateFormulaEventOut>();
  @$core.pragma('dart2js:noInline')
  static ValidateFormulaEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateFormulaEventOut>(create);
  static ValidateFormulaEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get valid => $_getBF(0);
  @$pb.TagNumber(1)
  set valid($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearValid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class AddGameEventOut extends $pb.GeneratedMessage {
  factory AddGameEventOut({
    $core.int? gameId,
  }) {
    final $result = create();
    if (gameId != null) {
      $result.gameId = gameId;
    }
    return $result;
  }
  AddGameEventOut._() : super();
  factory AddGameEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AddGameEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddGameEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'gameId', $pb.PbFieldType.O3, protoName: 'gameId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AddGameEventOut clone() => AddGameEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AddGameEventOut copyWith(void Function(AddGameEventOut) updates) =>
      super.copyWith((message) => updates(message as AddGameEventOut)) as AddGameEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddGameEventOut create() => AddGameEventOut._();
  AddGameEventOut createEmptyInstance() => create();
  static $pb.PbList<AddGameEventOut> createRepeated() => $pb.PbList<AddGameEventOut>();
  @$core.pragma('dart2js:noInline')
  static AddGameEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddGameEventOut>(create);
  static AddGameEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get gameId => $_getIZ(0);
  @$pb.TagNumber(1)
  set gameId($core.int v) {
    $_setSignedInt32(0, v);
  }

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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  CiScheme._() : super();
  factory CiScheme.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CiScheme.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CiScheme',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CiScheme clone() => CiScheme()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CiScheme copyWith(void Function(CiScheme) updates) =>
      super.copyWith((message) => updates(message as CiScheme)) as CiScheme;

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
  set id($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

class AvailableCiEventOut extends $pb.GeneratedMessage {
  factory AvailableCiEventOut({
    $core.Iterable<CiScheme>? schemes,
  }) {
    final $result = create();
    if (schemes != null) {
      $result.schemes.addAll(schemes);
    }
    return $result;
  }
  AvailableCiEventOut._() : super();
  factory AvailableCiEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AvailableCiEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AvailableCiEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<CiScheme>(1, _omitFieldNames ? '' : 'schemes', $pb.PbFieldType.PM, subBuilder: CiScheme.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AvailableCiEventOut clone() => AvailableCiEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AvailableCiEventOut copyWith(void Function(AvailableCiEventOut) updates) =>
      super.copyWith((message) => updates(message as AvailableCiEventOut)) as AvailableCiEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AvailableCiEventOut create() => AvailableCiEventOut._();
  AvailableCiEventOut createEmptyInstance() => create();
  static $pb.PbList<AvailableCiEventOut> createRepeated() => $pb.PbList<AvailableCiEventOut>();
  @$core.pragma('dart2js:noInline')
  static AvailableCiEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AvailableCiEventOut>(create);
  static AvailableCiEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CiScheme> get schemes => $_getList(0);
}

class SetFinalPlayersEvent extends $pb.GeneratedMessage {
  factory SetFinalPlayersEvent({
    $core.Iterable<$core.int>? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id.addAll(id);
    }
    return $result;
  }
  SetFinalPlayersEvent._() : super();
  factory SetFinalPlayersEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SetFinalPlayersEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetFinalPlayersEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.K3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SetFinalPlayersEvent clone() => SetFinalPlayersEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SetFinalPlayersEvent copyWith(void Function(SetFinalPlayersEvent) updates) =>
      super.copyWith((message) => updates(message as SetFinalPlayersEvent)) as SetFinalPlayersEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetFinalPlayersEvent create() => SetFinalPlayersEvent._();
  SetFinalPlayersEvent createEmptyInstance() => create();
  static $pb.PbList<SetFinalPlayersEvent> createRepeated() => $pb.PbList<SetFinalPlayersEvent>();
  @$core.pragma('dart2js:noInline')
  static SetFinalPlayersEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetFinalPlayersEvent>(create);
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
    $core.Iterable<$core.int>? minusScore,
  }) {
    final $result = create();
    if (addScore != null) {
      $result.addScore.addAll(addScore);
    }
    if (players != null) {
      $result.players.addAll(players);
    }
    if (win != null) {
      $result.win = win;
    }
    if (firstDie != null) {
      $result.firstDie = firstDie;
    }
    if (bestMove != null) {
      $result.bestMove = bestMove;
    }
    if (date != null) {
      $result.date = date;
    }
    if (referee != null) {
      $result.referee = referee;
    }
    if (mafia1 != null) {
      $result.mafia1 = mafia1;
    }
    if (mafia2 != null) {
      $result.mafia2 = mafia2;
    }
    if (don != null) {
      $result.don = don;
    }
    if (sheriff != null) {
      $result.sheriff = sheriff;
    }
    if (ciId != null) {
      $result.ciId = ciId;
    }
    if (ratingScheme != null) {
      $result.ratingScheme = ratingScheme;
    }
    if (minusScore != null) {
      $result.minusScore.addAll(minusScore);
    }
    return $result;
  }
  ClubGameResult._() : super();
  factory ClubGameResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ClubGameResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClubGameResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'addScore', $pb.PbFieldType.K3, protoName: 'addScore')
    ..p<$core.int>(2, _omitFieldNames ? '' : 'players', $pb.PbFieldType.K3)
    ..e<GameWin>(3, _omitFieldNames ? '' : 'win', $pb.PbFieldType.OE,
        defaultOrMaker: GameWin.city, valueOf: GameWin.valueOf, enumValues: GameWin.values)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'firstDie', $pb.PbFieldType.O3, protoName: 'firstDie')
    ..e<BestMove>(5, _omitFieldNames ? '' : 'bestMove', $pb.PbFieldType.OE,
        protoName: 'bestMove', defaultOrMaker: BestMove.miss, valueOf: BestMove.valueOf, enumValues: BestMove.values)
    ..aOS(6, _omitFieldNames ? '' : 'date')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'referee', $pb.PbFieldType.O3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'mafia1', $pb.PbFieldType.O3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'mafia2', $pb.PbFieldType.O3)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'don', $pb.PbFieldType.O3)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'sheriff', $pb.PbFieldType.O3)
    ..a<$core.int>(12, _omitFieldNames ? '' : 'ciId', $pb.PbFieldType.O3, protoName: 'ciId')
    ..e<RatingScheme>(13, _omitFieldNames ? '' : 'ratingScheme', $pb.PbFieldType.OE,
        protoName: 'ratingScheme',
        defaultOrMaker: RatingScheme.oldFSM,
        valueOf: RatingScheme.valueOf,
        enumValues: RatingScheme.values)
    ..p<$core.int>(14, _omitFieldNames ? '' : 'minusScore', $pb.PbFieldType.K3, protoName: 'minusScore')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ClubGameResult clone() => ClubGameResult()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ClubGameResult copyWith(void Function(ClubGameResult) updates) =>
      super.copyWith((message) => updates(message as ClubGameResult)) as ClubGameResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClubGameResult create() => ClubGameResult._();
  ClubGameResult createEmptyInstance() => create();
  static $pb.PbList<ClubGameResult> createRepeated() => $pb.PbList<ClubGameResult>();
  @$core.pragma('dart2js:noInline')
  static ClubGameResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClubGameResult>(create);
  static ClubGameResult? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.int> get addScore => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.int> get players => $_getList(1);

  @$pb.TagNumber(3)
  GameWin get win => $_getN(2);
  @$pb.TagNumber(3)
  set win(GameWin v) {
    $_setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasWin() => $_has(2);
  @$pb.TagNumber(3)
  void clearWin() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get firstDie => $_getIZ(3);
  @$pb.TagNumber(4)
  set firstDie($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasFirstDie() => $_has(3);
  @$pb.TagNumber(4)
  void clearFirstDie() => $_clearField(4);

  @$pb.TagNumber(5)
  BestMove get bestMove => $_getN(4);
  @$pb.TagNumber(5)
  set bestMove(BestMove v) {
    $_setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasBestMove() => $_has(4);
  @$pb.TagNumber(5)
  void clearBestMove() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get date => $_getSZ(5);
  @$pb.TagNumber(6)
  set date($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearDate() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get referee => $_getIZ(6);
  @$pb.TagNumber(7)
  set referee($core.int v) {
    $_setSignedInt32(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasReferee() => $_has(6);
  @$pb.TagNumber(7)
  void clearReferee() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get mafia1 => $_getIZ(7);
  @$pb.TagNumber(8)
  set mafia1($core.int v) {
    $_setSignedInt32(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasMafia1() => $_has(7);
  @$pb.TagNumber(8)
  void clearMafia1() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get mafia2 => $_getIZ(8);
  @$pb.TagNumber(9)
  set mafia2($core.int v) {
    $_setSignedInt32(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasMafia2() => $_has(8);
  @$pb.TagNumber(9)
  void clearMafia2() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get don => $_getIZ(9);
  @$pb.TagNumber(10)
  set don($core.int v) {
    $_setSignedInt32(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasDon() => $_has(9);
  @$pb.TagNumber(10)
  void clearDon() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get sheriff => $_getIZ(10);
  @$pb.TagNumber(11)
  set sheriff($core.int v) {
    $_setSignedInt32(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasSheriff() => $_has(10);
  @$pb.TagNumber(11)
  void clearSheriff() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get ciId => $_getIZ(11);
  @$pb.TagNumber(12)
  set ciId($core.int v) {
    $_setSignedInt32(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasCiId() => $_has(11);
  @$pb.TagNumber(12)
  void clearCiId() => $_clearField(12);

  @$pb.TagNumber(13)
  RatingScheme get ratingScheme => $_getN(12);
  @$pb.TagNumber(13)
  set ratingScheme(RatingScheme v) {
    $_setField(13, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasRatingScheme() => $_has(12);
  @$pb.TagNumber(13)
  void clearRatingScheme() => $_clearField(13);

  @$pb.TagNumber(14)
  $pb.PbList<$core.int> get minusScore => $_getList(13);
}

class ClubsEventOut extends $pb.GeneratedMessage {
  factory ClubsEventOut({
    $core.Iterable<Club>? club,
  }) {
    final $result = create();
    if (club != null) {
      $result.club.addAll(club);
    }
    return $result;
  }
  ClubsEventOut._() : super();
  factory ClubsEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ClubsEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClubsEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<Club>(1, _omitFieldNames ? '' : 'club', $pb.PbFieldType.PM, subBuilder: Club.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ClubsEventOut clone() => ClubsEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ClubsEventOut copyWith(void Function(ClubsEventOut) updates) =>
      super.copyWith((message) => updates(message as ClubsEventOut)) as ClubsEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClubsEventOut create() => ClubsEventOut._();
  ClubsEventOut createEmptyInstance() => create();
  static $pb.PbList<ClubsEventOut> createRepeated() => $pb.PbList<ClubsEventOut>();
  @$core.pragma('dart2js:noInline')
  static ClubsEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClubsEventOut>(create);
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
    final $result = create();
    if (roles != null) {
      $result.roles.addAll(roles);
    }
    if (status != null) {
      $result.status.addAll(status);
    }
    if (images != null) {
      $result.images.addAll(images);
    }
    if (names != null) {
      $result.names.addAll(names);
    }
    if (game != null) {
      $result.game = game;
    }
    if (totalGames != null) {
      $result.totalGames = totalGames;
    }
    return $result;
  }
  SeatingContent._() : super();
  factory SeatingContent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SeatingContent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SeatingContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<PlayerRole>(1, _omitFieldNames ? '' : 'roles', $pb.PbFieldType.KE,
        valueOf: PlayerRole.valueOf, enumValues: PlayerRole.values, defaultEnumValue: PlayerRole.citizen)
    ..pc<PlayerStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.KE,
        valueOf: PlayerStatus.valueOf, enumValues: PlayerStatus.values, defaultEnumValue: PlayerStatus.alive)
    ..pPS(3, _omitFieldNames ? '' : 'images')
    ..pPS(4, _omitFieldNames ? '' : 'names')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'game', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'totalGames', $pb.PbFieldType.O3, protoName: 'totalGames')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SeatingContent clone() => SeatingContent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SeatingContent copyWith(void Function(SeatingContent) updates) =>
      super.copyWith((message) => updates(message as SeatingContent)) as SeatingContent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SeatingContent create() => SeatingContent._();
  SeatingContent createEmptyInstance() => create();
  static $pb.PbList<SeatingContent> createRepeated() => $pb.PbList<SeatingContent>();
  @$core.pragma('dart2js:noInline')
  static SeatingContent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SeatingContent>(create);
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
  set game($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasGame() => $_has(4);
  @$pb.TagNumber(5)
  void clearGame() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get totalGames => $_getIZ(5);
  @$pb.TagNumber(6)
  set totalGames($core.int v) {
    $_setSignedInt32(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasTotalGames() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalGames() => $_clearField(6);
}

class LoginByTokenEvent extends $pb.GeneratedMessage {
  factory LoginByTokenEvent({
    $core.String? token,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  LoginByTokenEvent._() : super();
  factory LoginByTokenEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LoginByTokenEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LoginByTokenEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LoginByTokenEvent clone() => LoginByTokenEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LoginByTokenEvent copyWith(void Function(LoginByTokenEvent) updates) =>
      super.copyWith((message) => updates(message as LoginByTokenEvent)) as LoginByTokenEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginByTokenEvent create() => LoginByTokenEvent._();
  LoginByTokenEvent createEmptyInstance() => create();
  static $pb.PbList<LoginByTokenEvent> createRepeated() => $pb.PbList<LoginByTokenEvent>();
  @$core.pragma('dart2js:noInline')
  static LoginByTokenEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginByTokenEvent>(create);
  static LoginByTokenEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) {
    $_setString(0, v);
  }

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
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (recoveryToken != null) {
      $result.recoveryToken = recoveryToken;
    }
    if (error != null) {
      $result.error = error;
    }
    return $result;
  }
  LoginByTokenEventOut._() : super();
  factory LoginByTokenEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LoginByTokenEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LoginByTokenEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'recoveryToken', protoName: 'recoveryToken')
    ..e<LoginByTokenEventOut_Error>(3, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE,
        defaultOrMaker: LoginByTokenEventOut_Error.noError,
        valueOf: LoginByTokenEventOut_Error.valueOf,
        enumValues: LoginByTokenEventOut_Error.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LoginByTokenEventOut clone() => LoginByTokenEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LoginByTokenEventOut copyWith(void Function(LoginByTokenEventOut) updates) =>
      super.copyWith((message) => updates(message as LoginByTokenEventOut)) as LoginByTokenEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginByTokenEventOut create() => LoginByTokenEventOut._();
  LoginByTokenEventOut createEmptyInstance() => create();
  static $pb.PbList<LoginByTokenEventOut> createRepeated() => $pb.PbList<LoginByTokenEventOut>();
  @$core.pragma('dart2js:noInline')
  static LoginByTokenEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginByTokenEventOut>(create);
  static LoginByTokenEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get recoveryToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set recoveryToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRecoveryToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecoveryToken() => $_clearField(2);

  @$pb.TagNumber(3)
  LoginByTokenEventOut_Error get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(LoginByTokenEventOut_Error v) {
    $_setField(3, v);
  }

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
    final $result = create();
    if (gomafiaUrl != null) {
      $result.gomafiaUrl = gomafiaUrl;
    }
    if (vkGroupUrl != null) {
      $result.vkGroupUrl = vkGroupUrl;
    }
    if (vkOwnerUrl != null) {
      $result.vkOwnerUrl = vkOwnerUrl;
    }
    return $result;
  }
  TournamentDescription._() : super();
  factory TournamentDescription.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TournamentDescription.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TournamentDescription',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'gomafiaUrl', protoName: 'gomafiaUrl')
    ..aOS(2, _omitFieldNames ? '' : 'vkGroupUrl', protoName: 'vkGroupUrl')
    ..aOS(3, _omitFieldNames ? '' : 'vkOwnerUrl', protoName: 'vkOwnerUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TournamentDescription clone() => TournamentDescription()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TournamentDescription copyWith(void Function(TournamentDescription) updates) =>
      super.copyWith((message) => updates(message as TournamentDescription)) as TournamentDescription;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TournamentDescription create() => TournamentDescription._();
  TournamentDescription createEmptyInstance() => create();
  static $pb.PbList<TournamentDescription> createRepeated() => $pb.PbList<TournamentDescription>();
  @$core.pragma('dart2js:noInline')
  static TournamentDescription getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TournamentDescription>(create);
  static TournamentDescription? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get gomafiaUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set gomafiaUrl($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasGomafiaUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearGomafiaUrl() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get vkGroupUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set vkGroupUrl($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasVkGroupUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearVkGroupUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get vkOwnerUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set vkOwnerUrl($core.String v) {
    $_setString(2, v);
  }

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
    final $result = create();
    if (email != null) {
      $result.email = email;
    }
    if (password != null) {
      $result.password = password;
    }
    return $result;
  }
  SignUpEvent._() : super();
  factory SignUpEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SignUpEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignUpEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SignUpEvent clone() => SignUpEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SignUpEvent copyWith(void Function(SignUpEvent) updates) =>
      super.copyWith((message) => updates(message as SignUpEvent)) as SignUpEvent;

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
  set email($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) {
    $_setString(1, v);
  }

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
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (recoveryToken != null) {
      $result.recoveryToken = recoveryToken;
    }
    if (error != null) {
      $result.error = error;
    }
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  SignUpEventOut._() : super();
  factory SignUpEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SignUpEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignUpEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'recoveryToken', protoName: 'recoveryToken')
    ..e<SignUpEventOut_Error>(3, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE,
        defaultOrMaker: SignUpEventOut_Error.noError,
        valueOf: SignUpEventOut_Error.valueOf,
        enumValues: SignUpEventOut_Error.values)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SignUpEventOut clone() => SignUpEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SignUpEventOut copyWith(void Function(SignUpEventOut) updates) =>
      super.copyWith((message) => updates(message as SignUpEventOut)) as SignUpEventOut;

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
  set token($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get recoveryToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set recoveryToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRecoveryToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecoveryToken() => $_clearField(2);

  @$pb.TagNumber(3)
  SignUpEventOut_Error get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(SignUpEventOut_Error v) {
    $_setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get id => $_getIZ(3);
  @$pb.TagNumber(4)
  set id($core.int v) {
    $_setSignedInt32(3, v);
  }

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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  EmailVerificationEvent._() : super();
  factory EmailVerificationEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EmailVerificationEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmailVerificationEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EmailVerificationEvent clone() => EmailVerificationEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EmailVerificationEvent copyWith(void Function(EmailVerificationEvent) updates) =>
      super.copyWith((message) => updates(message as EmailVerificationEvent)) as EmailVerificationEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailVerificationEvent create() => EmailVerificationEvent._();
  EmailVerificationEvent createEmptyInstance() => create();
  static $pb.PbList<EmailVerificationEvent> createRepeated() => $pb.PbList<EmailVerificationEvent>();
  @$core.pragma('dart2js:noInline')
  static EmailVerificationEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmailVerificationEvent>(create);
  static EmailVerificationEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(2)
  set token($core.String v) {
    $_setString(1, v);
  }

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
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (dateStart != null) {
      $result.dateStart = dateStart;
    }
    if (dateEnd != null) {
      $result.dateEnd = dateEnd;
    }
    return $result;
  }
  CreateTournamentEvent._() : super();
  factory CreateTournamentEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateTournamentEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateTournamentEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'dateStart', protoName: 'dateStart')
    ..aOS(3, _omitFieldNames ? '' : 'dateEnd', protoName: 'dateEnd')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateTournamentEvent clone() => CreateTournamentEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateTournamentEvent copyWith(void Function(CreateTournamentEvent) updates) =>
      super.copyWith((message) => updates(message as CreateTournamentEvent)) as CreateTournamentEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTournamentEvent create() => CreateTournamentEvent._();
  CreateTournamentEvent createEmptyInstance() => create();
  static $pb.PbList<CreateTournamentEvent> createRepeated() => $pb.PbList<CreateTournamentEvent>();
  @$core.pragma('dart2js:noInline')
  static CreateTournamentEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTournamentEvent>(create);
  static CreateTournamentEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get dateStart => $_getSZ(1);
  @$pb.TagNumber(2)
  set dateStart($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDateStart() => $_has(1);
  @$pb.TagNumber(2)
  void clearDateStart() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get dateEnd => $_getSZ(2);
  @$pb.TagNumber(3)
  set dateEnd($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDateEnd() => $_has(2);
  @$pb.TagNumber(3)
  void clearDateEnd() => $_clearField(3);
}

class CreateTournamentEventOut extends $pb.GeneratedMessage {
  factory CreateTournamentEventOut({
    $core.int? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  CreateTournamentEventOut._() : super();
  factory CreateTournamentEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateTournamentEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateTournamentEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateTournamentEventOut clone() => CreateTournamentEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateTournamentEventOut copyWith(void Function(CreateTournamentEventOut) updates) =>
      super.copyWith((message) => updates(message as CreateTournamentEventOut)) as CreateTournamentEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTournamentEventOut create() => CreateTournamentEventOut._();
  CreateTournamentEventOut createEmptyInstance() => create();
  static $pb.PbList<CreateTournamentEventOut> createRepeated() => $pb.PbList<CreateTournamentEventOut>();
  @$core.pragma('dart2js:noInline')
  static CreateTournamentEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTournamentEventOut>(create);
  static CreateTournamentEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class AddPlayerEvent extends $pb.GeneratedMessage {
  factory AddPlayerEvent({
    Player? player,
  }) {
    final $result = create();
    if (player != null) {
      $result.player = player;
    }
    return $result;
  }
  AddPlayerEvent._() : super();
  factory AddPlayerEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AddPlayerEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddPlayerEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOM<Player>(1, _omitFieldNames ? '' : 'player', subBuilder: Player.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AddPlayerEvent clone() => AddPlayerEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AddPlayerEvent copyWith(void Function(AddPlayerEvent) updates) =>
      super.copyWith((message) => updates(message as AddPlayerEvent)) as AddPlayerEvent;

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
  set player(Player v) {
    $_setField(1, v);
  }

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
    final $result = create();
    if (player1 != null) {
      $result.player1 = player1;
    }
    if (player2 != null) {
      $result.player2 = player2;
    }
    return $result;
  }
  CannotMeetEditionEvent._() : super();
  factory CannotMeetEditionEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CannotMeetEditionEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CannotMeetEditionEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOM<Player>(1, _omitFieldNames ? '' : 'player1', subBuilder: Player.create)
    ..aOM<Player>(2, _omitFieldNames ? '' : 'player2', subBuilder: Player.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CannotMeetEditionEvent clone() => CannotMeetEditionEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CannotMeetEditionEvent copyWith(void Function(CannotMeetEditionEvent) updates) =>
      super.copyWith((message) => updates(message as CannotMeetEditionEvent)) as CannotMeetEditionEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CannotMeetEditionEvent create() => CannotMeetEditionEvent._();
  CannotMeetEditionEvent createEmptyInstance() => create();
  static $pb.PbList<CannotMeetEditionEvent> createRepeated() => $pb.PbList<CannotMeetEditionEvent>();
  @$core.pragma('dart2js:noInline')
  static CannotMeetEditionEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CannotMeetEditionEvent>(create);
  static CannotMeetEditionEvent? _defaultInstance;

  @$pb.TagNumber(1)
  Player get player1 => $_getN(0);
  @$pb.TagNumber(1)
  set player1(Player v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPlayer1() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer1() => $_clearField(1);
  @$pb.TagNumber(1)
  Player ensurePlayer1() => $_ensure(0);

  @$pb.TagNumber(2)
  Player get player2 => $_getN(1);
  @$pb.TagNumber(2)
  set player2(Player v) {
    $_setField(2, v);
  }

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
    final $result = create();
    if (pairs != null) {
      $result.pairs.addAll(pairs);
    }
    return $result;
  }
  CannotMeetEventOut._() : super();
  factory CannotMeetEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CannotMeetEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CannotMeetEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<CannotMeetEditionEvent>(1, _omitFieldNames ? '' : 'pairs', $pb.PbFieldType.PM,
        subBuilder: CannotMeetEditionEvent.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CannotMeetEventOut clone() => CannotMeetEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CannotMeetEventOut copyWith(void Function(CannotMeetEventOut) updates) =>
      super.copyWith((message) => updates(message as CannotMeetEventOut)) as CannotMeetEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CannotMeetEventOut create() => CannotMeetEventOut._();
  CannotMeetEventOut createEmptyInstance() => create();
  static $pb.PbList<CannotMeetEventOut> createRepeated() => $pb.PbList<CannotMeetEventOut>();
  @$core.pragma('dart2js:noInline')
  static CannotMeetEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CannotMeetEventOut>(create);
  static CannotMeetEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CannotMeetEditionEvent> get pairs => $_getList(0);
}

class GetAvailablePlayerEventOut extends $pb.GeneratedMessage {
  factory GetAvailablePlayerEventOut({
    $core.Iterable<Player>? players,
  }) {
    final $result = create();
    if (players != null) {
      $result.players.addAll(players);
    }
    return $result;
  }
  GetAvailablePlayerEventOut._() : super();
  factory GetAvailablePlayerEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetAvailablePlayerEventOut.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAvailablePlayerEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<Player>(1, _omitFieldNames ? '' : 'players', $pb.PbFieldType.PM, subBuilder: Player.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetAvailablePlayerEventOut clone() => GetAvailablePlayerEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetAvailablePlayerEventOut copyWith(void Function(GetAvailablePlayerEventOut) updates) =>
      super.copyWith((message) => updates(message as GetAvailablePlayerEventOut)) as GetAvailablePlayerEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAvailablePlayerEventOut create() => GetAvailablePlayerEventOut._();
  GetAvailablePlayerEventOut createEmptyInstance() => create();
  static $pb.PbList<GetAvailablePlayerEventOut> createRepeated() => $pb.PbList<GetAvailablePlayerEventOut>();
  @$core.pragma('dart2js:noInline')
  static GetAvailablePlayerEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAvailablePlayerEventOut>(create);
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
    RatingScheme? scheme,
    FantasyStatus? fantasyStatus,
  }) {
    final $result = create();
    if (defaultGamesCount != null) {
      $result.defaultGamesCount = defaultGamesCount;
    }
    if (swissGamesCount != null) {
      $result.swissGamesCount = swissGamesCount;
    }
    if (finalGamesCount != null) {
      $result.finalGamesCount = finalGamesCount;
    }
    if (buckets != null) {
      $result.buckets.addAll(buckets);
    }
    if (hideResult != null) {
      $result.hideResult = hideResult;
    }
    if (scheme != null) {
      $result.scheme = scheme;
    }
    if (fantasyStatus != null) {
      $result.fantasyStatus = fantasyStatus;
    }
    return $result;
  }
  TournamentSettings._() : super();
  factory TournamentSettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TournamentSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TournamentSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'defaultGamesCount', $pb.PbFieldType.O3, protoName: 'defaultGamesCount')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'swissGamesCount', $pb.PbFieldType.O3, protoName: 'swissGamesCount')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'finalGamesCount', $pb.PbFieldType.O3, protoName: 'finalGamesCount')
    ..p<$core.int>(4, _omitFieldNames ? '' : 'buckets', $pb.PbFieldType.K3)
    ..aOB(5, _omitFieldNames ? '' : 'hideResult', protoName: 'hideResult')
    ..e<RatingScheme>(6, _omitFieldNames ? '' : 'scheme', $pb.PbFieldType.OE,
        defaultOrMaker: RatingScheme.oldFSM, valueOf: RatingScheme.valueOf, enumValues: RatingScheme.values)
    ..e<FantasyStatus>(7, _omitFieldNames ? '' : 'fantasyStatus', $pb.PbFieldType.OE,
        protoName: 'fantasyStatus',
        defaultOrMaker: FantasyStatus.disabled,
        valueOf: FantasyStatus.valueOf,
        enumValues: FantasyStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TournamentSettings clone() => TournamentSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TournamentSettings copyWith(void Function(TournamentSettings) updates) =>
      super.copyWith((message) => updates(message as TournamentSettings)) as TournamentSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TournamentSettings create() => TournamentSettings._();
  TournamentSettings createEmptyInstance() => create();
  static $pb.PbList<TournamentSettings> createRepeated() => $pb.PbList<TournamentSettings>();
  @$core.pragma('dart2js:noInline')
  static TournamentSettings getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TournamentSettings>(create);
  static TournamentSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get defaultGamesCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set defaultGamesCount($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDefaultGamesCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearDefaultGamesCount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get swissGamesCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set swissGamesCount($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSwissGamesCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearSwissGamesCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get finalGamesCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set finalGamesCount($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFinalGamesCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearFinalGamesCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.int> get buckets => $_getList(3);

  @$pb.TagNumber(5)
  $core.bool get hideResult => $_getBF(4);
  @$pb.TagNumber(5)
  set hideResult($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasHideResult() => $_has(4);
  @$pb.TagNumber(5)
  void clearHideResult() => $_clearField(5);

  @$pb.TagNumber(6)
  RatingScheme get scheme => $_getN(5);
  @$pb.TagNumber(6)
  set scheme(RatingScheme v) {
    $_setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasScheme() => $_has(5);
  @$pb.TagNumber(6)
  void clearScheme() => $_clearField(6);

  @$pb.TagNumber(7)
  FantasyStatus get fantasyStatus => $_getN(6);
  @$pb.TagNumber(7)
  set fantasyStatus(FantasyStatus v) {
    $_setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasFantasyStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearFantasyStatus() => $_clearField(7);
}

class UserProfile extends $pb.GeneratedMessage {
  factory UserProfile({
    Player? player,
  }) {
    final $result = create();
    if (player != null) {
      $result.player = player;
    }
    return $result;
  }
  UserProfile._() : super();
  factory UserProfile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UserProfile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserProfile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOM<Player>(1, _omitFieldNames ? '' : 'player', subBuilder: Player.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UserProfile clone() => UserProfile()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UserProfile copyWith(void Function(UserProfile) updates) =>
      super.copyWith((message) => updates(message as UserProfile)) as UserProfile;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserProfile create() => UserProfile._();
  UserProfile createEmptyInstance() => create();
  static $pb.PbList<UserProfile> createRepeated() => $pb.PbList<UserProfile>();
  @$core.pragma('dart2js:noInline')
  static UserProfile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserProfile>(create);
  static UserProfile? _defaultInstance;

  @$pb.TagNumber(1)
  Player get player => $_getN(0);
  @$pb.TagNumber(1)
  set player(Player v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPlayer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer() => $_clearField(1);
  @$pb.TagNumber(1)
  Player ensurePlayer() => $_ensure(0);
}

class Profile extends $pb.GeneratedMessage {
  factory Profile({
    $core.String? firstName,
    $core.String? secondName,
  }) {
    final $result = create();
    if (firstName != null) {
      $result.firstName = firstName;
    }
    if (secondName != null) {
      $result.secondName = secondName;
    }
    return $result;
  }
  Profile._() : super();
  factory Profile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Profile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Profile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'firstName', protoName: 'firstName')
    ..aOS(2, _omitFieldNames ? '' : 'secondName', protoName: 'secondName')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Profile clone() => Profile()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Profile copyWith(void Function(Profile) updates) =>
      super.copyWith((message) => updates(message as Profile)) as Profile;

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
  set firstName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFirstName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get secondName => $_getSZ(1);
  @$pb.TagNumber(2)
  set secondName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSecondName() => $_has(1);
  @$pb.TagNumber(2)
  void clearSecondName() => $_clearField(2);
}

class CreatePlayerEventOut extends $pb.GeneratedMessage {
  factory CreatePlayerEventOut({
    $core.int? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  CreatePlayerEventOut._() : super();
  factory CreatePlayerEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreatePlayerEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreatePlayerEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreatePlayerEventOut clone() => CreatePlayerEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreatePlayerEventOut copyWith(void Function(CreatePlayerEventOut) updates) =>
      super.copyWith((message) => updates(message as CreatePlayerEventOut)) as CreatePlayerEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePlayerEventOut create() => CreatePlayerEventOut._();
  CreatePlayerEventOut createEmptyInstance() => create();
  static $pb.PbList<CreatePlayerEventOut> createRepeated() => $pb.PbList<CreatePlayerEventOut>();
  @$core.pragma('dart2js:noInline')
  static CreatePlayerEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePlayerEventOut>(create);
  static CreatePlayerEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class CreatePlayerEvent extends $pb.GeneratedMessage {
  factory CreatePlayerEvent({
    Player? player,
  }) {
    final $result = create();
    if (player != null) {
      $result.player = player;
    }
    return $result;
  }
  CreatePlayerEvent._() : super();
  factory CreatePlayerEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreatePlayerEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreatePlayerEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOM<Player>(1, _omitFieldNames ? '' : 'player', subBuilder: Player.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreatePlayerEvent clone() => CreatePlayerEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreatePlayerEvent copyWith(void Function(CreatePlayerEvent) updates) =>
      super.copyWith((message) => updates(message as CreatePlayerEvent)) as CreatePlayerEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePlayerEvent create() => CreatePlayerEvent._();
  CreatePlayerEvent createEmptyInstance() => create();
  static $pb.PbList<CreatePlayerEvent> createRepeated() => $pb.PbList<CreatePlayerEvent>();
  @$core.pragma('dart2js:noInline')
  static CreatePlayerEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePlayerEvent>(create);
  static CreatePlayerEvent? _defaultInstance;

  @$pb.TagNumber(1)
  Player get player => $_getN(0);
  @$pb.TagNumber(1)
  set player(Player v) {
    $_setField(1, v);
  }

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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (nickname != null) {
      $result.nickname = nickname;
    }
    if (fsmNickname != null) {
      $result.fsmNickname = fsmNickname;
    }
    if (mafbankNickname != null) {
      $result.mafbankNickname = mafbankNickname;
    }
    if (image != null) {
      $result.image = image;
    }
    return $result;
  }
  Player._() : super();
  factory Player.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Player.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Player',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'nickname')
    ..aOS(3, _omitFieldNames ? '' : 'fsmNickname', protoName: 'fsmNickname')
    ..aOS(4, _omitFieldNames ? '' : 'mafbankNickname', protoName: 'mafbankNickname')
    ..aOS(5, _omitFieldNames ? '' : 'image')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Player clone() => Player()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Player copyWith(void Function(Player) updates) => super.copyWith((message) => updates(message as Player)) as Player;

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
  set id($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get nickname => $_getSZ(1);
  @$pb.TagNumber(2)
  set nickname($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNickname() => $_has(1);
  @$pb.TagNumber(2)
  void clearNickname() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get fsmNickname => $_getSZ(2);
  @$pb.TagNumber(3)
  set fsmNickname($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFsmNickname() => $_has(2);
  @$pb.TagNumber(3)
  void clearFsmNickname() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get mafbankNickname => $_getSZ(3);
  @$pb.TagNumber(4)
  set mafbankNickname($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMafbankNickname() => $_has(3);
  @$pb.TagNumber(4)
  void clearMafbankNickname() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get image => $_getSZ(4);
  @$pb.TagNumber(5)
  set image($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasImage() => $_has(4);
  @$pb.TagNumber(5)
  void clearImage() => $_clearField(5);
}

class CreateSwissRound extends $pb.GeneratedMessage {
  factory CreateSwissRound({
    $core.int? game,
  }) {
    final $result = create();
    if (game != null) {
      $result.game = game;
    }
    return $result;
  }
  CreateSwissRound._() : super();
  factory CreateSwissRound.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateSwissRound.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateSwissRound',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'game', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateSwissRound clone() => CreateSwissRound()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateSwissRound copyWith(void Function(CreateSwissRound) updates) =>
      super.copyWith((message) => updates(message as CreateSwissRound)) as CreateSwissRound;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateSwissRound create() => CreateSwissRound._();
  CreateSwissRound createEmptyInstance() => create();
  static $pb.PbList<CreateSwissRound> createRepeated() => $pb.PbList<CreateSwissRound>();
  @$core.pragma('dart2js:noInline')
  static CreateSwissRound getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateSwissRound>(create);
  static CreateSwissRound? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get game => $_getIZ(0);
  @$pb.TagNumber(1)
  set game($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasGame() => $_has(0);
  @$pb.TagNumber(1)
  void clearGame() => $_clearField(1);
}

class EmailVerificationEventOut extends $pb.GeneratedMessage {
  factory EmailVerificationEventOut({
    EmailVerificationEventOut_Status? status,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  EmailVerificationEventOut._() : super();
  factory EmailVerificationEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EmailVerificationEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmailVerificationEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..e<EmailVerificationEventOut_Status>(1, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: EmailVerificationEventOut_Status.success,
        valueOf: EmailVerificationEventOut_Status.valueOf,
        enumValues: EmailVerificationEventOut_Status.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EmailVerificationEventOut clone() => EmailVerificationEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EmailVerificationEventOut copyWith(void Function(EmailVerificationEventOut) updates) =>
      super.copyWith((message) => updates(message as EmailVerificationEventOut)) as EmailVerificationEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailVerificationEventOut create() => EmailVerificationEventOut._();
  EmailVerificationEventOut createEmptyInstance() => create();
  static $pb.PbList<EmailVerificationEventOut> createRepeated() => $pb.PbList<EmailVerificationEventOut>();
  @$core.pragma('dart2js:noInline')
  static EmailVerificationEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmailVerificationEventOut>(create);
  static EmailVerificationEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  EmailVerificationEventOut_Status get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(EmailVerificationEventOut_Status v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class GetFinalPlayersOut extends $pb.GeneratedMessage {
  factory GetFinalPlayersOut({
    $core.Iterable<Player>? player,
  }) {
    final $result = create();
    if (player != null) {
      $result.player.addAll(player);
    }
    return $result;
  }
  GetFinalPlayersOut._() : super();
  factory GetFinalPlayersOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetFinalPlayersOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFinalPlayersOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<Player>(1, _omitFieldNames ? '' : 'player', $pb.PbFieldType.PM, subBuilder: Player.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetFinalPlayersOut clone() => GetFinalPlayersOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetFinalPlayersOut copyWith(void Function(GetFinalPlayersOut) updates) =>
      super.copyWith((message) => updates(message as GetFinalPlayersOut)) as GetFinalPlayersOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFinalPlayersOut create() => GetFinalPlayersOut._();
  GetFinalPlayersOut createEmptyInstance() => create();
  static $pb.PbList<GetFinalPlayersOut> createRepeated() => $pb.PbList<GetFinalPlayersOut>();
  @$core.pragma('dart2js:noInline')
  static GetFinalPlayersOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFinalPlayersOut>(create);
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
    final $result = create();
    if (tournamentId != null) {
      $result.tournamentId = tournamentId;
    }
    if (table != null) {
      $result.table = table;
    }
    if (game != null) {
      $result.game = game;
    }
    return $result;
  }
  SeatingForTranslationEvent._() : super();
  factory SeatingForTranslationEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SeatingForTranslationEvent.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SeatingForTranslationEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'tournamentId', $pb.PbFieldType.O3, protoName: 'tournamentId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'table', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'game', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SeatingForTranslationEvent clone() => SeatingForTranslationEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SeatingForTranslationEvent copyWith(void Function(SeatingForTranslationEvent) updates) =>
      super.copyWith((message) => updates(message as SeatingForTranslationEvent)) as SeatingForTranslationEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SeatingForTranslationEvent create() => SeatingForTranslationEvent._();
  SeatingForTranslationEvent createEmptyInstance() => create();
  static $pb.PbList<SeatingForTranslationEvent> createRepeated() => $pb.PbList<SeatingForTranslationEvent>();
  @$core.pragma('dart2js:noInline')
  static SeatingForTranslationEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SeatingForTranslationEvent>(create);
  static SeatingForTranslationEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get tournamentId => $_getIZ(0);
  @$pb.TagNumber(1)
  set tournamentId($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTournamentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTournamentId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get table => $_getIZ(1);
  @$pb.TagNumber(2)
  set table($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTable() => $_has(1);
  @$pb.TagNumber(2)
  void clearTable() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get game => $_getIZ(2);
  @$pb.TagNumber(3)
  set game($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasGame() => $_has(2);
  @$pb.TagNumber(3)
  void clearGame() => $_clearField(3);
}

class SeatingForTranslationEventOut extends $pb.GeneratedMessage {
  factory SeatingForTranslationEventOut({
    $core.Iterable<$core.String>? players,
  }) {
    final $result = create();
    if (players != null) {
      $result.players.addAll(players);
    }
    return $result;
  }
  SeatingForTranslationEventOut._() : super();
  factory SeatingForTranslationEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SeatingForTranslationEventOut.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SeatingForTranslationEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'players')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SeatingForTranslationEventOut clone() => SeatingForTranslationEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SeatingForTranslationEventOut copyWith(void Function(SeatingForTranslationEventOut) updates) =>
      super.copyWith((message) => updates(message as SeatingForTranslationEventOut)) as SeatingForTranslationEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SeatingForTranslationEventOut create() => SeatingForTranslationEventOut._();
  SeatingForTranslationEventOut createEmptyInstance() => create();
  static $pb.PbList<SeatingForTranslationEventOut> createRepeated() => $pb.PbList<SeatingForTranslationEventOut>();
  @$core.pragma('dart2js:noInline')
  static SeatingForTranslationEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SeatingForTranslationEventOut>(create);
  static SeatingForTranslationEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get players => $_getList(0);
}

class InsertSeatingEvent extends $pb.GeneratedMessage {
  factory InsertSeatingEvent({
    $core.List<$core.int>? bytes,
    $core.int? tournamentId,
  }) {
    final $result = create();
    if (bytes != null) {
      $result.bytes = bytes;
    }
    if (tournamentId != null) {
      $result.tournamentId = tournamentId;
    }
    return $result;
  }
  InsertSeatingEvent._() : super();
  factory InsertSeatingEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory InsertSeatingEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InsertSeatingEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'bytes', $pb.PbFieldType.OY)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'tournamentId', $pb.PbFieldType.O3, protoName: 'tournamentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  InsertSeatingEvent clone() => InsertSeatingEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  InsertSeatingEvent copyWith(void Function(InsertSeatingEvent) updates) =>
      super.copyWith((message) => updates(message as InsertSeatingEvent)) as InsertSeatingEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsertSeatingEvent create() => InsertSeatingEvent._();
  InsertSeatingEvent createEmptyInstance() => create();
  static $pb.PbList<InsertSeatingEvent> createRepeated() => $pb.PbList<InsertSeatingEvent>();
  @$core.pragma('dart2js:noInline')
  static InsertSeatingEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsertSeatingEvent>(create);
  static InsertSeatingEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get bytes => $_getN(0);
  @$pb.TagNumber(1)
  set bytes($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasBytes() => $_has(0);
  @$pb.TagNumber(1)
  void clearBytes() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get tournamentId => $_getIZ(1);
  @$pb.TagNumber(2)
  set tournamentId($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTournamentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTournamentId() => $_clearField(2);
}

class GetTournamentsEventOut extends $pb.GeneratedMessage {
  factory GetTournamentsEventOut({
    $core.Iterable<Tournament>? tournaments,
  }) {
    final $result = create();
    if (tournaments != null) {
      $result.tournaments.addAll(tournaments);
    }
    return $result;
  }
  GetTournamentsEventOut._() : super();
  factory GetTournamentsEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetTournamentsEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTournamentsEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<Tournament>(1, _omitFieldNames ? '' : 'tournaments', $pb.PbFieldType.PM, subBuilder: Tournament.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetTournamentsEventOut clone() => GetTournamentsEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetTournamentsEventOut copyWith(void Function(GetTournamentsEventOut) updates) =>
      super.copyWith((message) => updates(message as GetTournamentsEventOut)) as GetTournamentsEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTournamentsEventOut create() => GetTournamentsEventOut._();
  GetTournamentsEventOut createEmptyInstance() => create();
  static $pb.PbList<GetTournamentsEventOut> createRepeated() => $pb.PbList<GetTournamentsEventOut>();
  @$core.pragma('dart2js:noInline')
  static GetTournamentsEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTournamentsEventOut>(create);
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
    $core.int? photoThemeId,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (status != null) {
      $result.status = status;
    }
    if (dateStart != null) {
      $result.dateStart = dateStart;
    }
    if (dateEnd != null) {
      $result.dateEnd = dateEnd;
    }
    if (gamesCount != null) {
      $result.gamesCount = gamesCount;
    }
    if (billedPlayers != null) {
      $result.billedPlayers = billedPlayers;
    }
    if (billedTranslation != null) {
      $result.billedTranslation = billedTranslation;
    }
    if (notificationEnabled != null) {
      $result.notificationEnabled = notificationEnabled;
    }
    if (description != null) {
      $result.description = description;
    }
    if (photoThemeId != null) {
      $result.photoThemeId = photoThemeId;
    }
    return $result;
  }
  Tournament._() : super();
  factory Tournament.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Tournament.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Tournament',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..e<Tournament_Status>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: Tournament_Status.waitForBilling,
        valueOf: Tournament_Status.valueOf,
        enumValues: Tournament_Status.values)
    ..aOS(4, _omitFieldNames ? '' : 'dateStart', protoName: 'dateStart')
    ..aOS(5, _omitFieldNames ? '' : 'dateEnd', protoName: 'dateEnd')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'gamesCount', $pb.PbFieldType.O3, protoName: 'gamesCount')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'billedPlayers', $pb.PbFieldType.O3, protoName: 'billedPlayers')
    ..aOB(8, _omitFieldNames ? '' : 'billedTranslation', protoName: 'billedTranslation')
    ..aOB(9, _omitFieldNames ? '' : 'notificationEnabled', protoName: 'notificationEnabled')
    ..aOM<TournamentDescription>(10, _omitFieldNames ? '' : 'description', subBuilder: TournamentDescription.create)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'photoThemeId', $pb.PbFieldType.O3, protoName: 'photoThemeId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Tournament clone() => Tournament()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Tournament copyWith(void Function(Tournament) updates) =>
      super.copyWith((message) => updates(message as Tournament)) as Tournament;

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
  set id($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  Tournament_Status get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(Tournament_Status v) {
    $_setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get dateStart => $_getSZ(3);
  @$pb.TagNumber(4)
  set dateStart($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDateStart() => $_has(3);
  @$pb.TagNumber(4)
  void clearDateStart() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get dateEnd => $_getSZ(4);
  @$pb.TagNumber(5)
  set dateEnd($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasDateEnd() => $_has(4);
  @$pb.TagNumber(5)
  void clearDateEnd() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get gamesCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set gamesCount($core.int v) {
    $_setSignedInt32(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasGamesCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearGamesCount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get billedPlayers => $_getIZ(6);
  @$pb.TagNumber(7)
  set billedPlayers($core.int v) {
    $_setSignedInt32(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasBilledPlayers() => $_has(6);
  @$pb.TagNumber(7)
  void clearBilledPlayers() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get billedTranslation => $_getBF(7);
  @$pb.TagNumber(8)
  set billedTranslation($core.bool v) {
    $_setBool(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasBilledTranslation() => $_has(7);
  @$pb.TagNumber(8)
  void clearBilledTranslation() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get notificationEnabled => $_getBF(8);
  @$pb.TagNumber(9)
  set notificationEnabled($core.bool v) {
    $_setBool(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasNotificationEnabled() => $_has(8);
  @$pb.TagNumber(9)
  void clearNotificationEnabled() => $_clearField(9);

  @$pb.TagNumber(10)
  TournamentDescription get description => $_getN(9);
  @$pb.TagNumber(10)
  set description(TournamentDescription v) {
    $_setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescription() => $_clearField(10);
  @$pb.TagNumber(10)
  TournamentDescription ensureDescription() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.int get photoThemeId => $_getIZ(10);
  @$pb.TagNumber(11)
  set photoThemeId($core.int v) {
    $_setSignedInt32(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasPhotoThemeId() => $_has(10);
  @$pb.TagNumber(11)
  void clearPhotoThemeId() => $_clearField(11);
}

class ErrorOut extends $pb.GeneratedMessage {
  factory ErrorOut({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ErrorOut._() : super();
  factory ErrorOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ErrorOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ErrorOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ErrorOut clone() => ErrorOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ErrorOut copyWith(void Function(ErrorOut) updates) =>
      super.copyWith((message) => updates(message as ErrorOut)) as ErrorOut;

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
  set message($core.String v) {
    $_setString(0, v);
  }

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
    final $result = create();
    if (players != null) {
      $result.players = players;
    }
    if (hasTranslation != null) {
      $result.hasTranslation = hasTranslation;
    }
    if (redirectPath != null) {
      $result.redirectPath = redirectPath;
    }
    return $result;
  }
  BillTournamentEvent._() : super();
  factory BillTournamentEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BillTournamentEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BillTournamentEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'players', $pb.PbFieldType.O3)
    ..aOB(2, _omitFieldNames ? '' : 'hasTranslation', protoName: 'hasTranslation')
    ..aOS(3, _omitFieldNames ? '' : 'redirectPath', protoName: 'redirectPath')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BillTournamentEvent clone() => BillTournamentEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BillTournamentEvent copyWith(void Function(BillTournamentEvent) updates) =>
      super.copyWith((message) => updates(message as BillTournamentEvent)) as BillTournamentEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BillTournamentEvent create() => BillTournamentEvent._();
  BillTournamentEvent createEmptyInstance() => create();
  static $pb.PbList<BillTournamentEvent> createRepeated() => $pb.PbList<BillTournamentEvent>();
  @$core.pragma('dart2js:noInline')
  static BillTournamentEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BillTournamentEvent>(create);
  static BillTournamentEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get players => $_getIZ(0);
  @$pb.TagNumber(1)
  set players($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPlayers() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayers() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get hasTranslation => $_getBF(1);
  @$pb.TagNumber(2)
  set hasTranslation($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasHasTranslation() => $_has(1);
  @$pb.TagNumber(2)
  void clearHasTranslation() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get redirectPath => $_getSZ(2);
  @$pb.TagNumber(3)
  set redirectPath($core.String v) {
    $_setString(2, v);
  }

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
    final $result = create();
    if (days != null) {
      $result.days = days;
    }
    if (redirectPath != null) {
      $result.redirectPath = redirectPath;
    }
    return $result;
  }
  BillClubEvent._() : super();
  factory BillClubEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BillClubEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BillClubEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'days', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'redirectPath', protoName: 'redirectPath')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BillClubEvent clone() => BillClubEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BillClubEvent copyWith(void Function(BillClubEvent) updates) =>
      super.copyWith((message) => updates(message as BillClubEvent)) as BillClubEvent;

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
  set days($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDays() => $_has(0);
  @$pb.TagNumber(1)
  void clearDays() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get redirectPath => $_getSZ(1);
  @$pb.TagNumber(2)
  set redirectPath($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRedirectPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearRedirectPath() => $_clearField(2);
}

class BillTournamentSubscriptionEvent extends $pb.GeneratedMessage {
  factory BillTournamentSubscriptionEvent({
    TournamentSubscriptionType? subscriptionType,
    $core.int? days,
    $core.String? redirectPath,
  }) {
    final $result = create();
    if (subscriptionType != null) {
      $result.subscriptionType = subscriptionType;
    }
    if (days != null) {
      $result.days = days;
    }
    if (redirectPath != null) {
      $result.redirectPath = redirectPath;
    }
    return $result;
  }
  BillTournamentSubscriptionEvent._() : super();
  factory BillTournamentSubscriptionEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BillTournamentSubscriptionEvent.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BillTournamentSubscriptionEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..e<TournamentSubscriptionType>(1, _omitFieldNames ? '' : 'subscriptionType', $pb.PbFieldType.OE,
        protoName: 'subscriptionType',
        defaultOrMaker: TournamentSubscriptionType.unknownTournamentSubscriptionType,
        valueOf: TournamentSubscriptionType.valueOf,
        enumValues: TournamentSubscriptionType.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'days', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'redirectPath', protoName: 'redirectPath')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BillTournamentSubscriptionEvent clone() => BillTournamentSubscriptionEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BillTournamentSubscriptionEvent copyWith(void Function(BillTournamentSubscriptionEvent) updates) =>
      super.copyWith((message) => updates(message as BillTournamentSubscriptionEvent))
          as BillTournamentSubscriptionEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BillTournamentSubscriptionEvent create() => BillTournamentSubscriptionEvent._();
  BillTournamentSubscriptionEvent createEmptyInstance() => create();
  static $pb.PbList<BillTournamentSubscriptionEvent> createRepeated() => $pb.PbList<BillTournamentSubscriptionEvent>();
  @$core.pragma('dart2js:noInline')
  static BillTournamentSubscriptionEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BillTournamentSubscriptionEvent>(create);
  static BillTournamentSubscriptionEvent? _defaultInstance;

  @$pb.TagNumber(1)
  TournamentSubscriptionType get subscriptionType => $_getN(0);
  @$pb.TagNumber(1)
  set subscriptionType(TournamentSubscriptionType v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSubscriptionType() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubscriptionType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get days => $_getIZ(1);
  @$pb.TagNumber(2)
  set days($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDays() => $_has(1);
  @$pb.TagNumber(2)
  void clearDays() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get redirectPath => $_getSZ(2);
  @$pb.TagNumber(3)
  set redirectPath($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRedirectPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearRedirectPath() => $_clearField(3);
}

class BillTournamentEventOut extends $pb.GeneratedMessage {
  factory BillTournamentEventOut({
    $core.String? redirectLink,
  }) {
    final $result = create();
    if (redirectLink != null) {
      $result.redirectLink = redirectLink;
    }
    return $result;
  }
  BillTournamentEventOut._() : super();
  factory BillTournamentEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BillTournamentEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BillTournamentEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'redirectLink', protoName: 'redirectLink')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BillTournamentEventOut clone() => BillTournamentEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BillTournamentEventOut copyWith(void Function(BillTournamentEventOut) updates) =>
      super.copyWith((message) => updates(message as BillTournamentEventOut)) as BillTournamentEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BillTournamentEventOut create() => BillTournamentEventOut._();
  BillTournamentEventOut createEmptyInstance() => create();
  static $pb.PbList<BillTournamentEventOut> createRepeated() => $pb.PbList<BillTournamentEventOut>();
  @$core.pragma('dart2js:noInline')
  static BillTournamentEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BillTournamentEventOut>(create);
  static BillTournamentEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get redirectLink => $_getSZ(0);
  @$pb.TagNumber(1)
  set redirectLink($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRedirectLink() => $_has(0);
  @$pb.TagNumber(1)
  void clearRedirectLink() => $_clearField(1);
}

class TournamentSubscriptionPlanEventOut extends $pb.GeneratedMessage {
  factory TournamentSubscriptionPlanEventOut({
    $core.bool? isActive,
    TournamentSubscriptionType? subscriptionType,
    $core.String? billedFor,
  }) {
    final $result = create();
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (subscriptionType != null) {
      $result.subscriptionType = subscriptionType;
    }
    if (billedFor != null) {
      $result.billedFor = billedFor;
    }
    return $result;
  }
  TournamentSubscriptionPlanEventOut._() : super();
  factory TournamentSubscriptionPlanEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TournamentSubscriptionPlanEventOut.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TournamentSubscriptionPlanEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isActive', protoName: 'isActive')
    ..e<TournamentSubscriptionType>(2, _omitFieldNames ? '' : 'subscriptionType', $pb.PbFieldType.OE,
        protoName: 'subscriptionType',
        defaultOrMaker: TournamentSubscriptionType.unknownTournamentSubscriptionType,
        valueOf: TournamentSubscriptionType.valueOf,
        enumValues: TournamentSubscriptionType.values)
    ..aOS(3, _omitFieldNames ? '' : 'billedFor', protoName: 'billedFor')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TournamentSubscriptionPlanEventOut clone() => TournamentSubscriptionPlanEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TournamentSubscriptionPlanEventOut copyWith(void Function(TournamentSubscriptionPlanEventOut) updates) =>
      super.copyWith((message) => updates(message as TournamentSubscriptionPlanEventOut))
          as TournamentSubscriptionPlanEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TournamentSubscriptionPlanEventOut create() => TournamentSubscriptionPlanEventOut._();
  TournamentSubscriptionPlanEventOut createEmptyInstance() => create();
  static $pb.PbList<TournamentSubscriptionPlanEventOut> createRepeated() =>
      $pb.PbList<TournamentSubscriptionPlanEventOut>();
  @$core.pragma('dart2js:noInline')
  static TournamentSubscriptionPlanEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TournamentSubscriptionPlanEventOut>(create);
  static TournamentSubscriptionPlanEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isActive => $_getBF(0);
  @$pb.TagNumber(1)
  set isActive($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasIsActive() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsActive() => $_clearField(1);

  @$pb.TagNumber(2)
  TournamentSubscriptionType get subscriptionType => $_getN(1);
  @$pb.TagNumber(2)
  set subscriptionType(TournamentSubscriptionType v) {
    $_setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSubscriptionType() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubscriptionType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get billedFor => $_getSZ(2);
  @$pb.TagNumber(3)
  set billedFor($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasBilledFor() => $_has(2);
  @$pb.TagNumber(3)
  void clearBilledFor() => $_clearField(3);
}

class StartGameInfoEvent extends $pb.GeneratedMessage {
  factory StartGameInfoEvent({
    $core.int? game,
    $core.String? localDate,
  }) {
    final $result = create();
    if (game != null) {
      $result.game = game;
    }
    if (localDate != null) {
      $result.localDate = localDate;
    }
    return $result;
  }
  StartGameInfoEvent._() : super();
  factory StartGameInfoEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StartGameInfoEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StartGameInfoEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'game', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'localDate', protoName: 'localDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StartGameInfoEvent clone() => StartGameInfoEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StartGameInfoEvent copyWith(void Function(StartGameInfoEvent) updates) =>
      super.copyWith((message) => updates(message as StartGameInfoEvent)) as StartGameInfoEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartGameInfoEvent create() => StartGameInfoEvent._();
  StartGameInfoEvent createEmptyInstance() => create();
  static $pb.PbList<StartGameInfoEvent> createRepeated() => $pb.PbList<StartGameInfoEvent>();
  @$core.pragma('dart2js:noInline')
  static StartGameInfoEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartGameInfoEvent>(create);
  static StartGameInfoEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get game => $_getIZ(0);
  @$pb.TagNumber(1)
  set game($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasGame() => $_has(0);
  @$pb.TagNumber(1)
  void clearGame() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get localDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set localDate($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLocalDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocalDate() => $_clearField(2);
}

class CustomTextInfoEvent extends $pb.GeneratedMessage {
  factory CustomTextInfoEvent({
    $core.String? text,
  }) {
    final $result = create();
    if (text != null) {
      $result.text = text;
    }
    return $result;
  }
  CustomTextInfoEvent._() : super();
  factory CustomTextInfoEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CustomTextInfoEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CustomTextInfoEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CustomTextInfoEvent clone() => CustomTextInfoEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CustomTextInfoEvent copyWith(void Function(CustomTextInfoEvent) updates) =>
      super.copyWith((message) => updates(message as CustomTextInfoEvent)) as CustomTextInfoEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CustomTextInfoEvent create() => CustomTextInfoEvent._();
  CustomTextInfoEvent createEmptyInstance() => create();
  static $pb.PbList<CustomTextInfoEvent> createRepeated() => $pb.PbList<CustomTextInfoEvent>();
  @$core.pragma('dart2js:noInline')
  static CustomTextInfoEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CustomTextInfoEvent>(create);
  static CustomTextInfoEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);
}

class TakeGomafiaSeatingEvent extends $pb.GeneratedMessage {
  factory TakeGomafiaSeatingEvent({
    $core.int? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  TakeGomafiaSeatingEvent._() : super();
  factory TakeGomafiaSeatingEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TakeGomafiaSeatingEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TakeGomafiaSeatingEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TakeGomafiaSeatingEvent clone() => TakeGomafiaSeatingEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TakeGomafiaSeatingEvent copyWith(void Function(TakeGomafiaSeatingEvent) updates) =>
      super.copyWith((message) => updates(message as TakeGomafiaSeatingEvent)) as TakeGomafiaSeatingEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TakeGomafiaSeatingEvent create() => TakeGomafiaSeatingEvent._();
  TakeGomafiaSeatingEvent createEmptyInstance() => create();
  static $pb.PbList<TakeGomafiaSeatingEvent> createRepeated() => $pb.PbList<TakeGomafiaSeatingEvent>();
  @$core.pragma('dart2js:noInline')
  static TakeGomafiaSeatingEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TakeGomafiaSeatingEvent>(create);
  static TakeGomafiaSeatingEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class TakeGomafiaSeatingEventOut extends $pb.GeneratedMessage {
  factory TakeGomafiaSeatingEventOut({
    $core.Iterable<$core.String>? notFound,
  }) {
    final $result = create();
    if (notFound != null) {
      $result.notFound.addAll(notFound);
    }
    return $result;
  }
  TakeGomafiaSeatingEventOut._() : super();
  factory TakeGomafiaSeatingEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TakeGomafiaSeatingEventOut.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TakeGomafiaSeatingEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'notFound', protoName: 'notFound')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TakeGomafiaSeatingEventOut clone() => TakeGomafiaSeatingEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TakeGomafiaSeatingEventOut copyWith(void Function(TakeGomafiaSeatingEventOut) updates) =>
      super.copyWith((message) => updates(message as TakeGomafiaSeatingEventOut)) as TakeGomafiaSeatingEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TakeGomafiaSeatingEventOut create() => TakeGomafiaSeatingEventOut._();
  TakeGomafiaSeatingEventOut createEmptyInstance() => create();
  static $pb.PbList<TakeGomafiaSeatingEventOut> createRepeated() => $pb.PbList<TakeGomafiaSeatingEventOut>();
  @$core.pragma('dart2js:noInline')
  static TakeGomafiaSeatingEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TakeGomafiaSeatingEventOut>(create);
  static TakeGomafiaSeatingEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get notFound => $_getList(0);
}

class User extends $pb.GeneratedMessage {
  factory User({
    $core.int? id,
    $core.String? email,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (email != null) {
      $result.email = email;
    }
    return $result;
  }
  User._() : super();
  factory User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'User',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User)) as User;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);
}

class TournamentOwnersEventOut extends $pb.GeneratedMessage {
  factory TournamentOwnersEventOut({
    $core.Iterable<User>? owners,
  }) {
    final $result = create();
    if (owners != null) {
      $result.owners.addAll(owners);
    }
    return $result;
  }
  TournamentOwnersEventOut._() : super();
  factory TournamentOwnersEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TournamentOwnersEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TournamentOwnersEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<User>(1, _omitFieldNames ? '' : 'owners', $pb.PbFieldType.PM, subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TournamentOwnersEventOut clone() => TournamentOwnersEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TournamentOwnersEventOut copyWith(void Function(TournamentOwnersEventOut) updates) =>
      super.copyWith((message) => updates(message as TournamentOwnersEventOut)) as TournamentOwnersEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TournamentOwnersEventOut create() => TournamentOwnersEventOut._();
  TournamentOwnersEventOut createEmptyInstance() => create();
  static $pb.PbList<TournamentOwnersEventOut> createRepeated() => $pb.PbList<TournamentOwnersEventOut>();
  @$core.pragma('dart2js:noInline')
  static TournamentOwnersEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TournamentOwnersEventOut>(create);
  static TournamentOwnersEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<User> get owners => $_getList(0);
}

class ClubOwnersEventOut extends $pb.GeneratedMessage {
  factory ClubOwnersEventOut({
    $core.Iterable<User>? owners,
  }) {
    final $result = create();
    if (owners != null) {
      $result.owners.addAll(owners);
    }
    return $result;
  }
  ClubOwnersEventOut._() : super();
  factory ClubOwnersEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ClubOwnersEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClubOwnersEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<User>(1, _omitFieldNames ? '' : 'owners', $pb.PbFieldType.PM, subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ClubOwnersEventOut clone() => ClubOwnersEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ClubOwnersEventOut copyWith(void Function(ClubOwnersEventOut) updates) =>
      super.copyWith((message) => updates(message as ClubOwnersEventOut)) as ClubOwnersEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClubOwnersEventOut create() => ClubOwnersEventOut._();
  ClubOwnersEventOut createEmptyInstance() => create();
  static $pb.PbList<ClubOwnersEventOut> createRepeated() => $pb.PbList<ClubOwnersEventOut>();
  @$core.pragma('dart2js:noInline')
  static ClubOwnersEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClubOwnersEventOut>(create);
  static ClubOwnersEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<User> get owners => $_getList(0);
}

class UpdateOwnerEvent extends $pb.GeneratedMessage {
  factory UpdateOwnerEvent({
    $core.String? email,
  }) {
    final $result = create();
    if (email != null) {
      $result.email = email;
    }
    return $result;
  }
  UpdateOwnerEvent._() : super();
  factory UpdateOwnerEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateOwnerEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateOwnerEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateOwnerEvent clone() => UpdateOwnerEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateOwnerEvent copyWith(void Function(UpdateOwnerEvent) updates) =>
      super.copyWith((message) => updates(message as UpdateOwnerEvent)) as UpdateOwnerEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateOwnerEvent create() => UpdateOwnerEvent._();
  UpdateOwnerEvent createEmptyInstance() => create();
  static $pb.PbList<UpdateOwnerEvent> createRepeated() => $pb.PbList<UpdateOwnerEvent>();
  @$core.pragma('dart2js:noInline')
  static UpdateOwnerEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateOwnerEvent>(create);
  static UpdateOwnerEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);
}

class DesignItem extends $pb.GeneratedMessage {
  factory DesignItem({
    $core.String? designKey,
    $core.String? title,
    $core.String? preview,
  }) {
    final $result = create();
    if (designKey != null) {
      $result.designKey = designKey;
    }
    if (title != null) {
      $result.title = title;
    }
    if (preview != null) {
      $result.preview = preview;
    }
    return $result;
  }
  DesignItem._() : super();
  factory DesignItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DesignItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DesignItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'designKey', protoName: 'designKey')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'preview')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DesignItem clone() => DesignItem()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DesignItem copyWith(void Function(DesignItem) updates) =>
      super.copyWith((message) => updates(message as DesignItem)) as DesignItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DesignItem create() => DesignItem._();
  DesignItem createEmptyInstance() => create();
  static $pb.PbList<DesignItem> createRepeated() => $pb.PbList<DesignItem>();
  @$core.pragma('dart2js:noInline')
  static DesignItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DesignItem>(create);
  static DesignItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get designKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set designKey($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDesignKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearDesignKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get preview => $_getSZ(2);
  @$pb.TagNumber(3)
  set preview($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPreview() => $_has(2);
  @$pb.TagNumber(3)
  void clearPreview() => $_clearField(3);
}

class TranslationKeyEventOut extends $pb.GeneratedMessage {
  factory TranslationKeyEventOut({
    $core.String? key,
    $core.Iterable<DesignItem>? designs,
  }) {
    final $result = create();
    if (key != null) {
      $result.key = key;
    }
    if (designs != null) {
      $result.designs.addAll(designs);
    }
    return $result;
  }
  TranslationKeyEventOut._() : super();
  factory TranslationKeyEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TranslationKeyEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TranslationKeyEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..pc<DesignItem>(2, _omitFieldNames ? '' : 'designs', $pb.PbFieldType.PM, subBuilder: DesignItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TranslationKeyEventOut clone() => TranslationKeyEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TranslationKeyEventOut copyWith(void Function(TranslationKeyEventOut) updates) =>
      super.copyWith((message) => updates(message as TranslationKeyEventOut)) as TranslationKeyEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TranslationKeyEventOut create() => TranslationKeyEventOut._();
  TranslationKeyEventOut createEmptyInstance() => create();
  static $pb.PbList<TranslationKeyEventOut> createRepeated() => $pb.PbList<TranslationKeyEventOut>();
  @$core.pragma('dart2js:noInline')
  static TranslationKeyEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TranslationKeyEventOut>(create);
  static TranslationKeyEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<DesignItem> get designs => $_getList(1);
}

class TableInfoItem extends $pb.GeneratedMessage {
  factory TableInfoItem({
    $core.int? table,
    $core.String? info,
  }) {
    final $result = create();
    if (table != null) {
      $result.table = table;
    }
    if (info != null) {
      $result.info = info;
    }
    return $result;
  }
  TableInfoItem._() : super();
  factory TableInfoItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TableInfoItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TableInfoItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'table', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'info')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TableInfoItem clone() => TableInfoItem()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TableInfoItem copyWith(void Function(TableInfoItem) updates) =>
      super.copyWith((message) => updates(message as TableInfoItem)) as TableInfoItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TableInfoItem create() => TableInfoItem._();
  TableInfoItem createEmptyInstance() => create();
  static $pb.PbList<TableInfoItem> createRepeated() => $pb.PbList<TableInfoItem>();
  @$core.pragma('dart2js:noInline')
  static TableInfoItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TableInfoItem>(create);
  static TableInfoItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get table => $_getIZ(0);
  @$pb.TagNumber(1)
  set table($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTable() => $_has(0);
  @$pb.TagNumber(1)
  void clearTable() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get info => $_getSZ(1);
  @$pb.TagNumber(2)
  set info($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearInfo() => $_clearField(2);
}

class TableInfoEvent extends $pb.GeneratedMessage {
  factory TableInfoEvent({
    $core.Iterable<TableInfoItem>? items,
  }) {
    final $result = create();
    if (items != null) {
      $result.items.addAll(items);
    }
    return $result;
  }
  TableInfoEvent._() : super();
  factory TableInfoEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TableInfoEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TableInfoEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<TableInfoItem>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: TableInfoItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TableInfoEvent clone() => TableInfoEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TableInfoEvent copyWith(void Function(TableInfoEvent) updates) =>
      super.copyWith((message) => updates(message as TableInfoEvent)) as TableInfoEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TableInfoEvent create() => TableInfoEvent._();
  TableInfoEvent createEmptyInstance() => create();
  static $pb.PbList<TableInfoEvent> createRepeated() => $pb.PbList<TableInfoEvent>();
  @$core.pragma('dart2js:noInline')
  static TableInfoEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TableInfoEvent>(create);
  static TableInfoEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TableInfoItem> get items => $_getList(0);
}

class FantasyParticipantsEventOut extends $pb.GeneratedMessage {
  factory FantasyParticipantsEventOut({
    $core.Iterable<User>? participants,
  }) {
    final $result = create();
    if (participants != null) {
      $result.participants.addAll(participants);
    }
    return $result;
  }
  FantasyParticipantsEventOut._() : super();
  factory FantasyParticipantsEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FantasyParticipantsEventOut.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FantasyParticipantsEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<User>(1, _omitFieldNames ? '' : 'participants', $pb.PbFieldType.PM, subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FantasyParticipantsEventOut clone() => FantasyParticipantsEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FantasyParticipantsEventOut copyWith(void Function(FantasyParticipantsEventOut) updates) =>
      super.copyWith((message) => updates(message as FantasyParticipantsEventOut)) as FantasyParticipantsEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FantasyParticipantsEventOut create() => FantasyParticipantsEventOut._();
  FantasyParticipantsEventOut createEmptyInstance() => create();
  static $pb.PbList<FantasyParticipantsEventOut> createRepeated() => $pb.PbList<FantasyParticipantsEventOut>();
  @$core.pragma('dart2js:noInline')
  static FantasyParticipantsEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FantasyParticipantsEventOut>(create);
  static FantasyParticipantsEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<User> get participants => $_getList(0);
}

class SetFantasyParticipantEvent extends $pb.GeneratedMessage {
  factory SetFantasyParticipantEvent({
    $core.String? email,
  }) {
    final $result = create();
    if (email != null) {
      $result.email = email;
    }
    return $result;
  }
  SetFantasyParticipantEvent._() : super();
  factory SetFantasyParticipantEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SetFantasyParticipantEvent.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetFantasyParticipantEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SetFantasyParticipantEvent clone() => SetFantasyParticipantEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SetFantasyParticipantEvent copyWith(void Function(SetFantasyParticipantEvent) updates) =>
      super.copyWith((message) => updates(message as SetFantasyParticipantEvent)) as SetFantasyParticipantEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetFantasyParticipantEvent create() => SetFantasyParticipantEvent._();
  SetFantasyParticipantEvent createEmptyInstance() => create();
  static $pb.PbList<SetFantasyParticipantEvent> createRepeated() => $pb.PbList<SetFantasyParticipantEvent>();
  @$core.pragma('dart2js:noInline')
  static SetFantasyParticipantEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetFantasyParticipantEvent>(create);
  static SetFantasyParticipantEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);
}

class FantasyRatingRow extends $pb.GeneratedMessage {
  factory FantasyRatingRow({
    $core.String? nickname,
    $core.Iterable<FantasyPredictionItem>? predictions,
    $core.int? totalPoints,
    $core.int? playerId,
  }) {
    final $result = create();
    if (nickname != null) {
      $result.nickname = nickname;
    }
    if (predictions != null) {
      $result.predictions.addAll(predictions);
    }
    if (totalPoints != null) {
      $result.totalPoints = totalPoints;
    }
    if (playerId != null) {
      $result.playerId = playerId;
    }
    return $result;
  }
  FantasyRatingRow._() : super();
  factory FantasyRatingRow.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FantasyRatingRow.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FantasyRatingRow',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nickname')
    ..pc<FantasyPredictionItem>(2, _omitFieldNames ? '' : 'predictions', $pb.PbFieldType.PM,
        subBuilder: FantasyPredictionItem.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalPoints', $pb.PbFieldType.O3, protoName: 'totalPoints')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'playerId', $pb.PbFieldType.O3, protoName: 'playerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FantasyRatingRow clone() => FantasyRatingRow()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FantasyRatingRow copyWith(void Function(FantasyRatingRow) updates) =>
      super.copyWith((message) => updates(message as FantasyRatingRow)) as FantasyRatingRow;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FantasyRatingRow create() => FantasyRatingRow._();
  FantasyRatingRow createEmptyInstance() => create();
  static $pb.PbList<FantasyRatingRow> createRepeated() => $pb.PbList<FantasyRatingRow>();
  @$core.pragma('dart2js:noInline')
  static FantasyRatingRow getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FantasyRatingRow>(create);
  static FantasyRatingRow? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get nickname => $_getSZ(0);
  @$pb.TagNumber(1)
  set nickname($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNickname() => $_has(0);
  @$pb.TagNumber(1)
  void clearNickname() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<FantasyPredictionItem> get predictions => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get totalPoints => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalPoints($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTotalPoints() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPoints() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get playerId => $_getIZ(3);
  @$pb.TagNumber(4)
  set playerId($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPlayerId() => $_has(3);
  @$pb.TagNumber(4)
  void clearPlayerId() => $_clearField(4);
}

class FantasyPredictionItem extends $pb.GeneratedMessage {
  factory FantasyPredictionItem({
    $core.int? gameNumber,
    GameWin? prediction,
    GameWin? actualResult,
    $core.int? points,
  }) {
    final $result = create();
    if (gameNumber != null) {
      $result.gameNumber = gameNumber;
    }
    if (prediction != null) {
      $result.prediction = prediction;
    }
    if (actualResult != null) {
      $result.actualResult = actualResult;
    }
    if (points != null) {
      $result.points = points;
    }
    return $result;
  }
  FantasyPredictionItem._() : super();
  factory FantasyPredictionItem.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FantasyPredictionItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FantasyPredictionItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'gameNumber', $pb.PbFieldType.O3, protoName: 'gameNumber')
    ..e<GameWin>(2, _omitFieldNames ? '' : 'prediction', $pb.PbFieldType.OE,
        defaultOrMaker: GameWin.city, valueOf: GameWin.valueOf, enumValues: GameWin.values)
    ..e<GameWin>(3, _omitFieldNames ? '' : 'actualResult', $pb.PbFieldType.OE,
        protoName: 'actualResult', defaultOrMaker: GameWin.city, valueOf: GameWin.valueOf, enumValues: GameWin.values)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'points', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FantasyPredictionItem clone() => FantasyPredictionItem()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FantasyPredictionItem copyWith(void Function(FantasyPredictionItem) updates) =>
      super.copyWith((message) => updates(message as FantasyPredictionItem)) as FantasyPredictionItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FantasyPredictionItem create() => FantasyPredictionItem._();
  FantasyPredictionItem createEmptyInstance() => create();
  static $pb.PbList<FantasyPredictionItem> createRepeated() => $pb.PbList<FantasyPredictionItem>();
  @$core.pragma('dart2js:noInline')
  static FantasyPredictionItem getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FantasyPredictionItem>(create);
  static FantasyPredictionItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get gameNumber => $_getIZ(0);
  @$pb.TagNumber(1)
  set gameNumber($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasGameNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  GameWin get prediction => $_getN(1);
  @$pb.TagNumber(2)
  set prediction(GameWin v) {
    $_setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPrediction() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrediction() => $_clearField(2);

  @$pb.TagNumber(3)
  GameWin get actualResult => $_getN(2);
  @$pb.TagNumber(3)
  set actualResult(GameWin v) {
    $_setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasActualResult() => $_has(2);
  @$pb.TagNumber(3)
  void clearActualResult() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get points => $_getIZ(3);
  @$pb.TagNumber(4)
  set points($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPoints() => $_has(3);
  @$pb.TagNumber(4)
  void clearPoints() => $_clearField(4);
}

class FantasyRatingEventOut extends $pb.GeneratedMessage {
  factory FantasyRatingEventOut({
    $core.Iterable<FantasyRatingRow>? rows,
  }) {
    final $result = create();
    if (rows != null) {
      $result.rows.addAll(rows);
    }
    return $result;
  }
  FantasyRatingEventOut._() : super();
  factory FantasyRatingEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FantasyRatingEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FantasyRatingEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<FantasyRatingRow>(1, _omitFieldNames ? '' : 'rows', $pb.PbFieldType.PM, subBuilder: FantasyRatingRow.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FantasyRatingEventOut clone() => FantasyRatingEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FantasyRatingEventOut copyWith(void Function(FantasyRatingEventOut) updates) =>
      super.copyWith((message) => updates(message as FantasyRatingEventOut)) as FantasyRatingEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FantasyRatingEventOut create() => FantasyRatingEventOut._();
  FantasyRatingEventOut createEmptyInstance() => create();
  static $pb.PbList<FantasyRatingEventOut> createRepeated() => $pb.PbList<FantasyRatingEventOut>();
  @$core.pragma('dart2js:noInline')
  static FantasyRatingEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FantasyRatingEventOut>(create);
  static FantasyRatingEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FantasyRatingRow> get rows => $_getList(0);
}

class AuthEvent extends $pb.GeneratedMessage {
  factory AuthEvent({
    $core.String? deviceId,
    $core.String? pushToken,
  }) {
    final $result = create();
    if (deviceId != null) {
      $result.deviceId = deviceId;
    }
    if (pushToken != null) {
      $result.pushToken = pushToken;
    }
    return $result;
  }
  AuthEvent._() : super();
  factory AuthEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AuthEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AuthEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceId', protoName: 'deviceId')
    ..aOS(2, _omitFieldNames ? '' : 'pushToken', protoName: 'pushToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AuthEvent clone() => AuthEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AuthEvent copyWith(void Function(AuthEvent) updates) =>
      super.copyWith((message) => updates(message as AuthEvent)) as AuthEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthEvent create() => AuthEvent._();
  AuthEvent createEmptyInstance() => create();
  static $pb.PbList<AuthEvent> createRepeated() => $pb.PbList<AuthEvent>();
  @$core.pragma('dart2js:noInline')
  static AuthEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuthEvent>(create);
  static AuthEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get pushToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pushToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPushToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPushToken() => $_clearField(2);
}

class AuthEventOut extends $pb.GeneratedMessage {
  factory AuthEventOut({
    $core.int? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  AuthEventOut._() : super();
  factory AuthEventOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AuthEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AuthEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.O3, protoName: 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AuthEventOut clone() => AuthEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AuthEventOut copyWith(void Function(AuthEventOut) updates) =>
      super.copyWith((message) => updates(message as AuthEventOut)) as AuthEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthEventOut create() => AuthEventOut._();
  AuthEventOut createEmptyInstance() => create();
  static $pb.PbList<AuthEventOut> createRepeated() => $pb.PbList<AuthEventOut>();
  @$core.pragma('dart2js:noInline')
  static AuthEventOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuthEventOut>(create);
  static AuthEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get userId => $_getIZ(0);
  @$pb.TagNumber(1)
  set userId($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class SetFantasyPredictionEvent extends $pb.GeneratedMessage {
  factory SetFantasyPredictionEvent({
    GameWin? prediction,
  }) {
    final $result = create();
    if (prediction != null) {
      $result.prediction = prediction;
    }
    return $result;
  }
  SetFantasyPredictionEvent._() : super();
  factory SetFantasyPredictionEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SetFantasyPredictionEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetFantasyPredictionEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..e<GameWin>(1, _omitFieldNames ? '' : 'prediction', $pb.PbFieldType.OE,
        defaultOrMaker: GameWin.city, valueOf: GameWin.valueOf, enumValues: GameWin.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SetFantasyPredictionEvent clone() => SetFantasyPredictionEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SetFantasyPredictionEvent copyWith(void Function(SetFantasyPredictionEvent) updates) =>
      super.copyWith((message) => updates(message as SetFantasyPredictionEvent)) as SetFantasyPredictionEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetFantasyPredictionEvent create() => SetFantasyPredictionEvent._();
  SetFantasyPredictionEvent createEmptyInstance() => create();
  static $pb.PbList<SetFantasyPredictionEvent> createRepeated() => $pb.PbList<SetFantasyPredictionEvent>();
  @$core.pragma('dart2js:noInline')
  static SetFantasyPredictionEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetFantasyPredictionEvent>(create);
  static SetFantasyPredictionEvent? _defaultInstance;

  @$pb.TagNumber(1)
  GameWin get prediction => $_getN(0);
  @$pb.TagNumber(1)
  set prediction(GameWin v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPrediction() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrediction() => $_clearField(1);
}

class FantasyCurrentGameEventOut extends $pb.GeneratedMessage {
  factory FantasyCurrentGameEventOut({
    $core.int? gameNumber,
    $core.bool? canPredict,
    $core.bool? canParticipate,
  }) {
    final $result = create();
    if (gameNumber != null) {
      $result.gameNumber = gameNumber;
    }
    if (canPredict != null) {
      $result.canPredict = canPredict;
    }
    if (canParticipate != null) {
      $result.canParticipate = canParticipate;
    }
    return $result;
  }
  FantasyCurrentGameEventOut._() : super();
  factory FantasyCurrentGameEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FantasyCurrentGameEventOut.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FantasyCurrentGameEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'gameNumber', $pb.PbFieldType.O3, protoName: 'gameNumber')
    ..aOB(2, _omitFieldNames ? '' : 'canPredict', protoName: 'canPredict')
    ..aOB(3, _omitFieldNames ? '' : 'canParticipate', protoName: 'canParticipate')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FantasyCurrentGameEventOut clone() => FantasyCurrentGameEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FantasyCurrentGameEventOut copyWith(void Function(FantasyCurrentGameEventOut) updates) =>
      super.copyWith((message) => updates(message as FantasyCurrentGameEventOut)) as FantasyCurrentGameEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FantasyCurrentGameEventOut create() => FantasyCurrentGameEventOut._();
  FantasyCurrentGameEventOut createEmptyInstance() => create();
  static $pb.PbList<FantasyCurrentGameEventOut> createRepeated() => $pb.PbList<FantasyCurrentGameEventOut>();
  @$core.pragma('dart2js:noInline')
  static FantasyCurrentGameEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FantasyCurrentGameEventOut>(create);
  static FantasyCurrentGameEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get gameNumber => $_getIZ(0);
  @$pb.TagNumber(1)
  set gameNumber($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasGameNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get canPredict => $_getBF(1);
  @$pb.TagNumber(2)
  set canPredict($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCanPredict() => $_has(1);
  @$pb.TagNumber(2)
  void clearCanPredict() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get canParticipate => $_getBF(2);
  @$pb.TagNumber(3)
  set canParticipate($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCanParticipate() => $_has(2);
  @$pb.TagNumber(3)
  void clearCanParticipate() => $_clearField(3);
}

class ForgotPasswordEvent extends $pb.GeneratedMessage {
  factory ForgotPasswordEvent({
    $core.String? email,
  }) {
    final $result = create();
    if (email != null) {
      $result.email = email;
    }
    return $result;
  }
  ForgotPasswordEvent._() : super();
  factory ForgotPasswordEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ForgotPasswordEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ForgotPasswordEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ForgotPasswordEvent clone() => ForgotPasswordEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ForgotPasswordEvent copyWith(void Function(ForgotPasswordEvent) updates) =>
      super.copyWith((message) => updates(message as ForgotPasswordEvent)) as ForgotPasswordEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForgotPasswordEvent create() => ForgotPasswordEvent._();
  ForgotPasswordEvent createEmptyInstance() => create();
  static $pb.PbList<ForgotPasswordEvent> createRepeated() => $pb.PbList<ForgotPasswordEvent>();
  @$core.pragma('dart2js:noInline')
  static ForgotPasswordEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForgotPasswordEvent>(create);
  static ForgotPasswordEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);
}

class ForgotPasswordEventOut extends $pb.GeneratedMessage {
  factory ForgotPasswordEventOut({
    ForgotPasswordEventOut_Error? error,
  }) {
    final $result = create();
    if (error != null) {
      $result.error = error;
    }
    return $result;
  }
  ForgotPasswordEventOut._() : super();
  factory ForgotPasswordEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ForgotPasswordEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ForgotPasswordEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..e<ForgotPasswordEventOut_Error>(1, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE,
        defaultOrMaker: ForgotPasswordEventOut_Error.noError,
        valueOf: ForgotPasswordEventOut_Error.valueOf,
        enumValues: ForgotPasswordEventOut_Error.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ForgotPasswordEventOut clone() => ForgotPasswordEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ForgotPasswordEventOut copyWith(void Function(ForgotPasswordEventOut) updates) =>
      super.copyWith((message) => updates(message as ForgotPasswordEventOut)) as ForgotPasswordEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForgotPasswordEventOut create() => ForgotPasswordEventOut._();
  ForgotPasswordEventOut createEmptyInstance() => create();
  static $pb.PbList<ForgotPasswordEventOut> createRepeated() => $pb.PbList<ForgotPasswordEventOut>();
  @$core.pragma('dart2js:noInline')
  static ForgotPasswordEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForgotPasswordEventOut>(create);
  static ForgotPasswordEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  ForgotPasswordEventOut_Error get error => $_getN(0);
  @$pb.TagNumber(1)
  set error(ForgotPasswordEventOut_Error v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => $_clearField(1);
}

class ResetPasswordEvent extends $pb.GeneratedMessage {
  factory ResetPasswordEvent({
    $core.String? token,
    $core.String? newPassword,
    $core.String? email,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (newPassword != null) {
      $result.newPassword = newPassword;
    }
    if (email != null) {
      $result.email = email;
    }
    return $result;
  }
  ResetPasswordEvent._() : super();
  factory ResetPasswordEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ResetPasswordEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResetPasswordEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'newPassword', protoName: 'newPassword')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ResetPasswordEvent clone() => ResetPasswordEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ResetPasswordEvent copyWith(void Function(ResetPasswordEvent) updates) =>
      super.copyWith((message) => updates(message as ResetPasswordEvent)) as ResetPasswordEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResetPasswordEvent create() => ResetPasswordEvent._();
  ResetPasswordEvent createEmptyInstance() => create();
  static $pb.PbList<ResetPasswordEvent> createRepeated() => $pb.PbList<ResetPasswordEvent>();
  @$core.pragma('dart2js:noInline')
  static ResetPasswordEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResetPasswordEvent>(create);
  static ResetPasswordEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get newPassword => $_getSZ(1);
  @$pb.TagNumber(2)
  set newPassword($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNewPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewPassword() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);
}

class ResetPasswordEventOut extends $pb.GeneratedMessage {
  factory ResetPasswordEventOut({
    ResetPasswordEventOut_Error? error,
  }) {
    final $result = create();
    if (error != null) {
      $result.error = error;
    }
    return $result;
  }
  ResetPasswordEventOut._() : super();
  factory ResetPasswordEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ResetPasswordEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResetPasswordEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..e<ResetPasswordEventOut_Error>(1, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE,
        defaultOrMaker: ResetPasswordEventOut_Error.noError,
        valueOf: ResetPasswordEventOut_Error.valueOf,
        enumValues: ResetPasswordEventOut_Error.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ResetPasswordEventOut clone() => ResetPasswordEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ResetPasswordEventOut copyWith(void Function(ResetPasswordEventOut) updates) =>
      super.copyWith((message) => updates(message as ResetPasswordEventOut)) as ResetPasswordEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResetPasswordEventOut create() => ResetPasswordEventOut._();
  ResetPasswordEventOut createEmptyInstance() => create();
  static $pb.PbList<ResetPasswordEventOut> createRepeated() => $pb.PbList<ResetPasswordEventOut>();
  @$core.pragma('dart2js:noInline')
  static ResetPasswordEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResetPasswordEventOut>(create);
  static ResetPasswordEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  ResetPasswordEventOut_Error get error => $_getN(0);
  @$pb.TagNumber(1)
  set error(ResetPasswordEventOut_Error v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => $_clearField(1);
}

class PlayerRoleStats extends $pb.GeneratedMessage {
  factory PlayerRoleStats({
    $core.int? games,
    $core.int? wins,
    $core.double? winRate,
    $core.double? avgBonusScore,
  }) {
    final $result = create();
    if (games != null) {
      $result.games = games;
    }
    if (wins != null) {
      $result.wins = wins;
    }
    if (winRate != null) {
      $result.winRate = winRate;
    }
    if (avgBonusScore != null) {
      $result.avgBonusScore = avgBonusScore;
    }
    return $result;
  }
  PlayerRoleStats._() : super();
  factory PlayerRoleStats.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PlayerRoleStats.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlayerRoleStats',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'games', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'wins', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'winRate', $pb.PbFieldType.OD, protoName: 'winRate')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'avgBonusScore', $pb.PbFieldType.OD, protoName: 'avgBonusScore')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PlayerRoleStats clone() => PlayerRoleStats()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PlayerRoleStats copyWith(void Function(PlayerRoleStats) updates) =>
      super.copyWith((message) => updates(message as PlayerRoleStats)) as PlayerRoleStats;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerRoleStats create() => PlayerRoleStats._();
  PlayerRoleStats createEmptyInstance() => create();
  static $pb.PbList<PlayerRoleStats> createRepeated() => $pb.PbList<PlayerRoleStats>();
  @$core.pragma('dart2js:noInline')
  static PlayerRoleStats getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerRoleStats>(create);
  static PlayerRoleStats? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get games => $_getIZ(0);
  @$pb.TagNumber(1)
  set games($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasGames() => $_has(0);
  @$pb.TagNumber(1)
  void clearGames() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get wins => $_getIZ(1);
  @$pb.TagNumber(2)
  set wins($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasWins() => $_has(1);
  @$pb.TagNumber(2)
  void clearWins() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get winRate => $_getN(2);
  @$pb.TagNumber(3)
  set winRate($core.double v) {
    $_setDouble(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasWinRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearWinRate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get avgBonusScore => $_getN(3);
  @$pb.TagNumber(4)
  set avgBonusScore($core.double v) {
    $_setDouble(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasAvgBonusScore() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvgBonusScore() => $_clearField(4);
}

class PlayerPairStat extends $pb.GeneratedMessage {
  factory PlayerPairStat({
    $core.int? playerId,
    $core.String? nickname,
    $core.int? games,
    $core.int? wins,
    $core.double? winRate,
  }) {
    final $result = create();
    if (playerId != null) {
      $result.playerId = playerId;
    }
    if (nickname != null) {
      $result.nickname = nickname;
    }
    if (games != null) {
      $result.games = games;
    }
    if (wins != null) {
      $result.wins = wins;
    }
    if (winRate != null) {
      $result.winRate = winRate;
    }
    return $result;
  }
  PlayerPairStat._() : super();
  factory PlayerPairStat.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PlayerPairStat.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlayerPairStat',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'playerId', $pb.PbFieldType.O3, protoName: 'playerId')
    ..aOS(2, _omitFieldNames ? '' : 'nickname')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'games', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'wins', $pb.PbFieldType.O3)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'winRate', $pb.PbFieldType.OD, protoName: 'winRate')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PlayerPairStat clone() => PlayerPairStat()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PlayerPairStat copyWith(void Function(PlayerPairStat) updates) =>
      super.copyWith((message) => updates(message as PlayerPairStat)) as PlayerPairStat;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerPairStat create() => PlayerPairStat._();
  PlayerPairStat createEmptyInstance() => create();
  static $pb.PbList<PlayerPairStat> createRepeated() => $pb.PbList<PlayerPairStat>();
  @$core.pragma('dart2js:noInline')
  static PlayerPairStat getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerPairStat>(create);
  static PlayerPairStat? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get playerId => $_getIZ(0);
  @$pb.TagNumber(1)
  set playerId($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPlayerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayerId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get nickname => $_getSZ(1);
  @$pb.TagNumber(2)
  set nickname($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNickname() => $_has(1);
  @$pb.TagNumber(2)
  void clearNickname() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get games => $_getIZ(2);
  @$pb.TagNumber(3)
  set games($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasGames() => $_has(2);
  @$pb.TagNumber(3)
  void clearGames() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get wins => $_getIZ(3);
  @$pb.TagNumber(4)
  set wins($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasWins() => $_has(3);
  @$pb.TagNumber(4)
  void clearWins() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get winRate => $_getN(4);
  @$pb.TagNumber(5)
  set winRate($core.double v) {
    $_setDouble(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasWinRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearWinRate() => $_clearField(5);
}

class PlayerStatisticsEventOut extends $pb.GeneratedMessage {
  factory PlayerStatisticsEventOut({
    $core.int? playerId,
    $core.String? nickname,
    PlayerRoleStats? overall,
    PlayerRoleStats? citizen,
    PlayerRoleStats? mafia,
    PlayerRoleStats? don,
    PlayerRoleStats? sheriff,
    $core.Iterable<PlayerPairStat>? sameCityTop,
    $core.Iterable<PlayerPairStat>? sameMafiaTop,
    $core.Iterable<PlayerPairStat>? diffTeamTop,
    $core.Iterable<PlayerPairStat>? sameCityBottom,
    $core.Iterable<PlayerPairStat>? sameMafiaBottom,
    $core.Iterable<PlayerPairStat>? diffTeamBottom,
  }) {
    final $result = create();
    if (playerId != null) {
      $result.playerId = playerId;
    }
    if (nickname != null) {
      $result.nickname = nickname;
    }
    if (overall != null) {
      $result.overall = overall;
    }
    if (citizen != null) {
      $result.citizen = citizen;
    }
    if (mafia != null) {
      $result.mafia = mafia;
    }
    if (don != null) {
      $result.don = don;
    }
    if (sheriff != null) {
      $result.sheriff = sheriff;
    }
    if (sameCityTop != null) {
      $result.sameCityTop.addAll(sameCityTop);
    }
    if (sameMafiaTop != null) {
      $result.sameMafiaTop.addAll(sameMafiaTop);
    }
    if (diffTeamTop != null) {
      $result.diffTeamTop.addAll(diffTeamTop);
    }
    if (sameCityBottom != null) {
      $result.sameCityBottom.addAll(sameCityBottom);
    }
    if (sameMafiaBottom != null) {
      $result.sameMafiaBottom.addAll(sameMafiaBottom);
    }
    if (diffTeamBottom != null) {
      $result.diffTeamBottom.addAll(diffTeamBottom);
    }
    return $result;
  }
  PlayerStatisticsEventOut._() : super();
  factory PlayerStatisticsEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PlayerStatisticsEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlayerStatisticsEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'playerId', $pb.PbFieldType.O3, protoName: 'playerId')
    ..aOS(2, _omitFieldNames ? '' : 'nickname')
    ..aOM<PlayerRoleStats>(3, _omitFieldNames ? '' : 'overall', subBuilder: PlayerRoleStats.create)
    ..aOM<PlayerRoleStats>(4, _omitFieldNames ? '' : 'citizen', subBuilder: PlayerRoleStats.create)
    ..aOM<PlayerRoleStats>(5, _omitFieldNames ? '' : 'mafia', subBuilder: PlayerRoleStats.create)
    ..aOM<PlayerRoleStats>(6, _omitFieldNames ? '' : 'don', subBuilder: PlayerRoleStats.create)
    ..aOM<PlayerRoleStats>(7, _omitFieldNames ? '' : 'sheriff', subBuilder: PlayerRoleStats.create)
    ..pc<PlayerPairStat>(8, _omitFieldNames ? '' : 'sameCityTop', $pb.PbFieldType.PM,
        protoName: 'sameCityTop', subBuilder: PlayerPairStat.create)
    ..pc<PlayerPairStat>(9, _omitFieldNames ? '' : 'sameMafiaTop', $pb.PbFieldType.PM,
        protoName: 'sameMafiaTop', subBuilder: PlayerPairStat.create)
    ..pc<PlayerPairStat>(10, _omitFieldNames ? '' : 'diffTeamTop', $pb.PbFieldType.PM,
        protoName: 'diffTeamTop', subBuilder: PlayerPairStat.create)
    ..pc<PlayerPairStat>(11, _omitFieldNames ? '' : 'sameCityBottom', $pb.PbFieldType.PM,
        protoName: 'sameCityBottom', subBuilder: PlayerPairStat.create)
    ..pc<PlayerPairStat>(12, _omitFieldNames ? '' : 'sameMafiaBottom', $pb.PbFieldType.PM,
        protoName: 'sameMafiaBottom', subBuilder: PlayerPairStat.create)
    ..pc<PlayerPairStat>(13, _omitFieldNames ? '' : 'diffTeamBottom', $pb.PbFieldType.PM,
        protoName: 'diffTeamBottom', subBuilder: PlayerPairStat.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PlayerStatisticsEventOut clone() => PlayerStatisticsEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PlayerStatisticsEventOut copyWith(void Function(PlayerStatisticsEventOut) updates) =>
      super.copyWith((message) => updates(message as PlayerStatisticsEventOut)) as PlayerStatisticsEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerStatisticsEventOut create() => PlayerStatisticsEventOut._();
  PlayerStatisticsEventOut createEmptyInstance() => create();
  static $pb.PbList<PlayerStatisticsEventOut> createRepeated() => $pb.PbList<PlayerStatisticsEventOut>();
  @$core.pragma('dart2js:noInline')
  static PlayerStatisticsEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerStatisticsEventOut>(create);
  static PlayerStatisticsEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get playerId => $_getIZ(0);
  @$pb.TagNumber(1)
  set playerId($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPlayerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayerId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get nickname => $_getSZ(1);
  @$pb.TagNumber(2)
  set nickname($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNickname() => $_has(1);
  @$pb.TagNumber(2)
  void clearNickname() => $_clearField(2);

  @$pb.TagNumber(3)
  PlayerRoleStats get overall => $_getN(2);
  @$pb.TagNumber(3)
  set overall(PlayerRoleStats v) {
    $_setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOverall() => $_has(2);
  @$pb.TagNumber(3)
  void clearOverall() => $_clearField(3);
  @$pb.TagNumber(3)
  PlayerRoleStats ensureOverall() => $_ensure(2);

  @$pb.TagNumber(4)
  PlayerRoleStats get citizen => $_getN(3);
  @$pb.TagNumber(4)
  set citizen(PlayerRoleStats v) {
    $_setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasCitizen() => $_has(3);
  @$pb.TagNumber(4)
  void clearCitizen() => $_clearField(4);
  @$pb.TagNumber(4)
  PlayerRoleStats ensureCitizen() => $_ensure(3);

  @$pb.TagNumber(5)
  PlayerRoleStats get mafia => $_getN(4);
  @$pb.TagNumber(5)
  set mafia(PlayerRoleStats v) {
    $_setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasMafia() => $_has(4);
  @$pb.TagNumber(5)
  void clearMafia() => $_clearField(5);
  @$pb.TagNumber(5)
  PlayerRoleStats ensureMafia() => $_ensure(4);

  @$pb.TagNumber(6)
  PlayerRoleStats get don => $_getN(5);
  @$pb.TagNumber(6)
  set don(PlayerRoleStats v) {
    $_setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDon() => $_has(5);
  @$pb.TagNumber(6)
  void clearDon() => $_clearField(6);
  @$pb.TagNumber(6)
  PlayerRoleStats ensureDon() => $_ensure(5);

  @$pb.TagNumber(7)
  PlayerRoleStats get sheriff => $_getN(6);
  @$pb.TagNumber(7)
  set sheriff(PlayerRoleStats v) {
    $_setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasSheriff() => $_has(6);
  @$pb.TagNumber(7)
  void clearSheriff() => $_clearField(7);
  @$pb.TagNumber(7)
  PlayerRoleStats ensureSheriff() => $_ensure(6);

  @$pb.TagNumber(8)
  $pb.PbList<PlayerPairStat> get sameCityTop => $_getList(7);

  @$pb.TagNumber(9)
  $pb.PbList<PlayerPairStat> get sameMafiaTop => $_getList(8);

  @$pb.TagNumber(10)
  $pb.PbList<PlayerPairStat> get diffTeamTop => $_getList(9);

  @$pb.TagNumber(11)
  $pb.PbList<PlayerPairStat> get sameCityBottom => $_getList(10);

  @$pb.TagNumber(12)
  $pb.PbList<PlayerPairStat> get sameMafiaBottom => $_getList(11);

  @$pb.TagNumber(13)
  $pb.PbList<PlayerPairStat> get diffTeamBottom => $_getList(12);
}

class PhotoTheme extends $pb.GeneratedMessage {
  factory PhotoTheme({
    $core.int? id,
    $core.String? name,
    $core.int? ownerId,
    $core.int? photosCount,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (ownerId != null) {
      $result.ownerId = ownerId;
    }
    if (photosCount != null) {
      $result.photosCount = photosCount;
    }
    return $result;
  }
  PhotoTheme._() : super();
  factory PhotoTheme.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PhotoTheme.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PhotoTheme',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'ownerId', $pb.PbFieldType.O3, protoName: 'ownerId')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'photosCount', $pb.PbFieldType.O3, protoName: 'photosCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PhotoTheme clone() => PhotoTheme()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PhotoTheme copyWith(void Function(PhotoTheme) updates) =>
      super.copyWith((message) => updates(message as PhotoTheme)) as PhotoTheme;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PhotoTheme create() => PhotoTheme._();
  PhotoTheme createEmptyInstance() => create();
  static $pb.PbList<PhotoTheme> createRepeated() => $pb.PbList<PhotoTheme>();
  @$core.pragma('dart2js:noInline')
  static PhotoTheme getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PhotoTheme>(create);
  static PhotoTheme? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get ownerId => $_getIZ(2);
  @$pb.TagNumber(3)
  set ownerId($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOwnerId() => $_has(2);
  @$pb.TagNumber(3)
  void clearOwnerId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get photosCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set photosCount($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPhotosCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhotosCount() => $_clearField(4);
}

class PhotoThemePlayer extends $pb.GeneratedMessage {
  factory PhotoThemePlayer({
    $core.int? playerId,
    $core.String? nickname,
    $core.String? themeImageUrl,
    $core.String? profileImageUrl,
  }) {
    final $result = create();
    if (playerId != null) {
      $result.playerId = playerId;
    }
    if (nickname != null) {
      $result.nickname = nickname;
    }
    if (themeImageUrl != null) {
      $result.themeImageUrl = themeImageUrl;
    }
    if (profileImageUrl != null) {
      $result.profileImageUrl = profileImageUrl;
    }
    return $result;
  }
  PhotoThemePlayer._() : super();
  factory PhotoThemePlayer.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PhotoThemePlayer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PhotoThemePlayer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'playerId', $pb.PbFieldType.O3, protoName: 'playerId')
    ..aOS(2, _omitFieldNames ? '' : 'nickname')
    ..aOS(3, _omitFieldNames ? '' : 'themeImageUrl', protoName: 'themeImageUrl')
    ..aOS(4, _omitFieldNames ? '' : 'profileImageUrl', protoName: 'profileImageUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PhotoThemePlayer clone() => PhotoThemePlayer()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PhotoThemePlayer copyWith(void Function(PhotoThemePlayer) updates) =>
      super.copyWith((message) => updates(message as PhotoThemePlayer)) as PhotoThemePlayer;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PhotoThemePlayer create() => PhotoThemePlayer._();
  PhotoThemePlayer createEmptyInstance() => create();
  static $pb.PbList<PhotoThemePlayer> createRepeated() => $pb.PbList<PhotoThemePlayer>();
  @$core.pragma('dart2js:noInline')
  static PhotoThemePlayer getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PhotoThemePlayer>(create);
  static PhotoThemePlayer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get playerId => $_getIZ(0);
  @$pb.TagNumber(1)
  set playerId($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPlayerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayerId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get nickname => $_getSZ(1);
  @$pb.TagNumber(2)
  set nickname($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNickname() => $_has(1);
  @$pb.TagNumber(2)
  void clearNickname() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get themeImageUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set themeImageUrl($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasThemeImageUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearThemeImageUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get profileImageUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set profileImageUrl($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasProfileImageUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearProfileImageUrl() => $_clearField(4);
}

class CreatePhotoThemeEvent extends $pb.GeneratedMessage {
  factory CreatePhotoThemeEvent({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  CreatePhotoThemeEvent._() : super();
  factory CreatePhotoThemeEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreatePhotoThemeEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreatePhotoThemeEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreatePhotoThemeEvent clone() => CreatePhotoThemeEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreatePhotoThemeEvent copyWith(void Function(CreatePhotoThemeEvent) updates) =>
      super.copyWith((message) => updates(message as CreatePhotoThemeEvent)) as CreatePhotoThemeEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePhotoThemeEvent create() => CreatePhotoThemeEvent._();
  CreatePhotoThemeEvent createEmptyInstance() => create();
  static $pb.PbList<CreatePhotoThemeEvent> createRepeated() => $pb.PbList<CreatePhotoThemeEvent>();
  @$core.pragma('dart2js:noInline')
  static CreatePhotoThemeEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePhotoThemeEvent>(create);
  static CreatePhotoThemeEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);
}

class CreatePhotoThemeEventOut extends $pb.GeneratedMessage {
  factory CreatePhotoThemeEventOut({
    $core.int? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  CreatePhotoThemeEventOut._() : super();
  factory CreatePhotoThemeEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreatePhotoThemeEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreatePhotoThemeEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreatePhotoThemeEventOut clone() => CreatePhotoThemeEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreatePhotoThemeEventOut copyWith(void Function(CreatePhotoThemeEventOut) updates) =>
      super.copyWith((message) => updates(message as CreatePhotoThemeEventOut)) as CreatePhotoThemeEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePhotoThemeEventOut create() => CreatePhotoThemeEventOut._();
  CreatePhotoThemeEventOut createEmptyInstance() => create();
  static $pb.PbList<CreatePhotoThemeEventOut> createRepeated() => $pb.PbList<CreatePhotoThemeEventOut>();
  @$core.pragma('dart2js:noInline')
  static CreatePhotoThemeEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePhotoThemeEventOut>(create);
  static CreatePhotoThemeEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class UpdatePhotoThemeEvent extends $pb.GeneratedMessage {
  factory UpdatePhotoThemeEvent({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  UpdatePhotoThemeEvent._() : super();
  factory UpdatePhotoThemeEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdatePhotoThemeEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdatePhotoThemeEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdatePhotoThemeEvent clone() => UpdatePhotoThemeEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdatePhotoThemeEvent copyWith(void Function(UpdatePhotoThemeEvent) updates) =>
      super.copyWith((message) => updates(message as UpdatePhotoThemeEvent)) as UpdatePhotoThemeEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePhotoThemeEvent create() => UpdatePhotoThemeEvent._();
  UpdatePhotoThemeEvent createEmptyInstance() => create();
  static $pb.PbList<UpdatePhotoThemeEvent> createRepeated() => $pb.PbList<UpdatePhotoThemeEvent>();
  @$core.pragma('dart2js:noInline')
  static UpdatePhotoThemeEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatePhotoThemeEvent>(create);
  static UpdatePhotoThemeEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);
}

class GetPhotoThemesEventOut extends $pb.GeneratedMessage {
  factory GetPhotoThemesEventOut({
    $core.Iterable<PhotoTheme>? themes,
  }) {
    final $result = create();
    if (themes != null) {
      $result.themes.addAll(themes);
    }
    return $result;
  }
  GetPhotoThemesEventOut._() : super();
  factory GetPhotoThemesEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetPhotoThemesEventOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPhotoThemesEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<PhotoTheme>(1, _omitFieldNames ? '' : 'themes', $pb.PbFieldType.PM, subBuilder: PhotoTheme.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetPhotoThemesEventOut clone() => GetPhotoThemesEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetPhotoThemesEventOut copyWith(void Function(GetPhotoThemesEventOut) updates) =>
      super.copyWith((message) => updates(message as GetPhotoThemesEventOut)) as GetPhotoThemesEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPhotoThemesEventOut create() => GetPhotoThemesEventOut._();
  GetPhotoThemesEventOut createEmptyInstance() => create();
  static $pb.PbList<GetPhotoThemesEventOut> createRepeated() => $pb.PbList<GetPhotoThemesEventOut>();
  @$core.pragma('dart2js:noInline')
  static GetPhotoThemesEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPhotoThemesEventOut>(create);
  static GetPhotoThemesEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PhotoTheme> get themes => $_getList(0);
}

class GetPhotoThemePlayersEventOut extends $pb.GeneratedMessage {
  factory GetPhotoThemePlayersEventOut({
    $core.Iterable<PhotoThemePlayer>? players,
  }) {
    final $result = create();
    if (players != null) {
      $result.players.addAll(players);
    }
    return $result;
  }
  GetPhotoThemePlayersEventOut._() : super();
  factory GetPhotoThemePlayersEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetPhotoThemePlayersEventOut.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPhotoThemePlayersEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..pc<PhotoThemePlayer>(1, _omitFieldNames ? '' : 'players', $pb.PbFieldType.PM, subBuilder: PhotoThemePlayer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetPhotoThemePlayersEventOut clone() => GetPhotoThemePlayersEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetPhotoThemePlayersEventOut copyWith(void Function(GetPhotoThemePlayersEventOut) updates) =>
      super.copyWith((message) => updates(message as GetPhotoThemePlayersEventOut)) as GetPhotoThemePlayersEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPhotoThemePlayersEventOut create() => GetPhotoThemePlayersEventOut._();
  GetPhotoThemePlayersEventOut createEmptyInstance() => create();
  static $pb.PbList<GetPhotoThemePlayersEventOut> createRepeated() => $pb.PbList<GetPhotoThemePlayersEventOut>();
  @$core.pragma('dart2js:noInline')
  static GetPhotoThemePlayersEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPhotoThemePlayersEventOut>(create);
  static GetPhotoThemePlayersEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PhotoThemePlayer> get players => $_getList(0);
}

class SetTournamentPhotoThemeEvent extends $pb.GeneratedMessage {
  factory SetTournamentPhotoThemeEvent({
    $core.int? themeId,
  }) {
    final $result = create();
    if (themeId != null) {
      $result.themeId = themeId;
    }
    return $result;
  }
  SetTournamentPhotoThemeEvent._() : super();
  factory SetTournamentPhotoThemeEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SetTournamentPhotoThemeEvent.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetTournamentPhotoThemeEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'themeId', $pb.PbFieldType.O3, protoName: 'themeId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SetTournamentPhotoThemeEvent clone() => SetTournamentPhotoThemeEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SetTournamentPhotoThemeEvent copyWith(void Function(SetTournamentPhotoThemeEvent) updates) =>
      super.copyWith((message) => updates(message as SetTournamentPhotoThemeEvent)) as SetTournamentPhotoThemeEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetTournamentPhotoThemeEvent create() => SetTournamentPhotoThemeEvent._();
  SetTournamentPhotoThemeEvent createEmptyInstance() => create();
  static $pb.PbList<SetTournamentPhotoThemeEvent> createRepeated() => $pb.PbList<SetTournamentPhotoThemeEvent>();
  @$core.pragma('dart2js:noInline')
  static SetTournamentPhotoThemeEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetTournamentPhotoThemeEvent>(create);
  static SetTournamentPhotoThemeEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get themeId => $_getIZ(0);
  @$pb.TagNumber(1)
  set themeId($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasThemeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearThemeId() => $_clearField(1);
}

class AddPlayerToThemeEvent extends $pb.GeneratedMessage {
  factory AddPlayerToThemeEvent({
    $core.int? playerId,
  }) {
    final $result = create();
    if (playerId != null) {
      $result.playerId = playerId;
    }
    return $result;
  }
  AddPlayerToThemeEvent._() : super();
  factory AddPlayerToThemeEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AddPlayerToThemeEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddPlayerToThemeEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'playerId', $pb.PbFieldType.O3, protoName: 'playerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AddPlayerToThemeEvent clone() => AddPlayerToThemeEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AddPlayerToThemeEvent copyWith(void Function(AddPlayerToThemeEvent) updates) =>
      super.copyWith((message) => updates(message as AddPlayerToThemeEvent)) as AddPlayerToThemeEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddPlayerToThemeEvent create() => AddPlayerToThemeEvent._();
  AddPlayerToThemeEvent createEmptyInstance() => create();
  static $pb.PbList<AddPlayerToThemeEvent> createRepeated() => $pb.PbList<AddPlayerToThemeEvent>();
  @$core.pragma('dart2js:noInline')
  static AddPlayerToThemeEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddPlayerToThemeEvent>(create);
  static AddPlayerToThemeEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get playerId => $_getIZ(0);
  @$pb.TagNumber(1)
  set playerId($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPlayerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayerId() => $_clearField(1);
}

class AddPlayersFromTournamentEvent extends $pb.GeneratedMessage {
  factory AddPlayersFromTournamentEvent({
    $core.int? tournamentId,
  }) {
    final $result = create();
    if (tournamentId != null) {
      $result.tournamentId = tournamentId;
    }
    return $result;
  }
  AddPlayersFromTournamentEvent._() : super();
  factory AddPlayersFromTournamentEvent.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AddPlayersFromTournamentEvent.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddPlayersFromTournamentEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'tournamentId', $pb.PbFieldType.O3, protoName: 'tournamentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AddPlayersFromTournamentEvent clone() => AddPlayersFromTournamentEvent()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AddPlayersFromTournamentEvent copyWith(void Function(AddPlayersFromTournamentEvent) updates) =>
      super.copyWith((message) => updates(message as AddPlayersFromTournamentEvent)) as AddPlayersFromTournamentEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddPlayersFromTournamentEvent create() => AddPlayersFromTournamentEvent._();
  AddPlayersFromTournamentEvent createEmptyInstance() => create();
  static $pb.PbList<AddPlayersFromTournamentEvent> createRepeated() => $pb.PbList<AddPlayersFromTournamentEvent>();
  @$core.pragma('dart2js:noInline')
  static AddPlayersFromTournamentEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddPlayersFromTournamentEvent>(create);
  static AddPlayersFromTournamentEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get tournamentId => $_getIZ(0);
  @$pb.TagNumber(1)
  set tournamentId($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTournamentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTournamentId() => $_clearField(1);
}

class AddPlayersFromTournamentEventOut extends $pb.GeneratedMessage {
  factory AddPlayersFromTournamentEventOut({
    $core.int? addedCount,
  }) {
    final $result = create();
    if (addedCount != null) {
      $result.addedCount = addedCount;
    }
    return $result;
  }
  AddPlayersFromTournamentEventOut._() : super();
  factory AddPlayersFromTournamentEventOut.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AddPlayersFromTournamentEventOut.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddPlayersFromTournamentEventOut',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'generated'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'addedCount', $pb.PbFieldType.O3, protoName: 'addedCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AddPlayersFromTournamentEventOut clone() => AddPlayersFromTournamentEventOut()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AddPlayersFromTournamentEventOut copyWith(void Function(AddPlayersFromTournamentEventOut) updates) =>
      super.copyWith((message) => updates(message as AddPlayersFromTournamentEventOut))
          as AddPlayersFromTournamentEventOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddPlayersFromTournamentEventOut create() => AddPlayersFromTournamentEventOut._();
  AddPlayersFromTournamentEventOut createEmptyInstance() => create();
  static $pb.PbList<AddPlayersFromTournamentEventOut> createRepeated() =>
      $pb.PbList<AddPlayersFromTournamentEventOut>();
  @$core.pragma('dart2js:noInline')
  static AddPlayersFromTournamentEventOut getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddPlayersFromTournamentEventOut>(create);
  static AddPlayersFromTournamentEventOut? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get addedCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set addedCount($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAddedCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddedCount() => $_clearField(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
