///
//  Generated code. Do not modify.
//  source: seating-generator-proto/mafia.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use bestMoveDescriptor instead')
const BestMove$json = const {
  '1': 'BestMove',
  '2': const [
    const {'1': 'miss', '2': 0},
    const {'1': 'half', '2': 1},
    const {'1': 'full', '2': 2},
    const {'1': 'one', '2': 3},
  ],
};

/// Descriptor for `BestMove`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List bestMoveDescriptor = $convert.base64Decode('CghCZXN0TW92ZRIICgRtaXNzEAASCAoEaGFsZhABEggKBGZ1bGwQAhIHCgNvbmUQAw==');
@$core.Deprecated('Use gameWinDescriptor instead')
const GameWin$json = const {
  '1': 'GameWin',
  '2': const [
    const {'1': 'city', '2': 0},
    const {'1': 'mafia', '2': 1},
    const {'1': 'draw', '2': 2},
  ],
};

/// Descriptor for `GameWin`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List gameWinDescriptor = $convert.base64Decode('CgdHYW1lV2luEggKBGNpdHkQABIJCgVtYWZpYRABEggKBGRyYXcQAg==');
@$core.Deprecated('Use playerRoleDescriptor instead')
const PlayerRole$json = const {
  '1': 'PlayerRole',
  '2': const [
    const {'1': 'citizen', '2': 0},
    const {'1': 'maf', '2': 1},
    const {'1': 'don', '2': 2},
    const {'1': 'sheriff', '2': 3},
  ],
};

/// Descriptor for `PlayerRole`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List playerRoleDescriptor = $convert.base64Decode('CgpQbGF5ZXJSb2xlEgsKB2NpdGl6ZW4QABIHCgNtYWYQARIHCgNkb24QAhILCgdzaGVyaWZmEAM=');
@$core.Deprecated('Use playerStatusDescriptor instead')
const PlayerStatus$json = const {
  '1': 'PlayerStatus',
  '2': const [
    const {'1': 'alive', '2': 0},
    const {'1': 'voted', '2': 1},
    const {'1': 'deleted', '2': 2},
    const {'1': 'killed', '2': 3},
  ],
};

/// Descriptor for `PlayerStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List playerStatusDescriptor = $convert.base64Decode('CgxQbGF5ZXJTdGF0dXMSCQoFYWxpdmUQABIJCgV2b3RlZBABEgsKB2RlbGV0ZWQQAhIKCgZraWxsZWQQAw==');
@$core.Deprecated('Use loginEventDescriptor instead')
const LoginEvent$json = const {
  '1': 'LoginEvent',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `LoginEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginEventDescriptor = $convert.base64Decode('CgpMb2dpbkV2ZW50EhQKBWVtYWlsGAEgASgJUgVlbWFpbBIaCghwYXNzd29yZBgCIAEoCVIIcGFzc3dvcmQ=');
@$core.Deprecated('Use tableSeatingDescriptor instead')
const TableSeating$json = const {
  '1': 'TableSeating',
  '2': const [
    const {'1': 'nickname', '3': 1, '4': 3, '5': 9, '10': 'nickname'},
    const {'1': 'referee', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'referee', '17': true},
    const {'1': 'table', '3': 3, '4': 1, '5': 5, '10': 'table'},
  ],
  '8': const [
    const {'1': '_referee'},
  ],
};

/// Descriptor for `TableSeating`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tableSeatingDescriptor = $convert.base64Decode('CgxUYWJsZVNlYXRpbmcSGgoIbmlja25hbWUYASADKAlSCG5pY2tuYW1lEh0KB3JlZmVyZWUYAiABKAlIAFIHcmVmZXJlZYgBARIUCgV0YWJsZRgDIAEoBVIFdGFibGVCCgoIX3JlZmVyZWU=');
@$core.Deprecated('Use tableSeatingResultDescriptor instead')
const TableSeatingResult$json = const {
  '1': 'TableSeatingResult',
  '2': const [
    const {'1': 'role', '3': 1, '4': 3, '5': 14, '6': '.generated.PlayerRole', '10': 'role'},
    const {'1': 'score', '3': 2, '4': 3, '5': 1, '10': 'score'},
    const {'1': 'died', '3': 3, '4': 1, '5': 5, '9': 0, '10': 'died', '17': true},
    const {'1': 'win', '3': 4, '4': 1, '5': 14, '6': '.generated.GameWin', '10': 'win'},
    const {'1': 'bestMove', '3': 5, '4': 1, '5': 14, '6': '.generated.BestMove', '10': 'bestMove'},
    const {'1': 'addScore', '3': 6, '4': 3, '5': 1, '10': 'addScore'},
  ],
  '8': const [
    const {'1': '_died'},
  ],
};

/// Descriptor for `TableSeatingResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tableSeatingResultDescriptor = $convert.base64Decode('ChJUYWJsZVNlYXRpbmdSZXN1bHQSKQoEcm9sZRgBIAMoDjIVLmdlbmVyYXRlZC5QbGF5ZXJSb2xlUgRyb2xlEhQKBXNjb3JlGAIgAygBUgVzY29yZRIXCgRkaWVkGAMgASgFSABSBGRpZWSIAQESJAoDd2luGAQgASgOMhIuZ2VuZXJhdGVkLkdhbWVXaW5SA3dpbhIvCghiZXN0TW92ZRgFIAEoDjITLmdlbmVyYXRlZC5CZXN0TW92ZVIIYmVzdE1vdmUSGgoIYWRkU2NvcmUYBiADKAFSCGFkZFNjb3JlQgcKBV9kaWVk');
@$core.Deprecated('Use tableSeatingItemDescriptor instead')
const TableSeatingItem$json = const {
  '1': 'TableSeatingItem',
  '2': const [
    const {'1': 'gameId', '3': 1, '4': 1, '5': 5, '10': 'gameId'},
    const {'1': 'seating', '3': 2, '4': 1, '5': 11, '6': '.generated.TableSeating', '10': 'seating'},
    const {'1': 'result', '3': 3, '4': 1, '5': 11, '6': '.generated.TableSeatingResult', '9': 0, '10': 'result', '17': true},
    const {'1': 'game', '3': 4, '4': 1, '5': 5, '10': 'game'},
    const {'1': 'table', '3': 5, '4': 1, '5': 5, '10': 'table'},
  ],
  '8': const [
    const {'1': '_result'},
  ],
};

/// Descriptor for `TableSeatingItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tableSeatingItemDescriptor = $convert.base64Decode('ChBUYWJsZVNlYXRpbmdJdGVtEhYKBmdhbWVJZBgBIAEoBVIGZ2FtZUlkEjEKB3NlYXRpbmcYAiABKAsyFy5nZW5lcmF0ZWQuVGFibGVTZWF0aW5nUgdzZWF0aW5nEjoKBnJlc3VsdBgDIAEoCzIdLmdlbmVyYXRlZC5UYWJsZVNlYXRpbmdSZXN1bHRIAFIGcmVzdWx0iAEBEhIKBGdhbWUYBCABKAVSBGdhbWUSFAoFdGFibGUYBSABKAVSBXRhYmxlQgkKB19yZXN1bHQ=');
@$core.Deprecated('Use seatingEventOutDescriptor instead')
const SeatingEventOut$json = const {
  '1': 'SeatingEventOut',
  '2': const [
    const {'1': 'item', '3': 1, '4': 3, '5': 11, '6': '.generated.TableSeatingItem', '10': 'item'},
  ],
};

/// Descriptor for `SeatingEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List seatingEventOutDescriptor = $convert.base64Decode('Cg9TZWF0aW5nRXZlbnRPdXQSLwoEaXRlbRgBIAMoCzIbLmdlbmVyYXRlZC5UYWJsZVNlYXRpbmdJdGVtUgRpdGVt');
@$core.Deprecated('Use loginEventOutDescriptor instead')
const LoginEventOut$json = const {
  '1': 'LoginEventOut',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'recoveryToken', '3': 2, '4': 1, '5': 9, '10': 'recoveryToken'},
    const {'1': 'error', '3': 3, '4': 1, '5': 14, '6': '.generated.LoginEventOut.Error', '10': 'error'},
    const {'1': 'id', '3': 4, '4': 1, '5': 5, '9': 0, '10': 'id', '17': true},
  ],
  '4': const [LoginEventOut_Error$json],
  '8': const [
    const {'1': '_id'},
  ],
};

@$core.Deprecated('Use loginEventOutDescriptor instead')
const LoginEventOut_Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'noError', '2': 0},
    const {'1': 'needVerification', '2': 1},
    const {'1': 'invalidCredentials', '2': 2},
  ],
};

/// Descriptor for `LoginEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginEventOutDescriptor = $convert.base64Decode('Cg1Mb2dpbkV2ZW50T3V0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIkCg1yZWNvdmVyeVRva2VuGAIgASgJUg1yZWNvdmVyeVRva2VuEjQKBWVycm9yGAMgASgOMh4uZ2VuZXJhdGVkLkxvZ2luRXZlbnRPdXQuRXJyb3JSBWVycm9yEhMKAmlkGAQgASgFSABSAmlkiAEBIkIKBUVycm9yEgsKB25vRXJyb3IQABIUChBuZWVkVmVyaWZpY2F0aW9uEAESFgoSaW52YWxpZENyZWRlbnRpYWxzEAJCBQoDX2lk');
@$core.Deprecated('Use changeSeatingContentDescriptor instead')
const ChangeSeatingContent$json = const {
  '1': 'ChangeSeatingContent',
  '2': const [
    const {'1': 'player', '3': 1, '4': 1, '5': 5, '9': 0, '10': 'player', '17': true},
    const {'1': 'imageUrl', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'imageUrl', '17': true},
    const {'1': 'role', '3': 3, '4': 1, '5': 14, '6': '.generated.PlayerRole', '9': 2, '10': 'role', '17': true},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.generated.PlayerStatus', '9': 3, '10': 'status', '17': true},
    const {'1': 'selectedGame', '3': 5, '4': 1, '5': 5, '9': 4, '10': 'selectedGame', '17': true},
  ],
  '8': const [
    const {'1': '_player'},
    const {'1': '_imageUrl'},
    const {'1': '_role'},
    const {'1': '_status'},
    const {'1': '_selectedGame'},
  ],
};

/// Descriptor for `ChangeSeatingContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changeSeatingContentDescriptor = $convert.base64Decode('ChRDaGFuZ2VTZWF0aW5nQ29udGVudBIbCgZwbGF5ZXIYASABKAVIAFIGcGxheWVyiAEBEh8KCGltYWdlVXJsGAIgASgJSAFSCGltYWdlVXJsiAEBEi4KBHJvbGUYAyABKA4yFS5nZW5lcmF0ZWQuUGxheWVyUm9sZUgCUgRyb2xliAEBEjQKBnN0YXR1cxgEIAEoDjIXLmdlbmVyYXRlZC5QbGF5ZXJTdGF0dXNIA1IGc3RhdHVziAEBEicKDHNlbGVjdGVkR2FtZRgFIAEoBUgEUgxzZWxlY3RlZEdhbWWIAQFCCQoHX3BsYXllckILCglfaW1hZ2VVcmxCBwoFX3JvbGVCCQoHX3N0YXR1c0IPCg1fc2VsZWN0ZWRHYW1l');
@$core.Deprecated('Use clubDescriptor instead')
const Club$json = const {
  '1': 'Club',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'description', '17': true},
    const {'1': 'imageUrl', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'imageUrl', '17': true},
    const {'1': 'groupLink', '3': 5, '4': 1, '5': 9, '9': 2, '10': 'groupLink', '17': true},
    const {'1': 'city', '3': 6, '4': 1, '5': 9, '9': 3, '10': 'city', '17': true},
    const {'1': 'billedFor', '3': 7, '4': 1, '5': 9, '9': 4, '10': 'billedFor', '17': true},
  ],
  '8': const [
    const {'1': '_description'},
    const {'1': '_imageUrl'},
    const {'1': '_groupLink'},
    const {'1': '_city'},
    const {'1': '_billedFor'},
  ],
};

/// Descriptor for `Club`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clubDescriptor = $convert.base64Decode('CgRDbHViEg4KAmlkGAEgASgFUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiUKC2Rlc2NyaXB0aW9uGAMgASgJSABSC2Rlc2NyaXB0aW9uiAEBEh8KCGltYWdlVXJsGAQgASgJSAFSCGltYWdlVXJsiAEBEiEKCWdyb3VwTGluaxgFIAEoCUgCUglncm91cExpbmuIAQESFwoEY2l0eRgGIAEoCUgDUgRjaXR5iAEBEiEKCWJpbGxlZEZvchgHIAEoCUgEUgliaWxsZWRGb3KIAQFCDgoMX2Rlc2NyaXB0aW9uQgsKCV9pbWFnZVVybEIMCgpfZ3JvdXBMaW5rQgcKBV9jaXR5QgwKCl9iaWxsZWRGb3I=');
@$core.Deprecated('Use clubRatingEventOutDescriptor instead')
const ClubRatingEventOut$json = const {
  '1': 'ClubRatingEventOut',
  '2': const [
    const {'1': 'row', '3': 1, '4': 3, '5': 11, '6': '.generated.ClubRatingRow', '10': 'row'},
    const {'1': 'clubName', '3': 2, '4': 1, '5': 9, '10': 'clubName'},
    const {'1': 'games', '3': 3, '4': 1, '5': 5, '10': 'games'},
    const {'1': 'mafiaWins', '3': 4, '4': 1, '5': 5, '10': 'mafiaWins'},
    const {'1': 'citizenWins', '3': 5, '4': 1, '5': 5, '10': 'citizenWins'},
  ],
};

/// Descriptor for `ClubRatingEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clubRatingEventOutDescriptor = $convert.base64Decode('ChJDbHViUmF0aW5nRXZlbnRPdXQSKgoDcm93GAEgAygLMhguZ2VuZXJhdGVkLkNsdWJSYXRpbmdSb3dSA3JvdxIaCghjbHViTmFtZRgCIAEoCVIIY2x1Yk5hbWUSFAoFZ2FtZXMYAyABKAVSBWdhbWVzEhwKCW1hZmlhV2lucxgEIAEoBVIJbWFmaWFXaW5zEiAKC2NpdGl6ZW5XaW5zGAUgASgFUgtjaXRpemVuV2lucw==');
@$core.Deprecated('Use clubRatingRowDescriptor instead')
const ClubRatingRow$json = const {
  '1': 'ClubRatingRow',
  '2': const [
    const {'1': 'nickname', '3': 1, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'score', '3': 2, '4': 1, '5': 1, '10': 'score'},
    const {'1': 'addScore', '3': 3, '4': 1, '5': 1, '10': 'addScore'},
    const {'1': 'firstDie', '3': 4, '4': 1, '5': 5, '10': 'firstDie'},
    const {'1': 'donWins', '3': 5, '4': 1, '5': 5, '10': 'donWins'},
    const {'1': 'sheriffWins', '3': 6, '4': 1, '5': 5, '10': 'sheriffWins'},
    const {'1': 'item', '3': 7, '4': 3, '5': 11, '6': '.generated.ClubRatingRow.GameItem', '10': 'item'},
    const {'1': 'wins', '3': 8, '4': 1, '5': 5, '10': 'wins'},
    const {'1': 'ci', '3': 9, '4': 1, '5': 5, '10': 'ci'},
    const {'1': 'totalGames', '3': 10, '4': 1, '5': 5, '10': 'totalGames'},
    const {'1': 'citizenGames', '3': 11, '4': 1, '5': 5, '10': 'citizenGames'},
    const {'1': 'donGames', '3': 12, '4': 1, '5': 5, '10': 'donGames'},
    const {'1': 'sheriffGames', '3': 13, '4': 1, '5': 5, '10': 'sheriffGames'},
    const {'1': 'mafiaGames', '3': 14, '4': 1, '5': 5, '10': 'mafiaGames'},
    const {'1': 'mafiaWins', '3': 15, '4': 1, '5': 5, '10': 'mafiaWins'},
    const {'1': 'citizenWins', '3': 16, '4': 1, '5': 5, '10': 'citizenWins'},
    const {'1': 'citizenAddScore', '3': 17, '4': 1, '5': 1, '10': 'citizenAddScore'},
    const {'1': 'mafiaAddScore', '3': 18, '4': 1, '5': 1, '10': 'mafiaAddScore'},
    const {'1': 'donAddScore', '3': 19, '4': 1, '5': 1, '10': 'donAddScore'},
    const {'1': 'sheriffAddScore', '3': 20, '4': 1, '5': 1, '10': 'sheriffAddScore'},
    const {'1': 'citizenScore', '3': 21, '4': 1, '5': 1, '10': 'citizenScore'},
    const {'1': 'mafiaScore', '3': 22, '4': 1, '5': 1, '10': 'mafiaScore'},
    const {'1': 'donScore', '3': 23, '4': 1, '5': 1, '10': 'donScore'},
    const {'1': 'sheriffScore', '3': 24, '4': 1, '5': 1, '10': 'sheriffScore'},
    const {'1': 'playerId', '3': 25, '4': 1, '5': 5, '10': 'playerId'},
  ],
  '3': const [ClubRatingRow_GameItem$json],
};

@$core.Deprecated('Use clubRatingRowDescriptor instead')
const ClubRatingRow_GameItem$json = const {
  '1': 'GameItem',
  '2': const [
    const {'1': 'gameId', '3': 1, '4': 1, '5': 5, '10': 'gameId'},
    const {'1': 'score', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'score', '17': true},
  ],
  '8': const [
    const {'1': '_score'},
  ],
};

/// Descriptor for `ClubRatingRow`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clubRatingRowDescriptor = $convert.base64Decode('Cg1DbHViUmF0aW5nUm93EhoKCG5pY2tuYW1lGAEgASgJUghuaWNrbmFtZRIUCgVzY29yZRgCIAEoAVIFc2NvcmUSGgoIYWRkU2NvcmUYAyABKAFSCGFkZFNjb3JlEhoKCGZpcnN0RGllGAQgASgFUghmaXJzdERpZRIYCgdkb25XaW5zGAUgASgFUgdkb25XaW5zEiAKC3NoZXJpZmZXaW5zGAYgASgFUgtzaGVyaWZmV2lucxI1CgRpdGVtGAcgAygLMiEuZ2VuZXJhdGVkLkNsdWJSYXRpbmdSb3cuR2FtZUl0ZW1SBGl0ZW0SEgoEd2lucxgIIAEoBVIEd2lucxIOCgJjaRgJIAEoBVICY2kSHgoKdG90YWxHYW1lcxgKIAEoBVIKdG90YWxHYW1lcxIiCgxjaXRpemVuR2FtZXMYCyABKAVSDGNpdGl6ZW5HYW1lcxIaCghkb25HYW1lcxgMIAEoBVIIZG9uR2FtZXMSIgoMc2hlcmlmZkdhbWVzGA0gASgFUgxzaGVyaWZmR2FtZXMSHgoKbWFmaWFHYW1lcxgOIAEoBVIKbWFmaWFHYW1lcxIcCgltYWZpYVdpbnMYDyABKAVSCW1hZmlhV2lucxIgCgtjaXRpemVuV2lucxgQIAEoBVILY2l0aXplbldpbnMSKAoPY2l0aXplbkFkZFNjb3JlGBEgASgBUg9jaXRpemVuQWRkU2NvcmUSJAoNbWFmaWFBZGRTY29yZRgSIAEoAVINbWFmaWFBZGRTY29yZRIgCgtkb25BZGRTY29yZRgTIAEoAVILZG9uQWRkU2NvcmUSKAoPc2hlcmlmZkFkZFNjb3JlGBQgASgBUg9zaGVyaWZmQWRkU2NvcmUSIgoMY2l0aXplblNjb3JlGBUgASgBUgxjaXRpemVuU2NvcmUSHgoKbWFmaWFTY29yZRgWIAEoAVIKbWFmaWFTY29yZRIaCghkb25TY29yZRgXIAEoAVIIZG9uU2NvcmUSIgoMc2hlcmlmZlNjb3JlGBggASgBUgxzaGVyaWZmU2NvcmUSGgoIcGxheWVySWQYGSABKAVSCHBsYXllcklkGkcKCEdhbWVJdGVtEhYKBmdhbWVJZBgBIAEoBVIGZ2FtZUlkEhkKBXNjb3JlGAIgASgBSABSBXNjb3JliAEBQggKBl9zY29yZQ==');
@$core.Deprecated('Use addGameEventOutDescriptor instead')
const AddGameEventOut$json = const {
  '1': 'AddGameEventOut',
  '2': const [
    const {'1': 'gameId', '3': 1, '4': 1, '5': 5, '10': 'gameId'},
  ],
};

/// Descriptor for `AddGameEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addGameEventOutDescriptor = $convert.base64Decode('Cg9BZGRHYW1lRXZlbnRPdXQSFgoGZ2FtZUlkGAEgASgFUgZnYW1lSWQ=');
@$core.Deprecated('Use ciSchemeDescriptor instead')
const CiScheme$json = const {
  '1': 'CiScheme',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `CiScheme`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ciSchemeDescriptor = $convert.base64Decode('CghDaVNjaGVtZRIOCgJpZBgBIAEoBVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use availableCiEventOutDescriptor instead')
const AvailableCiEventOut$json = const {
  '1': 'AvailableCiEventOut',
  '2': const [
    const {'1': 'schemes', '3': 1, '4': 3, '5': 11, '6': '.generated.CiScheme', '10': 'schemes'},
  ],
};

/// Descriptor for `AvailableCiEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List availableCiEventOutDescriptor = $convert.base64Decode('ChNBdmFpbGFibGVDaUV2ZW50T3V0Ei0KB3NjaGVtZXMYASADKAsyEy5nZW5lcmF0ZWQuQ2lTY2hlbWVSB3NjaGVtZXM=');
@$core.Deprecated('Use setFinalPlayersEventDescriptor instead')
const SetFinalPlayersEvent$json = const {
  '1': 'SetFinalPlayersEvent',
  '2': const [
    const {'1': 'id', '3': 1, '4': 3, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `SetFinalPlayersEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setFinalPlayersEventDescriptor = $convert.base64Decode('ChRTZXRGaW5hbFBsYXllcnNFdmVudBIOCgJpZBgBIAMoBVICaWQ=');
@$core.Deprecated('Use clubGameResultDescriptor instead')
const ClubGameResult$json = const {
  '1': 'ClubGameResult',
  '2': const [
    const {'1': 'addScore', '3': 1, '4': 3, '5': 5, '10': 'addScore'},
    const {'1': 'players', '3': 2, '4': 3, '5': 5, '10': 'players'},
    const {'1': 'win', '3': 3, '4': 1, '5': 14, '6': '.generated.GameWin', '9': 0, '10': 'win', '17': true},
    const {'1': 'firstDie', '3': 4, '4': 1, '5': 5, '9': 1, '10': 'firstDie', '17': true},
    const {'1': 'bestMove', '3': 5, '4': 1, '5': 14, '6': '.generated.BestMove', '9': 2, '10': 'bestMove', '17': true},
    const {'1': 'date', '3': 6, '4': 1, '5': 9, '9': 3, '10': 'date', '17': true},
    const {'1': 'referee', '3': 7, '4': 1, '5': 5, '10': 'referee'},
    const {'1': 'mafia1', '3': 8, '4': 1, '5': 5, '9': 4, '10': 'mafia1', '17': true},
    const {'1': 'mafia2', '3': 9, '4': 1, '5': 5, '9': 5, '10': 'mafia2', '17': true},
    const {'1': 'don', '3': 10, '4': 1, '5': 5, '9': 6, '10': 'don', '17': true},
    const {'1': 'sheriff', '3': 11, '4': 1, '5': 5, '9': 7, '10': 'sheriff', '17': true},
    const {'1': 'ciId', '3': 12, '4': 1, '5': 5, '9': 8, '10': 'ciId', '17': true},
  ],
  '8': const [
    const {'1': '_win'},
    const {'1': '_firstDie'},
    const {'1': '_bestMove'},
    const {'1': '_date'},
    const {'1': '_mafia1'},
    const {'1': '_mafia2'},
    const {'1': '_don'},
    const {'1': '_sheriff'},
    const {'1': '_ciId'},
  ],
};

/// Descriptor for `ClubGameResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clubGameResultDescriptor = $convert.base64Decode('Cg5DbHViR2FtZVJlc3VsdBIaCghhZGRTY29yZRgBIAMoBVIIYWRkU2NvcmUSGAoHcGxheWVycxgCIAMoBVIHcGxheWVycxIpCgN3aW4YAyABKA4yEi5nZW5lcmF0ZWQuR2FtZVdpbkgAUgN3aW6IAQESHwoIZmlyc3REaWUYBCABKAVIAVIIZmlyc3REaWWIAQESNAoIYmVzdE1vdmUYBSABKA4yEy5nZW5lcmF0ZWQuQmVzdE1vdmVIAlIIYmVzdE1vdmWIAQESFwoEZGF0ZRgGIAEoCUgDUgRkYXRliAEBEhgKB3JlZmVyZWUYByABKAVSB3JlZmVyZWUSGwoGbWFmaWExGAggASgFSARSBm1hZmlhMYgBARIbCgZtYWZpYTIYCSABKAVIBVIGbWFmaWEyiAEBEhUKA2RvbhgKIAEoBUgGUgNkb26IAQESHQoHc2hlcmlmZhgLIAEoBUgHUgdzaGVyaWZmiAEBEhcKBGNpSWQYDCABKAVICFIEY2lJZIgBAUIGCgRfd2luQgsKCV9maXJzdERpZUILCglfYmVzdE1vdmVCBwoFX2RhdGVCCQoHX21hZmlhMUIJCgdfbWFmaWEyQgYKBF9kb25CCgoIX3NoZXJpZmZCBwoFX2NpSWQ=');
@$core.Deprecated('Use clubsEventOutDescriptor instead')
const ClubsEventOut$json = const {
  '1': 'ClubsEventOut',
  '2': const [
    const {'1': 'club', '3': 1, '4': 3, '5': 11, '6': '.generated.Club', '10': 'club'},
  ],
};

/// Descriptor for `ClubsEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clubsEventOutDescriptor = $convert.base64Decode('Cg1DbHVic0V2ZW50T3V0EiMKBGNsdWIYASADKAsyDy5nZW5lcmF0ZWQuQ2x1YlIEY2x1Yg==');
@$core.Deprecated('Use seatingContentDescriptor instead')
const SeatingContent$json = const {
  '1': 'SeatingContent',
  '2': const [
    const {'1': 'roles', '3': 1, '4': 3, '5': 14, '6': '.generated.PlayerRole', '10': 'roles'},
    const {'1': 'status', '3': 2, '4': 3, '5': 14, '6': '.generated.PlayerStatus', '10': 'status'},
    const {'1': 'images', '3': 3, '4': 3, '5': 9, '10': 'images'},
    const {'1': 'names', '3': 4, '4': 3, '5': 9, '10': 'names'},
    const {'1': 'game', '3': 5, '4': 1, '5': 5, '10': 'game'},
    const {'1': 'totalGames', '3': 6, '4': 1, '5': 5, '10': 'totalGames'},
  ],
};

/// Descriptor for `SeatingContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List seatingContentDescriptor = $convert.base64Decode('Cg5TZWF0aW5nQ29udGVudBIrCgVyb2xlcxgBIAMoDjIVLmdlbmVyYXRlZC5QbGF5ZXJSb2xlUgVyb2xlcxIvCgZzdGF0dXMYAiADKA4yFy5nZW5lcmF0ZWQuUGxheWVyU3RhdHVzUgZzdGF0dXMSFgoGaW1hZ2VzGAMgAygJUgZpbWFnZXMSFAoFbmFtZXMYBCADKAlSBW5hbWVzEhIKBGdhbWUYBSABKAVSBGdhbWUSHgoKdG90YWxHYW1lcxgGIAEoBVIKdG90YWxHYW1lcw==');
@$core.Deprecated('Use loginByTokenEventDescriptor instead')
const LoginByTokenEvent$json = const {
  '1': 'LoginByTokenEvent',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `LoginByTokenEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginByTokenEventDescriptor = $convert.base64Decode('ChFMb2dpbkJ5VG9rZW5FdmVudBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4=');
@$core.Deprecated('Use loginByTokenEventOutDescriptor instead')
const LoginByTokenEventOut$json = const {
  '1': 'LoginByTokenEventOut',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'recoveryToken', '3': 2, '4': 1, '5': 9, '10': 'recoveryToken'},
    const {'1': 'error', '3': 3, '4': 1, '5': 14, '6': '.generated.LoginByTokenEventOut.Error', '10': 'error'},
  ],
  '4': const [LoginByTokenEventOut_Error$json],
};

@$core.Deprecated('Use loginByTokenEventOutDescriptor instead')
const LoginByTokenEventOut_Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'noError', '2': 0},
    const {'1': 'needVerification', '2': 1},
    const {'1': 'invalidCredentials', '2': 2},
  ],
};

/// Descriptor for `LoginByTokenEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginByTokenEventOutDescriptor = $convert.base64Decode('ChRMb2dpbkJ5VG9rZW5FdmVudE91dBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SJAoNcmVjb3ZlcnlUb2tlbhgCIAEoCVINcmVjb3ZlcnlUb2tlbhI7CgVlcnJvchgDIAEoDjIlLmdlbmVyYXRlZC5Mb2dpbkJ5VG9rZW5FdmVudE91dC5FcnJvclIFZXJyb3IiQgoFRXJyb3ISCwoHbm9FcnJvchAAEhQKEG5lZWRWZXJpZmljYXRpb24QARIWChJpbnZhbGlkQ3JlZGVudGlhbHMQAg==');
@$core.Deprecated('Use tournamentDescriptionDescriptor instead')
const TournamentDescription$json = const {
  '1': 'TournamentDescription',
  '2': const [
    const {'1': 'gomafiaUrl', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'gomafiaUrl', '17': true},
    const {'1': 'vkGroupUrl', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'vkGroupUrl', '17': true},
    const {'1': 'vkOwnerUrl', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'vkOwnerUrl', '17': true},
  ],
  '8': const [
    const {'1': '_gomafiaUrl'},
    const {'1': '_vkGroupUrl'},
    const {'1': '_vkOwnerUrl'},
  ],
};

/// Descriptor for `TournamentDescription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tournamentDescriptionDescriptor = $convert.base64Decode('ChVUb3VybmFtZW50RGVzY3JpcHRpb24SIwoKZ29tYWZpYVVybBgBIAEoCUgAUgpnb21hZmlhVXJsiAEBEiMKCnZrR3JvdXBVcmwYAiABKAlIAVIKdmtHcm91cFVybIgBARIjCgp2a093bmVyVXJsGAMgASgJSAJSCnZrT3duZXJVcmyIAQFCDQoLX2dvbWFmaWFVcmxCDQoLX3ZrR3JvdXBVcmxCDQoLX3ZrT3duZXJVcmw=');
@$core.Deprecated('Use signUpEventDescriptor instead')
const SignUpEvent$json = const {
  '1': 'SignUpEvent',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `SignUpEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signUpEventDescriptor = $convert.base64Decode('CgtTaWduVXBFdmVudBIUCgVlbWFpbBgBIAEoCVIFZW1haWwSGgoIcGFzc3dvcmQYAiABKAlSCHBhc3N3b3Jk');
@$core.Deprecated('Use signUpEventOutDescriptor instead')
const SignUpEventOut$json = const {
  '1': 'SignUpEventOut',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'recoveryToken', '3': 2, '4': 1, '5': 9, '10': 'recoveryToken'},
    const {'1': 'error', '3': 3, '4': 1, '5': 14, '6': '.generated.SignUpEventOut.Error', '10': 'error'},
    const {'1': 'id', '3': 4, '4': 1, '5': 5, '10': 'id'},
  ],
  '4': const [SignUpEventOut_Error$json],
};

@$core.Deprecated('Use signUpEventOutDescriptor instead')
const SignUpEventOut_Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'noError', '2': 0},
    const {'1': 'emailExist', '2': 1},
    const {'1': 'weakPassword', '2': 2},
    const {'1': 'needVerification', '2': 4},
  ],
};

/// Descriptor for `SignUpEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signUpEventOutDescriptor = $convert.base64Decode('Cg5TaWduVXBFdmVudE91dBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SJAoNcmVjb3ZlcnlUb2tlbhgCIAEoCVINcmVjb3ZlcnlUb2tlbhI1CgVlcnJvchgDIAEoDjIfLmdlbmVyYXRlZC5TaWduVXBFdmVudE91dC5FcnJvclIFZXJyb3ISDgoCaWQYBCABKAVSAmlkIkwKBUVycm9yEgsKB25vRXJyb3IQABIOCgplbWFpbEV4aXN0EAESEAoMd2Vha1Bhc3N3b3JkEAISFAoQbmVlZFZlcmlmaWNhdGlvbhAE');
@$core.Deprecated('Use emailVerificationEventDescriptor instead')
const EmailVerificationEvent$json = const {
  '1': 'EmailVerificationEvent',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `EmailVerificationEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailVerificationEventDescriptor = $convert.base64Decode('ChZFbWFpbFZlcmlmaWNhdGlvbkV2ZW50Eg4KAmlkGAEgASgFUgJpZBIUCgV0b2tlbhgCIAEoCVIFdG9rZW4=');
@$core.Deprecated('Use createTournamentEventDescriptor instead')
const CreateTournamentEvent$json = const {
  '1': 'CreateTournamentEvent',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'dateStart', '3': 2, '4': 1, '5': 9, '10': 'dateStart'},
    const {'1': 'dateEnd', '3': 3, '4': 1, '5': 9, '10': 'dateEnd'},
  ],
};

/// Descriptor for `CreateTournamentEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTournamentEventDescriptor = $convert.base64Decode('ChVDcmVhdGVUb3VybmFtZW50RXZlbnQSEgoEbmFtZRgBIAEoCVIEbmFtZRIcCglkYXRlU3RhcnQYAiABKAlSCWRhdGVTdGFydBIYCgdkYXRlRW5kGAMgASgJUgdkYXRlRW5k');
@$core.Deprecated('Use createTournamentEventOutDescriptor instead')
const CreateTournamentEventOut$json = const {
  '1': 'CreateTournamentEventOut',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `CreateTournamentEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTournamentEventOutDescriptor = $convert.base64Decode('ChhDcmVhdGVUb3VybmFtZW50RXZlbnRPdXQSDgoCaWQYASABKAVSAmlk');
@$core.Deprecated('Use addPlayerEventDescriptor instead')
const AddPlayerEvent$json = const {
  '1': 'AddPlayerEvent',
  '2': const [
    const {'1': 'player', '3': 1, '4': 1, '5': 11, '6': '.generated.Player', '10': 'player'},
  ],
};

/// Descriptor for `AddPlayerEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addPlayerEventDescriptor = $convert.base64Decode('Cg5BZGRQbGF5ZXJFdmVudBIpCgZwbGF5ZXIYASABKAsyES5nZW5lcmF0ZWQuUGxheWVyUgZwbGF5ZXI=');
@$core.Deprecated('Use cannotMeetEditionEventDescriptor instead')
const CannotMeetEditionEvent$json = const {
  '1': 'CannotMeetEditionEvent',
  '2': const [
    const {'1': 'player1', '3': 1, '4': 1, '5': 11, '6': '.generated.Player', '10': 'player1'},
    const {'1': 'player2', '3': 2, '4': 1, '5': 11, '6': '.generated.Player', '10': 'player2'},
  ],
};

/// Descriptor for `CannotMeetEditionEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cannotMeetEditionEventDescriptor = $convert.base64Decode('ChZDYW5ub3RNZWV0RWRpdGlvbkV2ZW50EisKB3BsYXllcjEYASABKAsyES5nZW5lcmF0ZWQuUGxheWVyUgdwbGF5ZXIxEisKB3BsYXllcjIYAiABKAsyES5nZW5lcmF0ZWQuUGxheWVyUgdwbGF5ZXIy');
@$core.Deprecated('Use cannotMeetEventOutDescriptor instead')
const CannotMeetEventOut$json = const {
  '1': 'CannotMeetEventOut',
  '2': const [
    const {'1': 'pairs', '3': 1, '4': 3, '5': 11, '6': '.generated.CannotMeetEditionEvent', '10': 'pairs'},
  ],
};

/// Descriptor for `CannotMeetEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cannotMeetEventOutDescriptor = $convert.base64Decode('ChJDYW5ub3RNZWV0RXZlbnRPdXQSNwoFcGFpcnMYASADKAsyIS5nZW5lcmF0ZWQuQ2Fubm90TWVldEVkaXRpb25FdmVudFIFcGFpcnM=');
@$core.Deprecated('Use getAvailablePlayerEventOutDescriptor instead')
const GetAvailablePlayerEventOut$json = const {
  '1': 'GetAvailablePlayerEventOut',
  '2': const [
    const {'1': 'players', '3': 1, '4': 3, '5': 11, '6': '.generated.Player', '10': 'players'},
  ],
};

/// Descriptor for `GetAvailablePlayerEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAvailablePlayerEventOutDescriptor = $convert.base64Decode('ChpHZXRBdmFpbGFibGVQbGF5ZXJFdmVudE91dBIrCgdwbGF5ZXJzGAEgAygLMhEuZ2VuZXJhdGVkLlBsYXllclIHcGxheWVycw==');
@$core.Deprecated('Use tournamentSettingsDescriptor instead')
const TournamentSettings$json = const {
  '1': 'TournamentSettings',
  '2': const [
    const {'1': 'defaultGamesCount', '3': 1, '4': 1, '5': 5, '9': 0, '10': 'defaultGamesCount', '17': true},
    const {'1': 'swissGamesCount', '3': 2, '4': 1, '5': 5, '9': 1, '10': 'swissGamesCount', '17': true},
    const {'1': 'finalGamesCount', '3': 3, '4': 1, '5': 5, '9': 2, '10': 'finalGamesCount', '17': true},
    const {'1': 'buckets', '3': 4, '4': 3, '5': 5, '10': 'buckets'},
    const {'1': 'hideResult', '3': 5, '4': 1, '5': 8, '9': 3, '10': 'hideResult', '17': true},
  ],
  '8': const [
    const {'1': '_defaultGamesCount'},
    const {'1': '_swissGamesCount'},
    const {'1': '_finalGamesCount'},
    const {'1': '_hideResult'},
  ],
};

/// Descriptor for `TournamentSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tournamentSettingsDescriptor = $convert.base64Decode('ChJUb3VybmFtZW50U2V0dGluZ3MSMQoRZGVmYXVsdEdhbWVzQ291bnQYASABKAVIAFIRZGVmYXVsdEdhbWVzQ291bnSIAQESLQoPc3dpc3NHYW1lc0NvdW50GAIgASgFSAFSD3N3aXNzR2FtZXNDb3VudIgBARItCg9maW5hbEdhbWVzQ291bnQYAyABKAVIAlIPZmluYWxHYW1lc0NvdW50iAEBEhgKB2J1Y2tldHMYBCADKAVSB2J1Y2tldHMSIwoKaGlkZVJlc3VsdBgFIAEoCEgDUgpoaWRlUmVzdWx0iAEBQhQKEl9kZWZhdWx0R2FtZXNDb3VudEISChBfc3dpc3NHYW1lc0NvdW50QhIKEF9maW5hbEdhbWVzQ291bnRCDQoLX2hpZGVSZXN1bHQ=');
@$core.Deprecated('Use profileDescriptor instead')
const Profile$json = const {
  '1': 'Profile',
  '2': const [
    const {'1': 'firstName', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'firstName', '17': true},
    const {'1': 'secondName', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'secondName', '17': true},
  ],
  '8': const [
    const {'1': '_firstName'},
    const {'1': '_secondName'},
  ],
};

/// Descriptor for `Profile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List profileDescriptor = $convert.base64Decode('CgdQcm9maWxlEiEKCWZpcnN0TmFtZRgBIAEoCUgAUglmaXJzdE5hbWWIAQESIwoKc2Vjb25kTmFtZRgCIAEoCUgBUgpzZWNvbmROYW1liAEBQgwKCl9maXJzdE5hbWVCDQoLX3NlY29uZE5hbWU=');
@$core.Deprecated('Use createPlayerEventOutDescriptor instead')
const CreatePlayerEventOut$json = const {
  '1': 'CreatePlayerEventOut',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `CreatePlayerEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPlayerEventOutDescriptor = $convert.base64Decode('ChRDcmVhdGVQbGF5ZXJFdmVudE91dBIOCgJpZBgBIAEoBVICaWQ=');
@$core.Deprecated('Use createPlayerEventDescriptor instead')
const CreatePlayerEvent$json = const {
  '1': 'CreatePlayerEvent',
  '2': const [
    const {'1': 'player', '3': 1, '4': 1, '5': 11, '6': '.generated.Player', '10': 'player'},
  ],
};

/// Descriptor for `CreatePlayerEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPlayerEventDescriptor = $convert.base64Decode('ChFDcmVhdGVQbGF5ZXJFdmVudBIpCgZwbGF5ZXIYASABKAsyES5nZW5lcmF0ZWQuUGxheWVyUgZwbGF5ZXI=');
@$core.Deprecated('Use playerDescriptor instead')
const Player$json = const {
  '1': 'Player',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'fsmNickname', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'fsmNickname', '17': true},
    const {'1': 'mafbankNickname', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'mafbankNickname', '17': true},
    const {'1': 'image', '3': 5, '4': 1, '5': 9, '9': 2, '10': 'image', '17': true},
  ],
  '8': const [
    const {'1': '_fsmNickname'},
    const {'1': '_mafbankNickname'},
    const {'1': '_image'},
  ],
};

/// Descriptor for `Player`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerDescriptor = $convert.base64Decode('CgZQbGF5ZXISDgoCaWQYASABKAVSAmlkEhoKCG5pY2tuYW1lGAIgASgJUghuaWNrbmFtZRIlCgtmc21OaWNrbmFtZRgDIAEoCUgAUgtmc21OaWNrbmFtZYgBARItCg9tYWZiYW5rTmlja25hbWUYBCABKAlIAVIPbWFmYmFua05pY2tuYW1liAEBEhkKBWltYWdlGAUgASgJSAJSBWltYWdliAEBQg4KDF9mc21OaWNrbmFtZUISChBfbWFmYmFua05pY2tuYW1lQggKBl9pbWFnZQ==');
@$core.Deprecated('Use createSwissRoundDescriptor instead')
const CreateSwissRound$json = const {
  '1': 'CreateSwissRound',
  '2': const [
    const {'1': 'game', '3': 1, '4': 1, '5': 5, '10': 'game'},
  ],
};

/// Descriptor for `CreateSwissRound`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSwissRoundDescriptor = $convert.base64Decode('ChBDcmVhdGVTd2lzc1JvdW5kEhIKBGdhbWUYASABKAVSBGdhbWU=');
@$core.Deprecated('Use emailVerificationEventOutDescriptor instead')
const EmailVerificationEventOut$json = const {
  '1': 'EmailVerificationEventOut',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.generated.EmailVerificationEventOut.Status', '10': 'status'},
  ],
  '4': const [EmailVerificationEventOut_Status$json],
};

@$core.Deprecated('Use emailVerificationEventOutDescriptor instead')
const EmailVerificationEventOut_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'success', '2': 0},
    const {'1': 'incorrectToken', '2': 1},
  ],
};

/// Descriptor for `EmailVerificationEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailVerificationEventOutDescriptor = $convert.base64Decode('ChlFbWFpbFZlcmlmaWNhdGlvbkV2ZW50T3V0EkMKBnN0YXR1cxgBIAEoDjIrLmdlbmVyYXRlZC5FbWFpbFZlcmlmaWNhdGlvbkV2ZW50T3V0LlN0YXR1c1IGc3RhdHVzIikKBlN0YXR1cxILCgdzdWNjZXNzEAASEgoOaW5jb3JyZWN0VG9rZW4QAQ==');
@$core.Deprecated('Use getFinalPlayersOutDescriptor instead')
const GetFinalPlayersOut$json = const {
  '1': 'GetFinalPlayersOut',
  '2': const [
    const {'1': 'player', '3': 1, '4': 3, '5': 11, '6': '.generated.Player', '10': 'player'},
  ],
};

/// Descriptor for `GetFinalPlayersOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFinalPlayersOutDescriptor = $convert.base64Decode('ChJHZXRGaW5hbFBsYXllcnNPdXQSKQoGcGxheWVyGAEgAygLMhEuZ2VuZXJhdGVkLlBsYXllclIGcGxheWVy');
@$core.Deprecated('Use seatingForTranslationEventDescriptor instead')
const SeatingForTranslationEvent$json = const {
  '1': 'SeatingForTranslationEvent',
  '2': const [
    const {'1': 'tournamentId', '3': 1, '4': 1, '5': 5, '10': 'tournamentId'},
    const {'1': 'table', '3': 2, '4': 1, '5': 5, '10': 'table'},
    const {'1': 'game', '3': 3, '4': 1, '5': 5, '10': 'game'},
  ],
};

/// Descriptor for `SeatingForTranslationEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List seatingForTranslationEventDescriptor = $convert.base64Decode('ChpTZWF0aW5nRm9yVHJhbnNsYXRpb25FdmVudBIiCgx0b3VybmFtZW50SWQYASABKAVSDHRvdXJuYW1lbnRJZBIUCgV0YWJsZRgCIAEoBVIFdGFibGUSEgoEZ2FtZRgDIAEoBVIEZ2FtZQ==');
@$core.Deprecated('Use seatingForTranslationEventOutDescriptor instead')
const SeatingForTranslationEventOut$json = const {
  '1': 'SeatingForTranslationEventOut',
  '2': const [
    const {'1': 'players', '3': 1, '4': 3, '5': 9, '10': 'players'},
  ],
};

/// Descriptor for `SeatingForTranslationEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List seatingForTranslationEventOutDescriptor = $convert.base64Decode('Ch1TZWF0aW5nRm9yVHJhbnNsYXRpb25FdmVudE91dBIYCgdwbGF5ZXJzGAEgAygJUgdwbGF5ZXJz');
@$core.Deprecated('Use insertSeatingEventDescriptor instead')
const InsertSeatingEvent$json = const {
  '1': 'InsertSeatingEvent',
  '2': const [
    const {'1': 'bytes', '3': 1, '4': 1, '5': 12, '10': 'bytes'},
    const {'1': 'tournamentId', '3': 2, '4': 1, '5': 5, '10': 'tournamentId'},
  ],
};

/// Descriptor for `InsertSeatingEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insertSeatingEventDescriptor = $convert.base64Decode('ChJJbnNlcnRTZWF0aW5nRXZlbnQSFAoFYnl0ZXMYASABKAxSBWJ5dGVzEiIKDHRvdXJuYW1lbnRJZBgCIAEoBVIMdG91cm5hbWVudElk');
@$core.Deprecated('Use getTournamentsEventOutDescriptor instead')
const GetTournamentsEventOut$json = const {
  '1': 'GetTournamentsEventOut',
  '2': const [
    const {'1': 'tournaments', '3': 1, '4': 3, '5': 11, '6': '.generated.Tournament', '10': 'tournaments'},
  ],
};

/// Descriptor for `GetTournamentsEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTournamentsEventOutDescriptor = $convert.base64Decode('ChZHZXRUb3VybmFtZW50c0V2ZW50T3V0EjcKC3RvdXJuYW1lbnRzGAEgAygLMhUuZ2VuZXJhdGVkLlRvdXJuYW1lbnRSC3RvdXJuYW1lbnRz');
@$core.Deprecated('Use tournamentDescriptor instead')
const Tournament$json = const {
  '1': 'Tournament',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.generated.Tournament.Status', '10': 'status'},
    const {'1': 'dateStart', '3': 4, '4': 1, '5': 9, '10': 'dateStart'},
    const {'1': 'dateEnd', '3': 5, '4': 1, '5': 9, '10': 'dateEnd'},
    const {'1': 'gamesCount', '3': 6, '4': 1, '5': 5, '10': 'gamesCount'},
    const {'1': 'billedPlayers', '3': 7, '4': 1, '5': 5, '10': 'billedPlayers'},
    const {'1': 'billedTranslation', '3': 8, '4': 1, '5': 8, '10': 'billedTranslation'},
    const {'1': 'notificationEnabled', '3': 9, '4': 1, '5': 8, '10': 'notificationEnabled'},
  ],
  '4': const [Tournament_Status$json],
};

@$core.Deprecated('Use tournamentDescriptor instead')
const Tournament_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'waitForBilling', '2': 0},
    const {'1': 'active', '2': 1},
    const {'1': 'ended', '2': 2},
  ],
};

/// Descriptor for `Tournament`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tournamentDescriptor = $convert.base64Decode('CgpUb3VybmFtZW50Eg4KAmlkGAEgASgFUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEjQKBnN0YXR1cxgDIAEoDjIcLmdlbmVyYXRlZC5Ub3VybmFtZW50LlN0YXR1c1IGc3RhdHVzEhwKCWRhdGVTdGFydBgEIAEoCVIJZGF0ZVN0YXJ0EhgKB2RhdGVFbmQYBSABKAlSB2RhdGVFbmQSHgoKZ2FtZXNDb3VudBgGIAEoBVIKZ2FtZXNDb3VudBIkCg1iaWxsZWRQbGF5ZXJzGAcgASgFUg1iaWxsZWRQbGF5ZXJzEiwKEWJpbGxlZFRyYW5zbGF0aW9uGAggASgIUhFiaWxsZWRUcmFuc2xhdGlvbhIwChNub3RpZmljYXRpb25FbmFibGVkGAkgASgIUhNub3RpZmljYXRpb25FbmFibGVkIjMKBlN0YXR1cxISCg53YWl0Rm9yQmlsbGluZxAAEgoKBmFjdGl2ZRABEgkKBWVuZGVkEAI=');
@$core.Deprecated('Use errorOutDescriptor instead')
const ErrorOut$json = const {
  '1': 'ErrorOut',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ErrorOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorOutDescriptor = $convert.base64Decode('CghFcnJvck91dBIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use billTournamentEventDescriptor instead')
const BillTournamentEvent$json = const {
  '1': 'BillTournamentEvent',
  '2': const [
    const {'1': 'players', '3': 1, '4': 1, '5': 5, '10': 'players'},
    const {'1': 'hasTranslation', '3': 2, '4': 1, '5': 8, '10': 'hasTranslation'},
    const {'1': 'redirectPath', '3': 3, '4': 1, '5': 9, '10': 'redirectPath'},
  ],
};

/// Descriptor for `BillTournamentEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billTournamentEventDescriptor = $convert.base64Decode('ChNCaWxsVG91cm5hbWVudEV2ZW50EhgKB3BsYXllcnMYASABKAVSB3BsYXllcnMSJgoOaGFzVHJhbnNsYXRpb24YAiABKAhSDmhhc1RyYW5zbGF0aW9uEiIKDHJlZGlyZWN0UGF0aBgDIAEoCVIMcmVkaXJlY3RQYXRo');
@$core.Deprecated('Use billClubEventDescriptor instead')
const BillClubEvent$json = const {
  '1': 'BillClubEvent',
  '2': const [
    const {'1': 'days', '3': 1, '4': 1, '5': 5, '10': 'days'},
    const {'1': 'redirectPath', '3': 2, '4': 1, '5': 9, '10': 'redirectPath'},
  ],
};

/// Descriptor for `BillClubEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billClubEventDescriptor = $convert.base64Decode('Cg1CaWxsQ2x1YkV2ZW50EhIKBGRheXMYASABKAVSBGRheXMSIgoMcmVkaXJlY3RQYXRoGAIgASgJUgxyZWRpcmVjdFBhdGg=');
@$core.Deprecated('Use billTournamentEventOutDescriptor instead')
const BillTournamentEventOut$json = const {
  '1': 'BillTournamentEventOut',
  '2': const [
    const {'1': 'redirectLink', '3': 1, '4': 1, '5': 9, '10': 'redirectLink'},
  ],
};

/// Descriptor for `BillTournamentEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billTournamentEventOutDescriptor = $convert.base64Decode('ChZCaWxsVG91cm5hbWVudEV2ZW50T3V0EiIKDHJlZGlyZWN0TGluaxgBIAEoCVIMcmVkaXJlY3RMaW5r');
@$core.Deprecated('Use startGameInfoEventDescriptor instead')
const StartGameInfoEvent$json = const {
  '1': 'StartGameInfoEvent',
  '2': const [
    const {'1': 'game', '3': 1, '4': 1, '5': 5, '10': 'game'},
  ],
};

/// Descriptor for `StartGameInfoEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startGameInfoEventDescriptor = $convert.base64Decode('ChJTdGFydEdhbWVJbmZvRXZlbnQSEgoEZ2FtZRgBIAEoBVIEZ2FtZQ==');
@$core.Deprecated('Use customTextInfoEventDescriptor instead')
const CustomTextInfoEvent$json = const {
  '1': 'CustomTextInfoEvent',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
  ],
};

/// Descriptor for `CustomTextInfoEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customTextInfoEventDescriptor = $convert.base64Decode('ChNDdXN0b21UZXh0SW5mb0V2ZW50EhIKBHRleHQYASABKAlSBHRleHQ=');
