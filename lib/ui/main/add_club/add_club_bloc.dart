import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/create_club_interactor.dart';
import 'package:seating_generator_web/ui/main/add_club/add_club_event.dart';
import 'package:seating_generator_web/ui/main/add_club/add_club_router.dart';
import 'package:seating_generator_web/ui/main/add_club/add_club_state.dart';

class AddClubBloc extends Bloc<AddClubEvent, AddClubState> {
  final CreateClubInteractor _createClubInteractor;
  final AddClubRouter _router;

  AddClubBloc({
    required CreateClubInteractor createClubInteractor,
    required AddClubRouter router,
  }) : _createClubInteractor = createClubInteractor,
       _router = router,
       super(const AddClubState()) {
    on<AddClubEventFormSubmitted>(_onFormSubmitted);
  }

  Future<void> _onFormSubmitted(
    AddClubEventFormSubmitted event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _createClubInteractor.run(
        name: event.name,
        description: event.description,
        groupLink: event.groupLink,
      );
      _router.openClubsPage();
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
