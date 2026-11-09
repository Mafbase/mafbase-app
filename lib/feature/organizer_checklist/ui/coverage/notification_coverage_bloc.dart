import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_repository.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_state.dart';

class NotificationCoverageBloc extends Bloc<NotificationCoverageEvent, NotificationCoverageState> {
  final OrganizerChecklistRepository _repository;
  final int tournamentId;

  NotificationCoverageBloc({
    required OrganizerChecklistRepository repository,
    required this.tournamentId,
  })  : _repository = repository,
        super(const NotificationCoverageState()) {
    on<NotificationCoverageEventLoad>(_onLoad, transformer: restartable());
  }

  Future<void> _onLoad(NotificationCoverageEventLoad event, Emitter<NotificationCoverageState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final coverage = await _repository.getNotificationCoverage(tournamentId);
      emit(state.copyWith(coverage: coverage));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
