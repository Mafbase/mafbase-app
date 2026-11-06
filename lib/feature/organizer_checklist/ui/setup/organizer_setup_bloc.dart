import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/utils/gomafia_tournament_url.dart';

/// Шаги мастера настройки. Ответы сразу уходят в блоки страницы турнира и на backend, поэтому закрытие мастера
/// на любом шаге сделанное не теряет.
class OrganizerSetupBloc extends Bloc<OrganizerSetupEvent, OrganizerSetupState> {
  final TournamentEditRepository _repository;
  final TournamentPageBloc _tournamentBloc;
  final OrganizerChecklistBloc _checklistBloc;
  final int tournamentId;

  OrganizerSetupBloc({
    required TournamentEditRepository repository,
    required TournamentPageBloc tournamentBloc,
    required OrganizerChecklistBloc checklistBloc,
    required this.tournamentId,
  })  : _repository = repository,
        _tournamentBloc = tournamentBloc,
        _checklistBloc = checklistBloc,
        super(const OrganizerSetupState()) {
    on<OrganizerSetupEventFsmAnswered>(_onFsmAnswered);
    on<OrganizerSetupEventGomafiaUrlSubmitted>(_onGomafiaUrlSubmitted, transformer: droppable());
    on<OrganizerSetupEventBack>(_onBack);
    on<OrganizerSetupEventTranslationAnswered>(_onTranslationAnswered);
  }

  void _onFsmAnswered(OrganizerSetupEventFsmAnswered event, Emitter<OrganizerSetupState> emit) {
    emit(state.copyWith(step: event.isFsm ? OrganizerSetupStep.gomafiaUrl : OrganizerSetupStep.translation));
  }

  Future<void> _onGomafiaUrlSubmitted(
    OrganizerSetupEventGomafiaUrlSubmitted event,
    Emitter<OrganizerSetupState> emit,
  ) async {
    final url = normalizeGomafiaTournamentUrl(event.url);
    if (url == null) return;

    emit(state.copyWith(isSaving: true));
    try {
      await _repository.setGomafiaUrl(tournamentId: tournamentId, gomafiaUrl: url);
      _tournamentBloc.add(const TournamentPageEvent.pageOpened());
      emit(state.copyWith(step: OrganizerSetupStep.translation, isGomafiaUrlSaved: true));
    } finally {
      emit(state.copyWith(isSaving: false));
    }
  }

  void _onBack(OrganizerSetupEventBack event, Emitter<OrganizerSetupState> emit) {
    if (state.step != OrganizerSetupStep.gomafiaUrl || state.isSaving) return;
    emit(state.copyWith(step: OrganizerSetupStep.fsm));
  }

  void _onTranslationAnswered(OrganizerSetupEventTranslationAnswered event, Emitter<OrganizerSetupState> emit) {
    if (event.answer.checklistEvent case final checklistEvent?) _checklistBloc.add(checklistEvent);
    emit(state.copyWith(step: OrganizerSetupStep.done));
  }
}
