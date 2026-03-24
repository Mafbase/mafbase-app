import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
part 'translation_content_event.freezed.dart';

@freezed
abstract class TranslationContentEvent with _$TranslationContentEvent {
  const factory TranslationContentEvent.stateReceived({
    required SeatingContent content,
  }) = TranslationContentEventStateReceived;

  const factory TranslationContentEvent.pageOpened() = TranslationContentEventPageOpened;
}
