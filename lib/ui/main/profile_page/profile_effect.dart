import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_effect.freezed.dart';

@freezed
sealed class ProfileEffect with _$ProfileEffect {
  const factory ProfileEffect.navigateBack() = ProfileEffectNavigateBack;
}
