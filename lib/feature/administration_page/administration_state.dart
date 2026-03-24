import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/user_model.dart';

part 'administration_state.freezed.dart';

@freezed
abstract class AdministrationState with _$AdministrationState {
  const factory AdministrationState({
    @Default([]) List<UserModel> owners,
    @Default(true) bool isLoading,
  }) = _AdministrationState;
}
