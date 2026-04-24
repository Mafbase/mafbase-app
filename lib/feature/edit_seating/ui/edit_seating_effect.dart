import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_seating_effect.freezed.dart';

@freezed
abstract class EditSeatingPageEffect with _$EditSeatingPageEffect {
  const factory EditSeatingPageEffect.saveSuccess() = EditSeatingPageEffectSaveSuccess;
}
