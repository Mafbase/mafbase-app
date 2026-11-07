import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_event_transformers/bloc_event_transformers.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/organizer_checklist/data/checklist_banner_storage.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_repository.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';

/// Чеклист открытого турнира, общий для меню, баннера и страницы.
class OrganizerChecklistBloc extends Bloc<OrganizerChecklistEvent, OrganizerChecklistState> {
  static const reloadDebounce = Duration(milliseconds: 300);

  final OrganizerChecklistRepository _repository;
  final ChecklistBannerStorage _bannerStorage;
  final int tournamentId;

  /// Меняется в начале и в конце каждого изменения: ответ загрузки, начатой до его окончания, устарел.
  int _revision = 0;

  OrganizerChecklistBloc({
    required OrganizerChecklistRepository repository,
    required ChecklistBannerStorage bannerStorage,
    required this.tournamentId,
  })  : _repository = repository,
        _bannerStorage = bannerStorage,
        super(const OrganizerChecklistState()) {
    on<OrganizerChecklistEventLoad>(_onLoad, transformer: debounce(reloadDebounce));
    on<OrganizerChecklistMutationEvent>(_onMutation, transformer: sequential());
    on<OrganizerChecklistEventHideBanner>(_onHideBanner);
  }

  Future<void> _onLoad(OrganizerChecklistEventLoad event, Emitter<OrganizerChecklistState> emit) async {
    final revision = _revision;
    try {
      final checklist = await _repository.getChecklist(tournamentId);
      final bannerHidden = state.isBannerHidden || await _bannerStorage.isHidden(tournamentId);
      if (revision != _revision) return;
      emit(state.copyWith(checklist: checklist, hasError: false, isBannerHidden: bannerHidden));
    } catch (_) {
      // BlocObserver показал бы диалог, а без чеклиста турнир работает как раньше.
      if (revision != _revision) return;
      emit(state.copyWith(checklist: null, hasError: true));
    }
  }

  Future<void> _onMutation(OrganizerChecklistMutationEvent event, Emitter<OrganizerChecklistState> emit) async {
    _revision++;
    emit(state.copyWith(isUpdating: true));
    try {
      switch (event) {
        case OrganizerChecklistEventSetDismissed(:final keys, :final dismissed):
          await _setDismissed(keys, dismissed: dismissed, emit: emit);
        case OrganizerChecklistEventSelectStreamMethod(:final method):
          await _setDismissed(method.other.keys, dismissed: true, emit: emit);
          await _setDismissed(method.keys, dismissed: false, emit: emit);
      }
    } finally {
      _revision++;
      emit(state.copyWith(isUpdating: false));
    }
  }

  Future<void> _setDismissed(
    List<ChecklistKey> keys, {
    required bool dismissed,
    required Emitter<OrganizerChecklistState> emit,
  }) async {
    final checklist = await _repository.setDismissed(tournamentId, keys: keys, dismissed: dismissed);
    emit(state.copyWith(checklist: checklist, hasError: false));
  }

  Future<void> _onHideBanner(OrganizerChecklistEventHideBanner event, Emitter<OrganizerChecklistState> emit) async {
    emit(state.copyWith(isBannerHidden: true));
    await _bannerStorage.hide(tournamentId);
  }
}
