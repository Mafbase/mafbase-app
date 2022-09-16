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
  ],
};

/// Descriptor for `LoginEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginEventOutDescriptor = $convert.base64Decode('Cg1Mb2dpbkV2ZW50T3V0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIkCg1yZWNvdmVyeVRva2VuGAIgASgJUg1yZWNvdmVyeVRva2Vu');
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
  ],
};

/// Descriptor for `LoginByTokenEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginByTokenEventOutDescriptor = $convert.base64Decode('ChRMb2dpbkJ5VG9rZW5FdmVudE91dBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SJAoNcmVjb3ZlcnlUb2tlbhgCIAEoCVINcmVjb3ZlcnlUb2tlbg==');
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
  ],
};

/// Descriptor for `SignUpEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signUpEventOutDescriptor = $convert.base64Decode('Cg5TaWduVXBFdmVudE91dBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SJAoNcmVjb3ZlcnlUb2tlbhgCIAEoCVINcmVjb3ZlcnlUb2tlbhI1CgVlcnJvchgDIAEoDjIfLmdlbmVyYXRlZC5TaWduVXBFdmVudE91dC5FcnJvclIFZXJyb3IiNgoFRXJyb3ISCwoHbm9FcnJvchAAEg4KCmVtYWlsRXhpc3QQARIQCgx3ZWFrUGFzc3dvcmQQAg==');
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
    const {'1': 'csv', '3': 1, '4': 1, '5': 9, '10': 'csv'},
    const {'1': 'tournamentId', '3': 2, '4': 1, '5': 5, '10': 'tournamentId'},
  ],
};

/// Descriptor for `InsertSeatingEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insertSeatingEventDescriptor = $convert.base64Decode('ChJJbnNlcnRTZWF0aW5nRXZlbnQSEAoDY3N2GAEgASgJUgNjc3YSIgoMdG91cm5hbWVudElkGAIgASgFUgx0b3VybmFtZW50SWQ=');
@$core.Deprecated('Use getTournamentsEventOutDescriptor instead')
const GetTournamentsEventOut$json = const {
  '1': 'GetTournamentsEventOut',
  '2': const [
    const {'1': 'tournaments', '3': 1, '4': 3, '5': 11, '6': '.generated.GetTournamentsEventOut.Tournament', '10': 'tournaments'},
  ],
  '3': const [GetTournamentsEventOut_Tournament$json],
};

@$core.Deprecated('Use getTournamentsEventOutDescriptor instead')
const GetTournamentsEventOut_Tournament$json = const {
  '1': 'Tournament',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.generated.GetTournamentsEventOut.Tournament.Status', '10': 'status'},
    const {'1': 'dateStart', '3': 4, '4': 1, '5': 9, '10': 'dateStart'},
    const {'1': 'dateEnd', '3': 5, '4': 1, '5': 9, '10': 'dateEnd'},
  ],
  '4': const [GetTournamentsEventOut_Tournament_Status$json],
};

@$core.Deprecated('Use getTournamentsEventOutDescriptor instead')
const GetTournamentsEventOut_Tournament_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'waitForBilling', '2': 0},
    const {'1': 'active', '2': 1},
    const {'1': 'ended', '2': 2},
  ],
};

/// Descriptor for `GetTournamentsEventOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTournamentsEventOutDescriptor = $convert.base64Decode('ChZHZXRUb3VybmFtZW50c0V2ZW50T3V0Ek4KC3RvdXJuYW1lbnRzGAEgAygLMiwuZ2VuZXJhdGVkLkdldFRvdXJuYW1lbnRzRXZlbnRPdXQuVG91cm5hbWVudFILdG91cm5hbWVudHMa6gEKClRvdXJuYW1lbnQSDgoCaWQYASABKAVSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSSwoGc3RhdHVzGAMgASgOMjMuZ2VuZXJhdGVkLkdldFRvdXJuYW1lbnRzRXZlbnRPdXQuVG91cm5hbWVudC5TdGF0dXNSBnN0YXR1cxIcCglkYXRlU3RhcnQYBCABKAlSCWRhdGVTdGFydBIYCgdkYXRlRW5kGAUgASgJUgdkYXRlRW5kIjMKBlN0YXR1cxISCg53YWl0Rm9yQmlsbGluZxAAEgoKBmFjdGl2ZRABEgkKBWVuZGVkEAI=');
