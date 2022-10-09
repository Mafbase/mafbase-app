///
//  Generated code. Do not modify.
//  source: seating-generator-proto/mafia.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
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
@$core.Deprecated('Use loginEventOutDescriptor instead')
const LoginEventOut$json = const {
  '1': 'LoginEventOut',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'recoveryToken', '3': 2, '4': 1, '5': 9, '10': 'recoveryToken'},
    const {'1': 'error', '3': 3, '4': 1, '5': 14, '6': '.generated.LoginEventOut.Error', '10': 'error'},
  ],
  '4': const [LoginEventOut_Error$json],
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
final $typed_data.Uint8List loginEventOutDescriptor = $convert.base64Decode('Cg1Mb2dpbkV2ZW50T3V0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIkCg1yZWNvdmVyeVRva2VuGAIgASgJUg1yZWNvdmVyeVRva2VuEjQKBWVycm9yGAMgASgOMh4uZ2VuZXJhdGVkLkxvZ2luRXZlbnRPdXQuRXJyb3JSBWVycm9yIkIKBUVycm9yEgsKB25vRXJyb3IQABIUChBuZWVkVmVyaWZpY2F0aW9uEAESFgoSaW52YWxpZENyZWRlbnRpYWxzEAI=');
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
  ],
  '8': const [
    const {'1': '_defaultGamesCount'},
    const {'1': '_swissGamesCount'},
    const {'1': '_finalGamesCount'},
  ],
};

/// Descriptor for `TournamentSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tournamentSettingsDescriptor = $convert.base64Decode('ChJUb3VybmFtZW50U2V0dGluZ3MSMQoRZGVmYXVsdEdhbWVzQ291bnQYASABKAVIAFIRZGVmYXVsdEdhbWVzQ291bnSIAQESLQoPc3dpc3NHYW1lc0NvdW50GAIgASgFSAFSD3N3aXNzR2FtZXNDb3VudIgBARItCg9maW5hbEdhbWVzQ291bnQYAyABKAVIAlIPZmluYWxHYW1lc0NvdW50iAEBQhQKEl9kZWZhdWx0R2FtZXNDb3VudEISChBfc3dpc3NHYW1lc0NvdW50QhIKEF9maW5hbEdhbWVzQ291bnQ=');
@$core.Deprecated('Use playerDescriptor instead')
const Player$json = const {
  '1': 'Player',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'fsmNickname', '3': 3, '4': 1, '5': 9, '10': 'fsmNickname'},
    const {'1': 'mafbankNickname', '3': 4, '4': 1, '5': 9, '10': 'mafbankNickname'},
  ],
};

/// Descriptor for `Player`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerDescriptor = $convert.base64Decode('CgZQbGF5ZXISDgoCaWQYASABKAVSAmlkEhoKCG5pY2tuYW1lGAIgASgJUghuaWNrbmFtZRIgCgtmc21OaWNrbmFtZRgDIAEoCVILZnNtTmlja25hbWUSKAoPbWFmYmFua05pY2tuYW1lGAQgASgJUg9tYWZiYW5rTmlja25hbWU=');
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
final $typed_data.Uint8List tournamentDescriptor = $convert.base64Decode('CgpUb3VybmFtZW50Eg4KAmlkGAEgASgFUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEjQKBnN0YXR1cxgDIAEoDjIcLmdlbmVyYXRlZC5Ub3VybmFtZW50LlN0YXR1c1IGc3RhdHVzEhwKCWRhdGVTdGFydBgEIAEoCVIJZGF0ZVN0YXJ0EhgKB2RhdGVFbmQYBSABKAlSB2RhdGVFbmQSHgoKZ2FtZXNDb3VudBgGIAEoBVIKZ2FtZXNDb3VudCIzCgZTdGF0dXMSEgoOd2FpdEZvckJpbGxpbmcQABIKCgZhY3RpdmUQARIJCgVlbmRlZBAC');
@$core.Deprecated('Use errorOutDescriptor instead')
const ErrorOut$json = const {
  '1': 'ErrorOut',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ErrorOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorOutDescriptor = $convert.base64Decode('CghFcnJvck91dBIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
