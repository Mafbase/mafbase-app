import 'package:freezed_annotation/freezed_annotation.dart';

part 'temp_state.freezed.dart';

@freezed
abstract class TempState with _$TempState {
  const factory TempState({
    required TempStyle style,
  }) = _TempState;
}

enum TempStyle {
  hide,
  empty,
  classic,
  gold;
}
