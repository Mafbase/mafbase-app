import 'package:freezed_annotation/freezed_annotation.dart';

part 'temp_event.freezed.dart';

@freezed
abstract class TempEvent with _$TempEvent {
  const factory TempEvent.generate() = TempEventGenerate;
}
