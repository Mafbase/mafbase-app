import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_table_description_state.freezed.dart';

@freezed
abstract class InfoTableState with _$InfoTableState {
  const factory InfoTableState({
    @Default(true) bool loading,
    @Default([]) List<MapEntry<int, String>> tableDescriptions,
  }) = _InfoTableState;
}
