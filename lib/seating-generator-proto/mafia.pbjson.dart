//
//  Generated code. Do not modify.
//  source: seating-generator-proto/mafia.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use bestMoveDescriptor instead')
const BestMove$json = {
  '1': 'BestMove',
  '2': [
    {'1': 'miss', '2': 0},
    {'1': 'half', '2': 1},
    {'1': 'full', '2': 2},
    {'1': 'one', '2': 3},
  ],
};

/// Descriptor for `BestMove`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List bestMoveDescriptor = $convert.base64Decode(
    'CghCZXN0TW92ZRIICgRtaXNzEAASCAoEaGFsZhABEggKBGZ1bGwQAhIHCgNvbmUQAw==');

@$core.Deprecated('Use gameWinDescriptor instead')
const GameWin$json = {
  '1': 'GameWin',
  '2': [
    {'1': 'city', '2': 0},
    {'1': 'mafia', '2': 1},
    {'1': 'draw', '2': 2},
  ],
};

/// Descriptor for `GameWin`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List gameWinDescriptor = $convert.base64Decode(
    'CgdHYW1lV2luEggKBGNpdHkQABIJCgVtYWZpYRABEggKBGRyYXcQAg==');

@$core.Deprecated('Use fantasyStatusDescriptor instead')
const FantasyStatus$json = {
  '1': 'FantasyStatus',
  '2': [
    {'1': 'disabled', '2': 0},
    {'1': 'enabledForSelected', '2': 1},
    {'1': 'enabledForAll', '2': 2},
  ],
};

/// Descriptor for `FantasyStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fantasyStatusDescriptor = $convert.base64Decode(
    'Cg1GYW50YXN5U3RhdHVzEgwKCGRpc2FibGVkEAASFgoSZW5hYmxlZEZvclNlbGVjdGVkEAESEQ'
    'oNZW5hYmxlZEZvckFsbBAC');

@$core.Deprecated('Use playerRoleDescriptor instead')
const PlayerRole$json = {
  '1': 'PlayerRole',
  '2': [
    {'1': 'citizen', '2': 0},
    {'1': 'maf', '2': 1},
    {'1': 'don', '2': 2},
    {'1': 'sheriff', '2': 3},
  ],
};

/// Descriptor for `PlayerRole`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List playerRoleDescriptor = $convert.base64Decode(
    'CgpQbGF5ZXJSb2xlEgsKB2NpdGl6ZW4QABIHCgNtYWYQARIHCgNkb24QAhILCgdzaGVyaWZmEA'
    'M=');

@$core.Deprecated('Use playerStatusDescriptor instead')
const PlayerStatus$json = {
  '1': 'PlayerStatus',
  '2': [
    {'1': 'alive', '2': 0},
    {'1': 'voted', '2': 1},
    {'1': 'deleted', '2': 2},
    {'1': 'killed', '2': 3},
  ],
};

/// Descriptor for `PlayerStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List playerStatusDescriptor = $convert.base64Decode(
    'CgxQbGF5ZXJTdGF0dXMSCQoFYWxpdmUQABIJCgV2b3RlZBABEgsKB2RlbGV0ZWQQAhIKCgZraW'
    'xsZWQQAw==');

@$core.Deprecated('Use ratingSchemeDescriptor instead')
const RatingScheme$json = {
  '1': 'RatingScheme',
  '2': [
    {'1': 'oldFSM', '2': 0},
    {'1': 'minusFSM', '2': 1},
  ],
};

/// Descriptor for `RatingScheme`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List ratingSchemeDescriptor = $convert.base64Decode(
    'CgxSYXRpbmdTY2hlbWUSCgoGb2xkRlNNEAASDAoIbWludXNGU00QAQ==');

@$core.Deprecated('Use loginEventDescriptor instead')
const LoginEvent$json = {
  '1': 'LoginEvent',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `LoginEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginEventDescriptor = $convert.base64Decode(
    'CgpMb2dpbkV2ZW50EhQKBWVtYWlsGAEgASgJUgVlbWFpbBIaCghwYXNzd29yZBgCIAEoCVIIcG'
    'Fzc3dvcmQ=');

@$core.Deprecated('Use tableSeatingDescriptor instead')
const TableSeating$json = {
  '1': 'TableSeating',
  '2': [
    {'1': 'nickname', '3': 1, '4': 3, '5': 9, '10': 'nickname'},
    {'1': 'referee', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'referee', '17': true},
    {'1': 'table', '3': 3, '4': 1, '5': 5, '10': 'table'},
  ],
  '8': [
    {'1': '_referee'},
  ],
};

/// Descriptor for `TableSeating`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tableSeatingDescriptor = $convert.base64Decode(
    'CgxUYWJsZVNlYXRpbmcSGgoIbmlja25hbWUYASADKAlSCG5pY2tuYW1lEh0KB3JlZmVyZWUYAi'
    'ABKAlIAFIHcmVmZXJlZYgBARIUCgV0YWJsZRgDIAEoBVIFdGFibGVCCgoIX3JlZmVyZWU=');

@$core.Deprecated('Use tableSeatingResultDescriptor instead')
const TableSeatingResult$json = {
  '1': 'TableSeatingResult',
  '2': [
    {'1': 'role', '3': 1, '4': 3, '5': 14, '6': '.generated.PlayerRole', '10': 'role'},
    {'1': 'score', '3': 2, '4': 3, '5': 1, '10': 'score'},
    {'1': 'died', '3': 3, '4': 1, '5': 5, '9': 0, '10': 'died', '17': true},
    {'1': 'win', '3': 4, '4': 1, '5': 14, '6': '.generated.GameWin', '10': 'win'},
    {'1': 'bestMove', '3': 5, '4': 1, '5': 14, '6': '.generated.BestMove', '10': 'bestMove'},
    {'1': 'addScore', '3': 6, '4': 3, '5': 1, '10': 'addScore'},
    {'1': 'minusScore', '3': 7, '4': 3, '5': 1, '10': 'minusScore'},
  ],
  '8': [
    {'1': '_died'},
  ],
};

/// Descriptor for `TableSeatingResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tableSeatingResultDescriptor = $convert.base64Decode(
    'ChJUYWJsZVNlYXRpbmdSZXN1bHQSKQoEcm9sZRgBIAMoDjIVLmdlbmVyYXRlZC5QbGF5ZXJSb2'
    'xlUgRyb2xlEhQKBXNjb3JlGAIgAygBUgVzY29yZRIXCgRkaWVkGAMgASgFSABSBGRpZWSIAQES'
    'JAoDd2luGAQgASgOMhIuZ2VuZXJhdGVkLkdhbWVXaW5SA3dpbhIvCghiZXN0TW92ZRgFIAEoDj'
    'ITLmdlbmVyYXRlZC5CZXN0TW92ZVIIYmVzdE1vdmUSGgoIYWRkU2NvcmUYBiADKAFSCGFkZFNj'
    'b3JlEh4KCm1pbnVzU2NvcmUYByADKAFSCm1pbnVzU2NvcmVCBwoFX2RpZWQ=');

@$core.Deprecated('Use updateHideDateRequestDescriptor instead')
const UpdateHideDateRequest$json = {
  '1': 'UpdateHideDateRequest',
  '2': [
    {'1': 'date', '3': 1, '4': 1, '5': 9, '10': 'date'},
  ],
};

/// Descriptor for `UpdateHideDateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateHideDateRequestDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVIaWRlRGF0ZVJlcXVlc3QSEgoEZGF0ZRgBIAEoCVIEZGF0ZQ==');

@$core.Deprecated('Use tableSeatingItemDescriptor instead')
const TableSeatingItem$json = {
  '1': 'TableSeatingItem',
  '2': [
    {'1': 'gameId', '3': 1, '4': 1, '5': 5, '10': 'gameId'},
    {'1': 'seating', '3': 2, '4': 1, '5': 11, '6': '.generated.TableSeating', '10': 'seating'},
    {'1': 'result', '3': 3, '4': 1, '5': 11, '6': '.generated.TableSeatingResult', '9': 0, '10': 'result', '17': true},
    {'1': 'game', '3': 4, '4': 1, '5': 5, '10': 'game'},
    {'1': 'table', '3': 5, '4': 1, '5': 5, '10': 'table'},
  ],
  '8': [
    {'1': '_result'},
  ],
};

/// Descriptor for `TableSeatingItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tableSeatingItemDescriptor = $convert.base64Decode(
    'ChBUYWJsZVNlYXRpbmdJdGVtEhYKBmdhbWVJZBgBIAEoBVIGZ2FtZUlkEjEKB3NlYXRpbmcYAi'
    'ABKAsyFy5nZW5lcmF0ZWQuVGFibGVTZWF0aW5nUgdzZWF0aW5nEjoKBnJlc3VsdBgDIAEoCzId'
    'LmdlbmVyYXRlZC5UYWJsZVNlYXRpbmdSZXN1bHRIAFIGcmVzdWx0iAEBEhIKBGdhbWUYBCABKA'
    'VSBGdhbWUSFAoFdGFibGUYBSABKAVSBXRhYmxlQgkKB19yZXN1bHQ=');

@$core.Deprecated('Use seatingEventOutDescriptor instead')
const SeatingEventOut$json = {
  '1': 'SeatingEventOut',
  '2': [
    {'1': 'item', '3': 1, '4': 3, '5': 11, '6': '.generated.TableSeatingItem', '10': 'item'},
  ],
};

/// Descriptor for `SeatingEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List seatingEventOutDescriptor = $convert.base64Decode(
    'Cg9TZWF0aW5nRXZlbnRPdXQSLwoEaXRlbRgBIAMoCzIbLmdlbmVyYXRlZC5UYWJsZVNlYXRpbm'
    'dJdGVtUgRpdGVt');

@$core.Deprecated('Use loginEventOutDescriptor instead')
const LoginEventOut$json = {
  '1': 'LoginEventOut',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'recoveryToken', '3': 2, '4': 1, '5': 9, '10': 'recoveryToken'},
    {'1': 'error', '3': 3, '4': 1, '5': 14, '6': '.generated.LoginEventOut.Error', '10': 'error'},
    {'1': 'id', '3': 4, '4': 1, '5': 5, '9': 0, '10': 'id', '17': true},
  ],
  '4': [LoginEventOut_Error$json],
  '8': [
    {'1': '_id'},
  ],
};

@$core.Deprecated('Use loginEventOutDescriptor instead')
const LoginEventOut_Error$json = {
  '1': 'Error',
  '2': [
    {'1': 'noError', '2': 0},
    {'1': 'needVerification', '2': 1},
    {'1': 'invalidCredentials', '2': 2},
  ],
};

/// Descriptor for `LoginEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginEventOutDescriptor = $convert.base64Decode(
    'Cg1Mb2dpbkV2ZW50T3V0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIkCg1yZWNvdmVyeVRva2VuGA'
    'IgASgJUg1yZWNvdmVyeVRva2VuEjQKBWVycm9yGAMgASgOMh4uZ2VuZXJhdGVkLkxvZ2luRXZl'
    'bnRPdXQuRXJyb3JSBWVycm9yEhMKAmlkGAQgASgFSABSAmlkiAEBIkIKBUVycm9yEgsKB25vRX'
    'Jyb3IQABIUChBuZWVkVmVyaWZpY2F0aW9uEAESFgoSaW52YWxpZENyZWRlbnRpYWxzEAJCBQoD'
    'X2lk');

@$core.Deprecated('Use changeSeatingContentDescriptor instead')
const ChangeSeatingContent$json = {
  '1': 'ChangeSeatingContent',
  '2': [
    {'1': 'player', '3': 1, '4': 1, '5': 5, '9': 0, '10': 'player', '17': true},
    {'1': 'imageUrl', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'imageUrl', '17': true},
    {'1': 'role', '3': 3, '4': 1, '5': 14, '6': '.generated.PlayerRole', '9': 2, '10': 'role', '17': true},
    {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.generated.PlayerStatus', '9': 3, '10': 'status', '17': true},
    {'1': 'selectedGame', '3': 5, '4': 1, '5': 5, '9': 4, '10': 'selectedGame', '17': true},
  ],
  '8': [
    {'1': '_player'},
    {'1': '_imageUrl'},
    {'1': '_role'},
    {'1': '_status'},
    {'1': '_selectedGame'},
  ],
};

/// Descriptor for `ChangeSeatingContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changeSeatingContentDescriptor = $convert.base64Decode(
    'ChRDaGFuZ2VTZWF0aW5nQ29udGVudBIbCgZwbGF5ZXIYASABKAVIAFIGcGxheWVyiAEBEh8KCG'
    'ltYWdlVXJsGAIgASgJSAFSCGltYWdlVXJsiAEBEi4KBHJvbGUYAyABKA4yFS5nZW5lcmF0ZWQu'
    'UGxheWVyUm9sZUgCUgRyb2xliAEBEjQKBnN0YXR1cxgEIAEoDjIXLmdlbmVyYXRlZC5QbGF5ZX'
    'JTdGF0dXNIA1IGc3RhdHVziAEBEicKDHNlbGVjdGVkR2FtZRgFIAEoBUgEUgxzZWxlY3RlZEdh'
    'bWWIAQFCCQoHX3BsYXllckILCglfaW1hZ2VVcmxCBwoFX3JvbGVCCQoHX3N0YXR1c0IPCg1fc2'
    'VsZWN0ZWRHYW1l');

@$core.Deprecated('Use clubDescriptor instead')
const Club$json = {
  '1': 'Club',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'description', '17': true},
    {'1': 'imageUrl', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'imageUrl', '17': true},
    {'1': 'groupLink', '3': 5, '4': 1, '5': 9, '9': 2, '10': 'groupLink', '17': true},
    {'1': 'city', '3': 6, '4': 1, '5': 9, '9': 3, '10': 'city', '17': true},
    {'1': 'billedFor', '3': 7, '4': 1, '5': 9, '9': 4, '10': 'billedFor', '17': true},
  ],
  '8': [
    {'1': '_description'},
    {'1': '_imageUrl'},
    {'1': '_groupLink'},
    {'1': '_city'},
    {'1': '_billedFor'},
  ],
};

/// Descriptor for `Club`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clubDescriptor = $convert.base64Decode(
    'CgRDbHViEg4KAmlkGAEgASgFUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiUKC2Rlc2NyaXB0aW'
    '9uGAMgASgJSABSC2Rlc2NyaXB0aW9uiAEBEh8KCGltYWdlVXJsGAQgASgJSAFSCGltYWdlVXJs'
    'iAEBEiEKCWdyb3VwTGluaxgFIAEoCUgCUglncm91cExpbmuIAQESFwoEY2l0eRgGIAEoCUgDUg'
    'RjaXR5iAEBEiEKCWJpbGxlZEZvchgHIAEoCUgEUgliaWxsZWRGb3KIAQFCDgoMX2Rlc2NyaXB0'
    'aW9uQgsKCV9pbWFnZVVybEIMCgpfZ3JvdXBMaW5rQgcKBV9jaXR5QgwKCl9iaWxsZWRGb3I=');

@$core.Deprecated('Use clubRatingEventOutDescriptor instead')
const ClubRatingEventOut$json = {
  '1': 'ClubRatingEventOut',
  '2': [
    {'1': 'row', '3': 1, '4': 3, '5': 11, '6': '.generated.ClubRatingRow', '10': 'row'},
    {'1': 'clubName', '3': 2, '4': 1, '5': 9, '10': 'clubName'},
    {'1': 'games', '3': 3, '4': 1, '5': 5, '10': 'games'},
    {'1': 'mafiaWins', '3': 4, '4': 1, '5': 5, '10': 'mafiaWins'},
    {'1': 'citizenWins', '3': 5, '4': 1, '5': 5, '10': 'citizenWins'},
  ],
};

/// Descriptor for `ClubRatingEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clubRatingEventOutDescriptor = $convert.base64Decode(
    'ChJDbHViUmF0aW5nRXZlbnRPdXQSKgoDcm93GAEgAygLMhguZ2VuZXJhdGVkLkNsdWJSYXRpbm'
    'dSb3dSA3JvdxIaCghjbHViTmFtZRgCIAEoCVIIY2x1Yk5hbWUSFAoFZ2FtZXMYAyABKAVSBWdh'
    'bWVzEhwKCW1hZmlhV2lucxgEIAEoBVIJbWFmaWFXaW5zEiAKC2NpdGl6ZW5XaW5zGAUgASgFUg'
    'tjaXRpemVuV2lucw==');

@$core.Deprecated('Use clubRatingRowDescriptor instead')
const ClubRatingRow$json = {
  '1': 'ClubRatingRow',
  '2': [
    {'1': 'nickname', '3': 1, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'score', '3': 2, '4': 1, '5': 1, '10': 'score'},
    {'1': 'addScore', '3': 3, '4': 1, '5': 1, '10': 'addScore'},
    {'1': 'firstDie', '3': 4, '4': 1, '5': 5, '10': 'firstDie'},
    {'1': 'donWins', '3': 5, '4': 1, '5': 5, '10': 'donWins'},
    {'1': 'sheriffWins', '3': 6, '4': 1, '5': 5, '10': 'sheriffWins'},
    {'1': 'item', '3': 7, '4': 3, '5': 11, '6': '.generated.ClubRatingRow.GameItem', '10': 'item'},
    {'1': 'wins', '3': 8, '4': 1, '5': 5, '10': 'wins'},
    {'1': 'ci', '3': 9, '4': 1, '5': 5, '10': 'ci'},
    {'1': 'totalGames', '3': 10, '4': 1, '5': 5, '10': 'totalGames'},
    {'1': 'citizenGames', '3': 11, '4': 1, '5': 5, '10': 'citizenGames'},
    {'1': 'donGames', '3': 12, '4': 1, '5': 5, '10': 'donGames'},
    {'1': 'sheriffGames', '3': 13, '4': 1, '5': 5, '10': 'sheriffGames'},
    {'1': 'mafiaGames', '3': 14, '4': 1, '5': 5, '10': 'mafiaGames'},
    {'1': 'mafiaWins', '3': 15, '4': 1, '5': 5, '10': 'mafiaWins'},
    {'1': 'citizenWins', '3': 16, '4': 1, '5': 5, '10': 'citizenWins'},
    {'1': 'citizenAddScore', '3': 17, '4': 1, '5': 1, '10': 'citizenAddScore'},
    {'1': 'mafiaAddScore', '3': 18, '4': 1, '5': 1, '10': 'mafiaAddScore'},
    {'1': 'donAddScore', '3': 19, '4': 1, '5': 1, '10': 'donAddScore'},
    {'1': 'sheriffAddScore', '3': 20, '4': 1, '5': 1, '10': 'sheriffAddScore'},
    {'1': 'citizenScore', '3': 21, '4': 1, '5': 1, '10': 'citizenScore'},
    {'1': 'mafiaScore', '3': 22, '4': 1, '5': 1, '10': 'mafiaScore'},
    {'1': 'donScore', '3': 23, '4': 1, '5': 1, '10': 'donScore'},
    {'1': 'sheriffScore', '3': 24, '4': 1, '5': 1, '10': 'sheriffScore'},
    {'1': 'playerId', '3': 25, '4': 1, '5': 5, '10': 'playerId'},
    {'1': 'refereeCount', '3': 26, '4': 1, '5': 5, '10': 'refereeCount'},
    {'1': 'minusScore', '3': 27, '4': 1, '5': 1, '10': 'minusScore'},
    {'1': 'citizenMinusScore', '3': 28, '4': 1, '5': 1, '10': 'citizenMinusScore'},
    {'1': 'mafiaMinusScore', '3': 29, '4': 1, '5': 1, '10': 'mafiaMinusScore'},
    {'1': 'donMinusScore', '3': 30, '4': 1, '5': 1, '10': 'donMinusScore'},
    {'1': 'sheriffMinusScore', '3': 31, '4': 1, '5': 1, '10': 'sheriffMinusScore'},
    {'1': 'bestMoveCitizen', '3': 32, '4': 1, '5': 1, '10': 'bestMoveCitizen'},
    {'1': 'bestMoveSheriff', '3': 33, '4': 1, '5': 1, '10': 'bestMoveSheriff'},
  ],
  '3': [ClubRatingRow_GameItem$json],
};

@$core.Deprecated('Use clubRatingRowDescriptor instead')
const ClubRatingRow_GameItem$json = {
  '1': 'GameItem',
  '2': [
    {'1': 'gameId', '3': 1, '4': 1, '5': 5, '10': 'gameId'},
    {'1': 'score', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'score', '17': true},
  ],
  '8': [
    {'1': '_score'},
  ],
};

/// Descriptor for `ClubRatingRow`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clubRatingRowDescriptor = $convert.base64Decode(
    'Cg1DbHViUmF0aW5nUm93EhoKCG5pY2tuYW1lGAEgASgJUghuaWNrbmFtZRIUCgVzY29yZRgCIA'
    'EoAVIFc2NvcmUSGgoIYWRkU2NvcmUYAyABKAFSCGFkZFNjb3JlEhoKCGZpcnN0RGllGAQgASgF'
    'UghmaXJzdERpZRIYCgdkb25XaW5zGAUgASgFUgdkb25XaW5zEiAKC3NoZXJpZmZXaW5zGAYgAS'
    'gFUgtzaGVyaWZmV2lucxI1CgRpdGVtGAcgAygLMiEuZ2VuZXJhdGVkLkNsdWJSYXRpbmdSb3cu'
    'R2FtZUl0ZW1SBGl0ZW0SEgoEd2lucxgIIAEoBVIEd2lucxIOCgJjaRgJIAEoBVICY2kSHgoKdG'
    '90YWxHYW1lcxgKIAEoBVIKdG90YWxHYW1lcxIiCgxjaXRpemVuR2FtZXMYCyABKAVSDGNpdGl6'
    'ZW5HYW1lcxIaCghkb25HYW1lcxgMIAEoBVIIZG9uR2FtZXMSIgoMc2hlcmlmZkdhbWVzGA0gAS'
    'gFUgxzaGVyaWZmR2FtZXMSHgoKbWFmaWFHYW1lcxgOIAEoBVIKbWFmaWFHYW1lcxIcCgltYWZp'
    'YVdpbnMYDyABKAVSCW1hZmlhV2lucxIgCgtjaXRpemVuV2lucxgQIAEoBVILY2l0aXplbldpbn'
    'MSKAoPY2l0aXplbkFkZFNjb3JlGBEgASgBUg9jaXRpemVuQWRkU2NvcmUSJAoNbWFmaWFBZGRT'
    'Y29yZRgSIAEoAVINbWFmaWFBZGRTY29yZRIgCgtkb25BZGRTY29yZRgTIAEoAVILZG9uQWRkU2'
    'NvcmUSKAoPc2hlcmlmZkFkZFNjb3JlGBQgASgBUg9zaGVyaWZmQWRkU2NvcmUSIgoMY2l0aXpl'
    'blNjb3JlGBUgASgBUgxjaXRpemVuU2NvcmUSHgoKbWFmaWFTY29yZRgWIAEoAVIKbWFmaWFTY2'
    '9yZRIaCghkb25TY29yZRgXIAEoAVIIZG9uU2NvcmUSIgoMc2hlcmlmZlNjb3JlGBggASgBUgxz'
    'aGVyaWZmU2NvcmUSGgoIcGxheWVySWQYGSABKAVSCHBsYXllcklkEiIKDHJlZmVyZWVDb3VudB'
    'gaIAEoBVIMcmVmZXJlZUNvdW50Eh4KCm1pbnVzU2NvcmUYGyABKAFSCm1pbnVzU2NvcmUSLAoR'
    'Y2l0aXplbk1pbnVzU2NvcmUYHCABKAFSEWNpdGl6ZW5NaW51c1Njb3JlEigKD21hZmlhTWludX'
    'NTY29yZRgdIAEoAVIPbWFmaWFNaW51c1Njb3JlEiQKDWRvbk1pbnVzU2NvcmUYHiABKAFSDWRv'
    'bk1pbnVzU2NvcmUSLAoRc2hlcmlmZk1pbnVzU2NvcmUYHyABKAFSEXNoZXJpZmZNaW51c1Njb3'
    'JlEigKD2Jlc3RNb3ZlQ2l0aXplbhggIAEoAVIPYmVzdE1vdmVDaXRpemVuEigKD2Jlc3RNb3Zl'
    'U2hlcmlmZhghIAEoAVIPYmVzdE1vdmVTaGVyaWZmGkcKCEdhbWVJdGVtEhYKBmdhbWVJZBgBIA'
    'EoBVIGZ2FtZUlkEhkKBXNjb3JlGAIgASgBSABSBXNjb3JliAEBQggKBl9zY29yZQ==');

@$core.Deprecated('Use addGameEventOutDescriptor instead')
const AddGameEventOut$json = {
  '1': 'AddGameEventOut',
  '2': [
    {'1': 'gameId', '3': 1, '4': 1, '5': 5, '10': 'gameId'},
  ],
};

/// Descriptor for `AddGameEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addGameEventOutDescriptor = $convert.base64Decode(
    'Cg9BZGRHYW1lRXZlbnRPdXQSFgoGZ2FtZUlkGAEgASgFUgZnYW1lSWQ=');

@$core.Deprecated('Use ciSchemeDescriptor instead')
const CiScheme$json = {
  '1': 'CiScheme',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `CiScheme`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ciSchemeDescriptor = $convert.base64Decode(
    'CghDaVNjaGVtZRIOCgJpZBgBIAEoBVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use availableCiEventOutDescriptor instead')
const AvailableCiEventOut$json = {
  '1': 'AvailableCiEventOut',
  '2': [
    {'1': 'schemes', '3': 1, '4': 3, '5': 11, '6': '.generated.CiScheme', '10': 'schemes'},
  ],
};

/// Descriptor for `AvailableCiEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List availableCiEventOutDescriptor = $convert.base64Decode(
    'ChNBdmFpbGFibGVDaUV2ZW50T3V0Ei0KB3NjaGVtZXMYASADKAsyEy5nZW5lcmF0ZWQuQ2lTY2'
    'hlbWVSB3NjaGVtZXM=');

@$core.Deprecated('Use setFinalPlayersEventDescriptor instead')
const SetFinalPlayersEvent$json = {
  '1': 'SetFinalPlayersEvent',
  '2': [
    {'1': 'id', '3': 1, '4': 3, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `SetFinalPlayersEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setFinalPlayersEventDescriptor = $convert.base64Decode(
    'ChRTZXRGaW5hbFBsYXllcnNFdmVudBIOCgJpZBgBIAMoBVICaWQ=');

@$core.Deprecated('Use clubGameResultDescriptor instead')
const ClubGameResult$json = {
  '1': 'ClubGameResult',
  '2': [
    {'1': 'addScore', '3': 1, '4': 3, '5': 5, '10': 'addScore'},
    {'1': 'players', '3': 2, '4': 3, '5': 5, '10': 'players'},
    {'1': 'win', '3': 3, '4': 1, '5': 14, '6': '.generated.GameWin', '9': 0, '10': 'win', '17': true},
    {'1': 'firstDie', '3': 4, '4': 1, '5': 5, '9': 1, '10': 'firstDie', '17': true},
    {'1': 'bestMove', '3': 5, '4': 1, '5': 14, '6': '.generated.BestMove', '9': 2, '10': 'bestMove', '17': true},
    {'1': 'date', '3': 6, '4': 1, '5': 9, '9': 3, '10': 'date', '17': true},
    {'1': 'referee', '3': 7, '4': 1, '5': 5, '10': 'referee'},
    {'1': 'mafia1', '3': 8, '4': 1, '5': 5, '9': 4, '10': 'mafia1', '17': true},
    {'1': 'mafia2', '3': 9, '4': 1, '5': 5, '9': 5, '10': 'mafia2', '17': true},
    {'1': 'don', '3': 10, '4': 1, '5': 5, '9': 6, '10': 'don', '17': true},
    {'1': 'sheriff', '3': 11, '4': 1, '5': 5, '9': 7, '10': 'sheriff', '17': true},
    {'1': 'ciId', '3': 12, '4': 1, '5': 5, '9': 8, '10': 'ciId', '17': true},
    {'1': 'ratingScheme', '3': 13, '4': 1, '5': 14, '6': '.generated.RatingScheme', '9': 9, '10': 'ratingScheme', '17': true},
    {'1': 'minusScore', '3': 14, '4': 3, '5': 5, '10': 'minusScore'},
  ],
  '8': [
    {'1': '_win'},
    {'1': '_firstDie'},
    {'1': '_bestMove'},
    {'1': '_date'},
    {'1': '_mafia1'},
    {'1': '_mafia2'},
    {'1': '_don'},
    {'1': '_sheriff'},
    {'1': '_ciId'},
    {'1': '_ratingScheme'},
  ],
};

/// Descriptor for `ClubGameResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clubGameResultDescriptor = $convert.base64Decode(
    'Cg5DbHViR2FtZVJlc3VsdBIaCghhZGRTY29yZRgBIAMoBVIIYWRkU2NvcmUSGAoHcGxheWVycx'
    'gCIAMoBVIHcGxheWVycxIpCgN3aW4YAyABKA4yEi5nZW5lcmF0ZWQuR2FtZVdpbkgAUgN3aW6I'
    'AQESHwoIZmlyc3REaWUYBCABKAVIAVIIZmlyc3REaWWIAQESNAoIYmVzdE1vdmUYBSABKA4yEy'
    '5nZW5lcmF0ZWQuQmVzdE1vdmVIAlIIYmVzdE1vdmWIAQESFwoEZGF0ZRgGIAEoCUgDUgRkYXRl'
    'iAEBEhgKB3JlZmVyZWUYByABKAVSB3JlZmVyZWUSGwoGbWFmaWExGAggASgFSARSBm1hZmlhMY'
    'gBARIbCgZtYWZpYTIYCSABKAVIBVIGbWFmaWEyiAEBEhUKA2RvbhgKIAEoBUgGUgNkb26IAQES'
    'HQoHc2hlcmlmZhgLIAEoBUgHUgdzaGVyaWZmiAEBEhcKBGNpSWQYDCABKAVICFIEY2lJZIgBAR'
    'JACgxyYXRpbmdTY2hlbWUYDSABKA4yFy5nZW5lcmF0ZWQuUmF0aW5nU2NoZW1lSAlSDHJhdGlu'
    'Z1NjaGVtZYgBARIeCgptaW51c1Njb3JlGA4gAygFUgptaW51c1Njb3JlQgYKBF93aW5CCwoJX2'
    'ZpcnN0RGllQgsKCV9iZXN0TW92ZUIHCgVfZGF0ZUIJCgdfbWFmaWExQgkKB19tYWZpYTJCBgoE'
    'X2RvbkIKCghfc2hlcmlmZkIHCgVfY2lJZEIPCg1fcmF0aW5nU2NoZW1l');

@$core.Deprecated('Use clubsEventOutDescriptor instead')
const ClubsEventOut$json = {
  '1': 'ClubsEventOut',
  '2': [
    {'1': 'club', '3': 1, '4': 3, '5': 11, '6': '.generated.Club', '10': 'club'},
  ],
};

/// Descriptor for `ClubsEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clubsEventOutDescriptor = $convert.base64Decode(
    'Cg1DbHVic0V2ZW50T3V0EiMKBGNsdWIYASADKAsyDy5nZW5lcmF0ZWQuQ2x1YlIEY2x1Yg==');

@$core.Deprecated('Use seatingContentDescriptor instead')
const SeatingContent$json = {
  '1': 'SeatingContent',
  '2': [
    {'1': 'roles', '3': 1, '4': 3, '5': 14, '6': '.generated.PlayerRole', '10': 'roles'},
    {'1': 'status', '3': 2, '4': 3, '5': 14, '6': '.generated.PlayerStatus', '10': 'status'},
    {'1': 'images', '3': 3, '4': 3, '5': 9, '10': 'images'},
    {'1': 'names', '3': 4, '4': 3, '5': 9, '10': 'names'},
    {'1': 'game', '3': 5, '4': 1, '5': 5, '10': 'game'},
    {'1': 'totalGames', '3': 6, '4': 1, '5': 5, '10': 'totalGames'},
  ],
};

/// Descriptor for `SeatingContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List seatingContentDescriptor = $convert.base64Decode(
    'Cg5TZWF0aW5nQ29udGVudBIrCgVyb2xlcxgBIAMoDjIVLmdlbmVyYXRlZC5QbGF5ZXJSb2xlUg'
    'Vyb2xlcxIvCgZzdGF0dXMYAiADKA4yFy5nZW5lcmF0ZWQuUGxheWVyU3RhdHVzUgZzdGF0dXMS'
    'FgoGaW1hZ2VzGAMgAygJUgZpbWFnZXMSFAoFbmFtZXMYBCADKAlSBW5hbWVzEhIKBGdhbWUYBS'
    'ABKAVSBGdhbWUSHgoKdG90YWxHYW1lcxgGIAEoBVIKdG90YWxHYW1lcw==');

@$core.Deprecated('Use loginByTokenEventDescriptor instead')
const LoginByTokenEvent$json = {
  '1': 'LoginByTokenEvent',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `LoginByTokenEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginByTokenEventDescriptor = $convert.base64Decode(
    'ChFMb2dpbkJ5VG9rZW5FdmVudBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4=');

@$core.Deprecated('Use loginByTokenEventOutDescriptor instead')
const LoginByTokenEventOut$json = {
  '1': 'LoginByTokenEventOut',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'recoveryToken', '3': 2, '4': 1, '5': 9, '10': 'recoveryToken'},
    {'1': 'error', '3': 3, '4': 1, '5': 14, '6': '.generated.LoginByTokenEventOut.Error', '10': 'error'},
  ],
  '4': [LoginByTokenEventOut_Error$json],
};

@$core.Deprecated('Use loginByTokenEventOutDescriptor instead')
const LoginByTokenEventOut_Error$json = {
  '1': 'Error',
  '2': [
    {'1': 'noError', '2': 0},
    {'1': 'needVerification', '2': 1},
    {'1': 'invalidCredentials', '2': 2},
  ],
};

/// Descriptor for `LoginByTokenEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginByTokenEventOutDescriptor = $convert.base64Decode(
    'ChRMb2dpbkJ5VG9rZW5FdmVudE91dBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SJAoNcmVjb3Zlcn'
    'lUb2tlbhgCIAEoCVINcmVjb3ZlcnlUb2tlbhI7CgVlcnJvchgDIAEoDjIlLmdlbmVyYXRlZC5M'
    'b2dpbkJ5VG9rZW5FdmVudE91dC5FcnJvclIFZXJyb3IiQgoFRXJyb3ISCwoHbm9FcnJvchAAEh'
    'QKEG5lZWRWZXJpZmljYXRpb24QARIWChJpbnZhbGlkQ3JlZGVudGlhbHMQAg==');

@$core.Deprecated('Use tournamentDescriptionDescriptor instead')
const TournamentDescription$json = {
  '1': 'TournamentDescription',
  '2': [
    {'1': 'gomafiaUrl', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'gomafiaUrl', '17': true},
    {'1': 'vkGroupUrl', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'vkGroupUrl', '17': true},
    {'1': 'vkOwnerUrl', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'vkOwnerUrl', '17': true},
  ],
  '8': [
    {'1': '_gomafiaUrl'},
    {'1': '_vkGroupUrl'},
    {'1': '_vkOwnerUrl'},
  ],
};

/// Descriptor for `TournamentDescription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tournamentDescriptionDescriptor = $convert.base64Decode(
    'ChVUb3VybmFtZW50RGVzY3JpcHRpb24SIwoKZ29tYWZpYVVybBgBIAEoCUgAUgpnb21hZmlhVX'
    'JsiAEBEiMKCnZrR3JvdXBVcmwYAiABKAlIAVIKdmtHcm91cFVybIgBARIjCgp2a093bmVyVXJs'
    'GAMgASgJSAJSCnZrT3duZXJVcmyIAQFCDQoLX2dvbWFmaWFVcmxCDQoLX3ZrR3JvdXBVcmxCDQ'
    'oLX3ZrT3duZXJVcmw=');

@$core.Deprecated('Use signUpEventDescriptor instead')
const SignUpEvent$json = {
  '1': 'SignUpEvent',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `SignUpEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signUpEventDescriptor = $convert.base64Decode(
    'CgtTaWduVXBFdmVudBIUCgVlbWFpbBgBIAEoCVIFZW1haWwSGgoIcGFzc3dvcmQYAiABKAlSCH'
    'Bhc3N3b3Jk');

@$core.Deprecated('Use signUpEventOutDescriptor instead')
const SignUpEventOut$json = {
  '1': 'SignUpEventOut',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'recoveryToken', '3': 2, '4': 1, '5': 9, '10': 'recoveryToken'},
    {'1': 'error', '3': 3, '4': 1, '5': 14, '6': '.generated.SignUpEventOut.Error', '10': 'error'},
    {'1': 'id', '3': 4, '4': 1, '5': 5, '10': 'id'},
  ],
  '4': [SignUpEventOut_Error$json],
};

@$core.Deprecated('Use signUpEventOutDescriptor instead')
const SignUpEventOut_Error$json = {
  '1': 'Error',
  '2': [
    {'1': 'noError', '2': 0},
    {'1': 'emailExist', '2': 1},
    {'1': 'weakPassword', '2': 2},
    {'1': 'needVerification', '2': 4},
  ],
};

/// Descriptor for `SignUpEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signUpEventOutDescriptor = $convert.base64Decode(
    'Cg5TaWduVXBFdmVudE91dBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SJAoNcmVjb3ZlcnlUb2tlbh'
    'gCIAEoCVINcmVjb3ZlcnlUb2tlbhI1CgVlcnJvchgDIAEoDjIfLmdlbmVyYXRlZC5TaWduVXBF'
    'dmVudE91dC5FcnJvclIFZXJyb3ISDgoCaWQYBCABKAVSAmlkIkwKBUVycm9yEgsKB25vRXJyb3'
    'IQABIOCgplbWFpbEV4aXN0EAESEAoMd2Vha1Bhc3N3b3JkEAISFAoQbmVlZFZlcmlmaWNhdGlv'
    'bhAE');

@$core.Deprecated('Use emailVerificationEventDescriptor instead')
const EmailVerificationEvent$json = {
  '1': 'EmailVerificationEvent',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `EmailVerificationEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailVerificationEventDescriptor = $convert.base64Decode(
    'ChZFbWFpbFZlcmlmaWNhdGlvbkV2ZW50Eg4KAmlkGAEgASgFUgJpZBIUCgV0b2tlbhgCIAEoCV'
    'IFdG9rZW4=');

@$core.Deprecated('Use createTournamentEventDescriptor instead')
const CreateTournamentEvent$json = {
  '1': 'CreateTournamentEvent',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'dateStart', '3': 2, '4': 1, '5': 9, '10': 'dateStart'},
    {'1': 'dateEnd', '3': 3, '4': 1, '5': 9, '10': 'dateEnd'},
  ],
};

/// Descriptor for `CreateTournamentEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTournamentEventDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVUb3VybmFtZW50RXZlbnQSEgoEbmFtZRgBIAEoCVIEbmFtZRIcCglkYXRlU3Rhcn'
    'QYAiABKAlSCWRhdGVTdGFydBIYCgdkYXRlRW5kGAMgASgJUgdkYXRlRW5k');

@$core.Deprecated('Use createTournamentEventOutDescriptor instead')
const CreateTournamentEventOut$json = {
  '1': 'CreateTournamentEventOut',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `CreateTournamentEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTournamentEventOutDescriptor = $convert.base64Decode(
    'ChhDcmVhdGVUb3VybmFtZW50RXZlbnRPdXQSDgoCaWQYASABKAVSAmlk');

@$core.Deprecated('Use addPlayerEventDescriptor instead')
const AddPlayerEvent$json = {
  '1': 'AddPlayerEvent',
  '2': [
    {'1': 'player', '3': 1, '4': 1, '5': 11, '6': '.generated.Player', '10': 'player'},
  ],
};

/// Descriptor for `AddPlayerEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addPlayerEventDescriptor = $convert.base64Decode(
    'Cg5BZGRQbGF5ZXJFdmVudBIpCgZwbGF5ZXIYASABKAsyES5nZW5lcmF0ZWQuUGxheWVyUgZwbG'
    'F5ZXI=');

@$core.Deprecated('Use cannotMeetEditionEventDescriptor instead')
const CannotMeetEditionEvent$json = {
  '1': 'CannotMeetEditionEvent',
  '2': [
    {'1': 'player1', '3': 1, '4': 1, '5': 11, '6': '.generated.Player', '10': 'player1'},
    {'1': 'player2', '3': 2, '4': 1, '5': 11, '6': '.generated.Player', '10': 'player2'},
  ],
};

/// Descriptor for `CannotMeetEditionEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cannotMeetEditionEventDescriptor = $convert.base64Decode(
    'ChZDYW5ub3RNZWV0RWRpdGlvbkV2ZW50EisKB3BsYXllcjEYASABKAsyES5nZW5lcmF0ZWQuUG'
    'xheWVyUgdwbGF5ZXIxEisKB3BsYXllcjIYAiABKAsyES5nZW5lcmF0ZWQuUGxheWVyUgdwbGF5'
    'ZXIy');

@$core.Deprecated('Use cannotMeetEventOutDescriptor instead')
const CannotMeetEventOut$json = {
  '1': 'CannotMeetEventOut',
  '2': [
    {'1': 'pairs', '3': 1, '4': 3, '5': 11, '6': '.generated.CannotMeetEditionEvent', '10': 'pairs'},
  ],
};

/// Descriptor for `CannotMeetEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cannotMeetEventOutDescriptor = $convert.base64Decode(
    'ChJDYW5ub3RNZWV0RXZlbnRPdXQSNwoFcGFpcnMYASADKAsyIS5nZW5lcmF0ZWQuQ2Fubm90TW'
    'VldEVkaXRpb25FdmVudFIFcGFpcnM=');

@$core.Deprecated('Use getAvailablePlayerEventOutDescriptor instead')
const GetAvailablePlayerEventOut$json = {
  '1': 'GetAvailablePlayerEventOut',
  '2': [
    {'1': 'players', '3': 1, '4': 3, '5': 11, '6': '.generated.Player', '10': 'players'},
  ],
};

/// Descriptor for `GetAvailablePlayerEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAvailablePlayerEventOutDescriptor = $convert.base64Decode(
    'ChpHZXRBdmFpbGFibGVQbGF5ZXJFdmVudE91dBIrCgdwbGF5ZXJzGAEgAygLMhEuZ2VuZXJhdG'
    'VkLlBsYXllclIHcGxheWVycw==');

@$core.Deprecated('Use tournamentSettingsDescriptor instead')
const TournamentSettings$json = {
  '1': 'TournamentSettings',
  '2': [
    {'1': 'defaultGamesCount', '3': 1, '4': 1, '5': 5, '9': 0, '10': 'defaultGamesCount', '17': true},
    {'1': 'swissGamesCount', '3': 2, '4': 1, '5': 5, '9': 1, '10': 'swissGamesCount', '17': true},
    {'1': 'finalGamesCount', '3': 3, '4': 1, '5': 5, '9': 2, '10': 'finalGamesCount', '17': true},
    {'1': 'buckets', '3': 4, '4': 3, '5': 5, '10': 'buckets'},
    {'1': 'hideResult', '3': 5, '4': 1, '5': 8, '9': 3, '10': 'hideResult', '17': true},
    {'1': 'scheme', '3': 6, '4': 1, '5': 14, '6': '.generated.RatingScheme', '9': 4, '10': 'scheme', '17': true},
    {'1': 'fantasyStatus', '3': 7, '4': 1, '5': 14, '6': '.generated.FantasyStatus', '9': 5, '10': 'fantasyStatus', '17': true},
  ],
  '8': [
    {'1': '_defaultGamesCount'},
    {'1': '_swissGamesCount'},
    {'1': '_finalGamesCount'},
    {'1': '_hideResult'},
    {'1': '_scheme'},
    {'1': '_fantasyStatus'},
  ],
};

/// Descriptor for `TournamentSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tournamentSettingsDescriptor = $convert.base64Decode(
    'ChJUb3VybmFtZW50U2V0dGluZ3MSMQoRZGVmYXVsdEdhbWVzQ291bnQYASABKAVIAFIRZGVmYX'
    'VsdEdhbWVzQ291bnSIAQESLQoPc3dpc3NHYW1lc0NvdW50GAIgASgFSAFSD3N3aXNzR2FtZXND'
    'b3VudIgBARItCg9maW5hbEdhbWVzQ291bnQYAyABKAVIAlIPZmluYWxHYW1lc0NvdW50iAEBEh'
    'gKB2J1Y2tldHMYBCADKAVSB2J1Y2tldHMSIwoKaGlkZVJlc3VsdBgFIAEoCEgDUgpoaWRlUmVz'
    'dWx0iAEBEjQKBnNjaGVtZRgGIAEoDjIXLmdlbmVyYXRlZC5SYXRpbmdTY2hlbWVIBFIGc2NoZW'
    '1liAEBEkMKDWZhbnRhc3lTdGF0dXMYByABKA4yGC5nZW5lcmF0ZWQuRmFudGFzeVN0YXR1c0gF'
    'Ug1mYW50YXN5U3RhdHVziAEBQhQKEl9kZWZhdWx0R2FtZXNDb3VudEISChBfc3dpc3NHYW1lc0'
    'NvdW50QhIKEF9maW5hbEdhbWVzQ291bnRCDQoLX2hpZGVSZXN1bHRCCQoHX3NjaGVtZUIQCg5f'
    'ZmFudGFzeVN0YXR1cw==');

@$core.Deprecated('Use profileDescriptor instead')
const Profile$json = {
  '1': 'Profile',
  '2': [
    {'1': 'firstName', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'firstName', '17': true},
    {'1': 'secondName', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'secondName', '17': true},
  ],
  '8': [
    {'1': '_firstName'},
    {'1': '_secondName'},
  ],
};

/// Descriptor for `Profile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List profileDescriptor = $convert.base64Decode(
    'CgdQcm9maWxlEiEKCWZpcnN0TmFtZRgBIAEoCUgAUglmaXJzdE5hbWWIAQESIwoKc2Vjb25kTm'
    'FtZRgCIAEoCUgBUgpzZWNvbmROYW1liAEBQgwKCl9maXJzdE5hbWVCDQoLX3NlY29uZE5hbWU=');

@$core.Deprecated('Use createPlayerEventOutDescriptor instead')
const CreatePlayerEventOut$json = {
  '1': 'CreatePlayerEventOut',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `CreatePlayerEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPlayerEventOutDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVQbGF5ZXJFdmVudE91dBIOCgJpZBgBIAEoBVICaWQ=');

@$core.Deprecated('Use createPlayerEventDescriptor instead')
const CreatePlayerEvent$json = {
  '1': 'CreatePlayerEvent',
  '2': [
    {'1': 'player', '3': 1, '4': 1, '5': 11, '6': '.generated.Player', '10': 'player'},
  ],
};

/// Descriptor for `CreatePlayerEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPlayerEventDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVQbGF5ZXJFdmVudBIpCgZwbGF5ZXIYASABKAsyES5nZW5lcmF0ZWQuUGxheWVyUg'
    'ZwbGF5ZXI=');

@$core.Deprecated('Use playerDescriptor instead')
const Player$json = {
  '1': 'Player',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'fsmNickname', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'fsmNickname', '17': true},
    {'1': 'mafbankNickname', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'mafbankNickname', '17': true},
    {'1': 'image', '3': 5, '4': 1, '5': 9, '9': 2, '10': 'image', '17': true},
  ],
  '8': [
    {'1': '_fsmNickname'},
    {'1': '_mafbankNickname'},
    {'1': '_image'},
  ],
};

/// Descriptor for `Player`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerDescriptor = $convert.base64Decode(
    'CgZQbGF5ZXISDgoCaWQYASABKAVSAmlkEhoKCG5pY2tuYW1lGAIgASgJUghuaWNrbmFtZRIlCg'
    'tmc21OaWNrbmFtZRgDIAEoCUgAUgtmc21OaWNrbmFtZYgBARItCg9tYWZiYW5rTmlja25hbWUY'
    'BCABKAlIAVIPbWFmYmFua05pY2tuYW1liAEBEhkKBWltYWdlGAUgASgJSAJSBWltYWdliAEBQg'
    '4KDF9mc21OaWNrbmFtZUISChBfbWFmYmFua05pY2tuYW1lQggKBl9pbWFnZQ==');

@$core.Deprecated('Use createSwissRoundDescriptor instead')
const CreateSwissRound$json = {
  '1': 'CreateSwissRound',
  '2': [
    {'1': 'game', '3': 1, '4': 1, '5': 5, '10': 'game'},
  ],
};

/// Descriptor for `CreateSwissRound`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSwissRoundDescriptor = $convert.base64Decode(
    'ChBDcmVhdGVTd2lzc1JvdW5kEhIKBGdhbWUYASABKAVSBGdhbWU=');

@$core.Deprecated('Use emailVerificationEventOutDescriptor instead')
const EmailVerificationEventOut$json = {
  '1': 'EmailVerificationEventOut',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.generated.EmailVerificationEventOut.Status', '10': 'status'},
  ],
  '4': [EmailVerificationEventOut_Status$json],
};

@$core.Deprecated('Use emailVerificationEventOutDescriptor instead')
const EmailVerificationEventOut_Status$json = {
  '1': 'Status',
  '2': [
    {'1': 'success', '2': 0},
    {'1': 'incorrectToken', '2': 1},
  ],
};

/// Descriptor for `EmailVerificationEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailVerificationEventOutDescriptor = $convert.base64Decode(
    'ChlFbWFpbFZlcmlmaWNhdGlvbkV2ZW50T3V0EkMKBnN0YXR1cxgBIAEoDjIrLmdlbmVyYXRlZC'
    '5FbWFpbFZlcmlmaWNhdGlvbkV2ZW50T3V0LlN0YXR1c1IGc3RhdHVzIikKBlN0YXR1cxILCgdz'
    'dWNjZXNzEAASEgoOaW5jb3JyZWN0VG9rZW4QAQ==');

@$core.Deprecated('Use getFinalPlayersOutDescriptor instead')
const GetFinalPlayersOut$json = {
  '1': 'GetFinalPlayersOut',
  '2': [
    {'1': 'player', '3': 1, '4': 3, '5': 11, '6': '.generated.Player', '10': 'player'},
  ],
};

/// Descriptor for `GetFinalPlayersOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFinalPlayersOutDescriptor = $convert.base64Decode(
    'ChJHZXRGaW5hbFBsYXllcnNPdXQSKQoGcGxheWVyGAEgAygLMhEuZ2VuZXJhdGVkLlBsYXllcl'
    'IGcGxheWVy');

@$core.Deprecated('Use seatingForTranslationEventDescriptor instead')
const SeatingForTranslationEvent$json = {
  '1': 'SeatingForTranslationEvent',
  '2': [
    {'1': 'tournamentId', '3': 1, '4': 1, '5': 5, '10': 'tournamentId'},
    {'1': 'table', '3': 2, '4': 1, '5': 5, '10': 'table'},
    {'1': 'game', '3': 3, '4': 1, '5': 5, '10': 'game'},
  ],
};

/// Descriptor for `SeatingForTranslationEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List seatingForTranslationEventDescriptor = $convert.base64Decode(
    'ChpTZWF0aW5nRm9yVHJhbnNsYXRpb25FdmVudBIiCgx0b3VybmFtZW50SWQYASABKAVSDHRvdX'
    'JuYW1lbnRJZBIUCgV0YWJsZRgCIAEoBVIFdGFibGUSEgoEZ2FtZRgDIAEoBVIEZ2FtZQ==');

@$core.Deprecated('Use seatingForTranslationEventOutDescriptor instead')
const SeatingForTranslationEventOut$json = {
  '1': 'SeatingForTranslationEventOut',
  '2': [
    {'1': 'players', '3': 1, '4': 3, '5': 9, '10': 'players'},
  ],
};

/// Descriptor for `SeatingForTranslationEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List seatingForTranslationEventOutDescriptor = $convert.base64Decode(
    'Ch1TZWF0aW5nRm9yVHJhbnNsYXRpb25FdmVudE91dBIYCgdwbGF5ZXJzGAEgAygJUgdwbGF5ZX'
    'Jz');

@$core.Deprecated('Use insertSeatingEventDescriptor instead')
const InsertSeatingEvent$json = {
  '1': 'InsertSeatingEvent',
  '2': [
    {'1': 'bytes', '3': 1, '4': 1, '5': 12, '10': 'bytes'},
    {'1': 'tournamentId', '3': 2, '4': 1, '5': 5, '10': 'tournamentId'},
  ],
};

/// Descriptor for `InsertSeatingEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insertSeatingEventDescriptor = $convert.base64Decode(
    'ChJJbnNlcnRTZWF0aW5nRXZlbnQSFAoFYnl0ZXMYASABKAxSBWJ5dGVzEiIKDHRvdXJuYW1lbn'
    'RJZBgCIAEoBVIMdG91cm5hbWVudElk');

@$core.Deprecated('Use getTournamentsEventOutDescriptor instead')
const GetTournamentsEventOut$json = {
  '1': 'GetTournamentsEventOut',
  '2': [
    {'1': 'tournaments', '3': 1, '4': 3, '5': 11, '6': '.generated.Tournament', '10': 'tournaments'},
  ],
};

/// Descriptor for `GetTournamentsEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTournamentsEventOutDescriptor = $convert.base64Decode(
    'ChZHZXRUb3VybmFtZW50c0V2ZW50T3V0EjcKC3RvdXJuYW1lbnRzGAEgAygLMhUuZ2VuZXJhdG'
    'VkLlRvdXJuYW1lbnRSC3RvdXJuYW1lbnRz');

@$core.Deprecated('Use tournamentDescriptor instead')
const Tournament$json = {
  '1': 'Tournament',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.generated.Tournament.Status', '10': 'status'},
    {'1': 'dateStart', '3': 4, '4': 1, '5': 9, '10': 'dateStart'},
    {'1': 'dateEnd', '3': 5, '4': 1, '5': 9, '10': 'dateEnd'},
    {'1': 'gamesCount', '3': 6, '4': 1, '5': 5, '10': 'gamesCount'},
    {'1': 'billedPlayers', '3': 7, '4': 1, '5': 5, '10': 'billedPlayers'},
    {'1': 'billedTranslation', '3': 8, '4': 1, '5': 8, '10': 'billedTranslation'},
    {'1': 'notificationEnabled', '3': 9, '4': 1, '5': 8, '10': 'notificationEnabled'},
    {'1': 'description', '3': 10, '4': 1, '5': 11, '6': '.generated.TournamentDescription', '10': 'description'},
  ],
  '4': [Tournament_Status$json],
};

@$core.Deprecated('Use tournamentDescriptor instead')
const Tournament_Status$json = {
  '1': 'Status',
  '2': [
    {'1': 'waitForBilling', '2': 0},
    {'1': 'active', '2': 1},
    {'1': 'ended', '2': 2},
  ],
};

/// Descriptor for `Tournament`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tournamentDescriptor = $convert.base64Decode(
    'CgpUb3VybmFtZW50Eg4KAmlkGAEgASgFUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEjQKBnN0YX'
    'R1cxgDIAEoDjIcLmdlbmVyYXRlZC5Ub3VybmFtZW50LlN0YXR1c1IGc3RhdHVzEhwKCWRhdGVT'
    'dGFydBgEIAEoCVIJZGF0ZVN0YXJ0EhgKB2RhdGVFbmQYBSABKAlSB2RhdGVFbmQSHgoKZ2FtZX'
    'NDb3VudBgGIAEoBVIKZ2FtZXNDb3VudBIkCg1iaWxsZWRQbGF5ZXJzGAcgASgFUg1iaWxsZWRQ'
    'bGF5ZXJzEiwKEWJpbGxlZFRyYW5zbGF0aW9uGAggASgIUhFiaWxsZWRUcmFuc2xhdGlvbhIwCh'
    'Nub3RpZmljYXRpb25FbmFibGVkGAkgASgIUhNub3RpZmljYXRpb25FbmFibGVkEkIKC2Rlc2Ny'
    'aXB0aW9uGAogASgLMiAuZ2VuZXJhdGVkLlRvdXJuYW1lbnREZXNjcmlwdGlvblILZGVzY3JpcH'
    'Rpb24iMwoGU3RhdHVzEhIKDndhaXRGb3JCaWxsaW5nEAASCgoGYWN0aXZlEAESCQoFZW5kZWQQ'
    'Ag==');

@$core.Deprecated('Use errorOutDescriptor instead')
const ErrorOut$json = {
  '1': 'ErrorOut',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ErrorOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorOutDescriptor = $convert.base64Decode(
    'CghFcnJvck91dBIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use billTournamentEventDescriptor instead')
const BillTournamentEvent$json = {
  '1': 'BillTournamentEvent',
  '2': [
    {'1': 'players', '3': 1, '4': 1, '5': 5, '10': 'players'},
    {'1': 'hasTranslation', '3': 2, '4': 1, '5': 8, '10': 'hasTranslation'},
    {'1': 'redirectPath', '3': 3, '4': 1, '5': 9, '10': 'redirectPath'},
  ],
};

/// Descriptor for `BillTournamentEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billTournamentEventDescriptor = $convert.base64Decode(
    'ChNCaWxsVG91cm5hbWVudEV2ZW50EhgKB3BsYXllcnMYASABKAVSB3BsYXllcnMSJgoOaGFzVH'
    'JhbnNsYXRpb24YAiABKAhSDmhhc1RyYW5zbGF0aW9uEiIKDHJlZGlyZWN0UGF0aBgDIAEoCVIM'
    'cmVkaXJlY3RQYXRo');

@$core.Deprecated('Use billClubEventDescriptor instead')
const BillClubEvent$json = {
  '1': 'BillClubEvent',
  '2': [
    {'1': 'days', '3': 1, '4': 1, '5': 5, '10': 'days'},
    {'1': 'redirectPath', '3': 2, '4': 1, '5': 9, '10': 'redirectPath'},
  ],
};

/// Descriptor for `BillClubEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billClubEventDescriptor = $convert.base64Decode(
    'Cg1CaWxsQ2x1YkV2ZW50EhIKBGRheXMYASABKAVSBGRheXMSIgoMcmVkaXJlY3RQYXRoGAIgAS'
    'gJUgxyZWRpcmVjdFBhdGg=');

@$core.Deprecated('Use billTournamentEventOutDescriptor instead')
const BillTournamentEventOut$json = {
  '1': 'BillTournamentEventOut',
  '2': [
    {'1': 'redirectLink', '3': 1, '4': 1, '5': 9, '10': 'redirectLink'},
  ],
};

/// Descriptor for `BillTournamentEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billTournamentEventOutDescriptor = $convert.base64Decode(
    'ChZCaWxsVG91cm5hbWVudEV2ZW50T3V0EiIKDHJlZGlyZWN0TGluaxgBIAEoCVIMcmVkaXJlY3'
    'RMaW5r');

@$core.Deprecated('Use startGameInfoEventDescriptor instead')
const StartGameInfoEvent$json = {
  '1': 'StartGameInfoEvent',
  '2': [
    {'1': 'game', '3': 1, '4': 1, '5': 5, '10': 'game'},
    {'1': 'localDate', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'localDate', '17': true},
  ],
  '8': [
    {'1': '_localDate'},
  ],
};

/// Descriptor for `StartGameInfoEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startGameInfoEventDescriptor = $convert.base64Decode(
    'ChJTdGFydEdhbWVJbmZvRXZlbnQSEgoEZ2FtZRgBIAEoBVIEZ2FtZRIhCglsb2NhbERhdGUYAi'
    'ABKAlIAFIJbG9jYWxEYXRliAEBQgwKCl9sb2NhbERhdGU=');

@$core.Deprecated('Use customTextInfoEventDescriptor instead')
const CustomTextInfoEvent$json = {
  '1': 'CustomTextInfoEvent',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
  ],
};

/// Descriptor for `CustomTextInfoEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customTextInfoEventDescriptor = $convert.base64Decode(
    'ChNDdXN0b21UZXh0SW5mb0V2ZW50EhIKBHRleHQYASABKAlSBHRleHQ=');

@$core.Deprecated('Use takeGomafiaSeatingEventDescriptor instead')
const TakeGomafiaSeatingEvent$json = {
  '1': 'TakeGomafiaSeatingEvent',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `TakeGomafiaSeatingEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List takeGomafiaSeatingEventDescriptor = $convert.base64Decode(
    'ChdUYWtlR29tYWZpYVNlYXRpbmdFdmVudBIOCgJpZBgBIAEoBVICaWQ=');

@$core.Deprecated('Use takeGomafiaSeatingEventOutDescriptor instead')
const TakeGomafiaSeatingEventOut$json = {
  '1': 'TakeGomafiaSeatingEventOut',
  '2': [
    {'1': 'notFound', '3': 1, '4': 3, '5': 9, '10': 'notFound'},
  ],
};

/// Descriptor for `TakeGomafiaSeatingEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List takeGomafiaSeatingEventOutDescriptor = $convert.base64Decode(
    'ChpUYWtlR29tYWZpYVNlYXRpbmdFdmVudE91dBIaCghub3RGb3VuZBgBIAMoCVIIbm90Rm91bm'
    'Q=');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgFUgJpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWw=');

@$core.Deprecated('Use tournamentOwnersEventOutDescriptor instead')
const TournamentOwnersEventOut$json = {
  '1': 'TournamentOwnersEventOut',
  '2': [
    {'1': 'owners', '3': 1, '4': 3, '5': 11, '6': '.generated.User', '10': 'owners'},
  ],
};

/// Descriptor for `TournamentOwnersEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tournamentOwnersEventOutDescriptor = $convert.base64Decode(
    'ChhUb3VybmFtZW50T3duZXJzRXZlbnRPdXQSJwoGb3duZXJzGAEgAygLMg8uZ2VuZXJhdGVkLl'
    'VzZXJSBm93bmVycw==');

@$core.Deprecated('Use clubOwnersEventOutDescriptor instead')
const ClubOwnersEventOut$json = {
  '1': 'ClubOwnersEventOut',
  '2': [
    {'1': 'owners', '3': 1, '4': 3, '5': 11, '6': '.generated.User', '10': 'owners'},
  ],
};

/// Descriptor for `ClubOwnersEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clubOwnersEventOutDescriptor = $convert.base64Decode(
    'ChJDbHViT3duZXJzRXZlbnRPdXQSJwoGb3duZXJzGAEgAygLMg8uZ2VuZXJhdGVkLlVzZXJSBm'
    '93bmVycw==');

@$core.Deprecated('Use updateOwnerEventDescriptor instead')
const UpdateOwnerEvent$json = {
  '1': 'UpdateOwnerEvent',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `UpdateOwnerEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateOwnerEventDescriptor = $convert.base64Decode(
    'ChBVcGRhdGVPd25lckV2ZW50EhQKBWVtYWlsGAEgASgJUgVlbWFpbA==');

@$core.Deprecated('Use translationKeyEventOutDescriptor instead')
const TranslationKeyEventOut$json = {
  '1': 'TranslationKeyEventOut',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
  ],
};

/// Descriptor for `TranslationKeyEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List translationKeyEventOutDescriptor = $convert.base64Decode(
    'ChZUcmFuc2xhdGlvbktleUV2ZW50T3V0EhAKA2tleRgBIAEoCVIDa2V5');

@$core.Deprecated('Use tableInfoItemDescriptor instead')
const TableInfoItem$json = {
  '1': 'TableInfoItem',
  '2': [
    {'1': 'table', '3': 1, '4': 1, '5': 5, '10': 'table'},
    {'1': 'info', '3': 2, '4': 1, '5': 9, '10': 'info'},
  ],
};

/// Descriptor for `TableInfoItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tableInfoItemDescriptor = $convert.base64Decode(
    'Cg1UYWJsZUluZm9JdGVtEhQKBXRhYmxlGAEgASgFUgV0YWJsZRISCgRpbmZvGAIgASgJUgRpbm'
    'Zv');

@$core.Deprecated('Use tableInfoEventDescriptor instead')
const TableInfoEvent$json = {
  '1': 'TableInfoEvent',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.generated.TableInfoItem', '10': 'items'},
  ],
};

/// Descriptor for `TableInfoEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tableInfoEventDescriptor = $convert.base64Decode(
    'Cg5UYWJsZUluZm9FdmVudBIuCgVpdGVtcxgBIAMoCzIYLmdlbmVyYXRlZC5UYWJsZUluZm9JdG'
    'VtUgVpdGVtcw==');

@$core.Deprecated('Use fantasyParticipantsEventOutDescriptor instead')
const FantasyParticipantsEventOut$json = {
  '1': 'FantasyParticipantsEventOut',
  '2': [
    {'1': 'participants', '3': 1, '4': 3, '5': 11, '6': '.generated.User', '10': 'participants'},
  ],
};

/// Descriptor for `FantasyParticipantsEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fantasyParticipantsEventOutDescriptor = $convert.base64Decode(
    'ChtGYW50YXN5UGFydGljaXBhbnRzRXZlbnRPdXQSMwoMcGFydGljaXBhbnRzGAEgAygLMg8uZ2'
    'VuZXJhdGVkLlVzZXJSDHBhcnRpY2lwYW50cw==');

@$core.Deprecated('Use setFantasyParticipantEventDescriptor instead')
const SetFantasyParticipantEvent$json = {
  '1': 'SetFantasyParticipantEvent',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `SetFantasyParticipantEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setFantasyParticipantEventDescriptor = $convert.base64Decode(
    'ChpTZXRGYW50YXN5UGFydGljaXBhbnRFdmVudBIUCgVlbWFpbBgBIAEoCVIFZW1haWw=');

@$core.Deprecated('Use fantasyRatingRowDescriptor instead')
const FantasyRatingRow$json = {
  '1': 'FantasyRatingRow',
  '2': [
    {'1': 'nickname', '3': 1, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'predictions', '3': 2, '4': 3, '5': 11, '6': '.generated.FantasyPredictionItem', '10': 'predictions'},
    {'1': 'totalPoints', '3': 3, '4': 1, '5': 5, '10': 'totalPoints'},
    {'1': 'playerId', '3': 4, '4': 1, '5': 5, '10': 'playerId'},
  ],
};

/// Descriptor for `FantasyRatingRow`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fantasyRatingRowDescriptor = $convert.base64Decode(
    'ChBGYW50YXN5UmF0aW5nUm93EhoKCG5pY2tuYW1lGAEgASgJUghuaWNrbmFtZRJCCgtwcmVkaW'
    'N0aW9ucxgCIAMoCzIgLmdlbmVyYXRlZC5GYW50YXN5UHJlZGljdGlvbkl0ZW1SC3ByZWRpY3Rp'
    'b25zEiAKC3RvdGFsUG9pbnRzGAMgASgFUgt0b3RhbFBvaW50cxIaCghwbGF5ZXJJZBgEIAEoBV'
    'IIcGxheWVySWQ=');

@$core.Deprecated('Use fantasyPredictionItemDescriptor instead')
const FantasyPredictionItem$json = {
  '1': 'FantasyPredictionItem',
  '2': [
    {'1': 'gameNumber', '3': 1, '4': 1, '5': 5, '10': 'gameNumber'},
    {'1': 'prediction', '3': 2, '4': 1, '5': 14, '6': '.generated.GameWin', '9': 0, '10': 'prediction', '17': true},
    {'1': 'actualResult', '3': 3, '4': 1, '5': 14, '6': '.generated.GameWin', '9': 1, '10': 'actualResult', '17': true},
    {'1': 'points', '3': 4, '4': 1, '5': 5, '10': 'points'},
  ],
  '8': [
    {'1': '_prediction'},
    {'1': '_actualResult'},
  ],
};

/// Descriptor for `FantasyPredictionItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fantasyPredictionItemDescriptor = $convert.base64Decode(
    'ChVGYW50YXN5UHJlZGljdGlvbkl0ZW0SHgoKZ2FtZU51bWJlchgBIAEoBVIKZ2FtZU51bWJlch'
    'I3CgpwcmVkaWN0aW9uGAIgASgOMhIuZ2VuZXJhdGVkLkdhbWVXaW5IAFIKcHJlZGljdGlvbogB'
    'ARI7CgxhY3R1YWxSZXN1bHQYAyABKA4yEi5nZW5lcmF0ZWQuR2FtZVdpbkgBUgxhY3R1YWxSZX'
    'N1bHSIAQESFgoGcG9pbnRzGAQgASgFUgZwb2ludHNCDQoLX3ByZWRpY3Rpb25CDwoNX2FjdHVh'
    'bFJlc3VsdA==');

@$core.Deprecated('Use fantasyRatingEventOutDescriptor instead')
const FantasyRatingEventOut$json = {
  '1': 'FantasyRatingEventOut',
  '2': [
    {'1': 'rows', '3': 1, '4': 3, '5': 11, '6': '.generated.FantasyRatingRow', '10': 'rows'},
  ],
};

/// Descriptor for `FantasyRatingEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fantasyRatingEventOutDescriptor = $convert.base64Decode(
    'ChVGYW50YXN5UmF0aW5nRXZlbnRPdXQSLwoEcm93cxgBIAMoCzIbLmdlbmVyYXRlZC5GYW50YX'
    'N5UmF0aW5nUm93UgRyb3dz');

@$core.Deprecated('Use authEventDescriptor instead')
const AuthEvent$json = {
  '1': 'AuthEvent',
  '2': [
    {'1': 'deviceId', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'deviceId', '17': true},
    {'1': 'pushToken', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'pushToken', '17': true},
  ],
  '8': [
    {'1': '_deviceId'},
    {'1': '_pushToken'},
  ],
};

/// Descriptor for `AuthEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authEventDescriptor = $convert.base64Decode(
    'CglBdXRoRXZlbnQSHwoIZGV2aWNlSWQYASABKAlIAFIIZGV2aWNlSWSIAQESIQoJcHVzaFRva2'
    'VuGAIgASgJSAFSCXB1c2hUb2tlbogBAUILCglfZGV2aWNlSWRCDAoKX3B1c2hUb2tlbg==');

@$core.Deprecated('Use authEventOutDescriptor instead')
const AuthEventOut$json = {
  '1': 'AuthEventOut',
  '2': [
    {'1': 'userId', '3': 1, '4': 1, '5': 5, '10': 'userId'},
  ],
};

/// Descriptor for `AuthEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authEventOutDescriptor = $convert.base64Decode(
    'CgxBdXRoRXZlbnRPdXQSFgoGdXNlcklkGAEgASgFUgZ1c2VySWQ=');

@$core.Deprecated('Use setFantasyPredictionEventDescriptor instead')
const SetFantasyPredictionEvent$json = {
  '1': 'SetFantasyPredictionEvent',
  '2': [
    {'1': 'prediction', '3': 1, '4': 1, '5': 14, '6': '.generated.GameWin', '10': 'prediction'},
  ],
};

/// Descriptor for `SetFantasyPredictionEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setFantasyPredictionEventDescriptor = $convert.base64Decode(
    'ChlTZXRGYW50YXN5UHJlZGljdGlvbkV2ZW50EjIKCnByZWRpY3Rpb24YASABKA4yEi5nZW5lcm'
    'F0ZWQuR2FtZVdpblIKcHJlZGljdGlvbg==');

@$core.Deprecated('Use fantasyCurrentGameEventOutDescriptor instead')
const FantasyCurrentGameEventOut$json = {
  '1': 'FantasyCurrentGameEventOut',
  '2': [
    {'1': 'gameNumber', '3': 1, '4': 1, '5': 5, '10': 'gameNumber'},
    {'1': 'canPredict', '3': 2, '4': 1, '5': 8, '10': 'canPredict'},
    {'1': 'canParticipate', '3': 3, '4': 1, '5': 8, '10': 'canParticipate'},
  ],
};

/// Descriptor for `FantasyCurrentGameEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fantasyCurrentGameEventOutDescriptor = $convert.base64Decode(
    'ChpGYW50YXN5Q3VycmVudEdhbWVFdmVudE91dBIeCgpnYW1lTnVtYmVyGAEgASgFUgpnYW1lTn'
    'VtYmVyEh4KCmNhblByZWRpY3QYAiABKAhSCmNhblByZWRpY3QSJgoOY2FuUGFydGljaXBhdGUY'
    'AyABKAhSDmNhblBhcnRpY2lwYXRl');

@$core.Deprecated('Use forgotPasswordEventDescriptor instead')
const ForgotPasswordEvent$json = {
  '1': 'ForgotPasswordEvent',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `ForgotPasswordEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forgotPasswordEventDescriptor = $convert.base64Decode(
    'ChNGb3Jnb3RQYXNzd29yZEV2ZW50EhQKBWVtYWlsGAEgASgJUgVlbWFpbA==');

@$core.Deprecated('Use forgotPasswordEventOutDescriptor instead')
const ForgotPasswordEventOut$json = {
  '1': 'ForgotPasswordEventOut',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 14, '6': '.generated.ForgotPasswordEventOut.Error', '10': 'error'},
  ],
  '4': [ForgotPasswordEventOut_Error$json],
};

@$core.Deprecated('Use forgotPasswordEventOutDescriptor instead')
const ForgotPasswordEventOut_Error$json = {
  '1': 'Error',
  '2': [
    {'1': 'noError', '2': 0},
    {'1': 'emailNotFound', '2': 1},
  ],
};

/// Descriptor for `ForgotPasswordEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forgotPasswordEventOutDescriptor = $convert.base64Decode(
    'ChZGb3Jnb3RQYXNzd29yZEV2ZW50T3V0Ej0KBWVycm9yGAEgASgOMicuZ2VuZXJhdGVkLkZvcm'
    'dvdFBhc3N3b3JkRXZlbnRPdXQuRXJyb3JSBWVycm9yIicKBUVycm9yEgsKB25vRXJyb3IQABIR'
    'Cg1lbWFpbE5vdEZvdW5kEAE=');

@$core.Deprecated('Use resetPasswordEventDescriptor instead')
const ResetPasswordEvent$json = {
  '1': 'ResetPasswordEvent',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'newPassword', '3': 2, '4': 1, '5': 9, '10': 'newPassword'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `ResetPasswordEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasswordEventDescriptor = $convert.base64Decode(
    'ChJSZXNldFBhc3N3b3JkRXZlbnQSFAoFdG9rZW4YASABKAlSBXRva2VuEiAKC25ld1Bhc3N3b3'
    'JkGAIgASgJUgtuZXdQYXNzd29yZBIUCgVlbWFpbBgDIAEoCVIFZW1haWw=');

@$core.Deprecated('Use resetPasswordEventOutDescriptor instead')
const ResetPasswordEventOut$json = {
  '1': 'ResetPasswordEventOut',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 14, '6': '.generated.ResetPasswordEventOut.Error', '10': 'error'},
  ],
  '4': [ResetPasswordEventOut_Error$json],
};

@$core.Deprecated('Use resetPasswordEventOutDescriptor instead')
const ResetPasswordEventOut_Error$json = {
  '1': 'Error',
  '2': [
    {'1': 'noError', '2': 0},
    {'1': 'invalidToken', '2': 1},
    {'1': 'weakPassword', '2': 2},
  ],
};

/// Descriptor for `ResetPasswordEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasswordEventOutDescriptor = $convert.base64Decode(
    'ChVSZXNldFBhc3N3b3JkRXZlbnRPdXQSPAoFZXJyb3IYASABKA4yJi5nZW5lcmF0ZWQuUmVzZX'
    'RQYXNzd29yZEV2ZW50T3V0LkVycm9yUgVlcnJvciI4CgVFcnJvchILCgdub0Vycm9yEAASEAoM'
    'aW52YWxpZFRva2VuEAESEAoMd2Vha1Bhc3N3b3JkEAI=');

