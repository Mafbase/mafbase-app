import 'package:freezed_annotation/freezed_annotation.dart';

part 'seating_inserting_event.freezed.dart';

@freezed
abstract class SeatingInsertingEvent with _$SeatingInsertingEvent {
  const factory SeatingInsertingEvent.save() = SeatingInsertingSaveEvent;

  const factory SeatingInsertingEvent.onFileSelected({
    required Stream<List<int>> bytesStream,
  }) = SeatingInsertingFileSelectedEvent;
}
