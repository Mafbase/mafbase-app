import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_translation_answer.dart';

sealed class OrganizerSetupEvent {
  const OrganizerSetupEvent();
}

final class OrganizerSetupEventFsmAnswered extends OrganizerSetupEvent {
  final bool isFsm;

  const OrganizerSetupEventFsmAnswered({required this.isFsm});
}

final class OrganizerSetupEventGomafiaUrlSubmitted extends OrganizerSetupEvent {
  final String url;

  const OrganizerSetupEventGomafiaUrlSubmitted(this.url);
}

/// Со шага ссылки обратно к вопросу про GoMafia.
final class OrganizerSetupEventBack extends OrganizerSetupEvent {
  const OrganizerSetupEventBack();
}

final class OrganizerSetupEventTranslationAnswered extends OrganizerSetupEvent {
  final OrganizerSetupTranslationAnswer answer;

  const OrganizerSetupEventTranslationAnswered(this.answer);
}
