import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_dialog_event.freezed.dart';

@freezed
abstract class ProfileDialogEvent with _$ProfileDialogEvent {
  const factory ProfileDialogEvent.onSubmit({
    required String nickname,
    required String mafbankNickname,
    required String fsmNickname,
  }) = ProfileDialogEventSubmit;

  const factory ProfileDialogEvent.editImage({
    required Uint8List bytes,
    required String fileName,
  }) = ProfileDialogEventEditImage;
}
