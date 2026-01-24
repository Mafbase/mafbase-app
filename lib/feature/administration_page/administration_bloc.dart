import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/add_owner_interactor.dart';
import 'package:seating_generator_web/domain/interactors/delete_owner_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_administration_interactor.dart';
import 'package:seating_generator_web/feature/administration_page/administration_event.dart';
import 'package:seating_generator_web/feature/administration_page/administration_state.dart';

class AdministrationBloc extends CustomBloc<AdministrationEvent, AdministrationState> {
  final GetAdministrationInteractor getAdministrationInteractor;
  final AddOwnerInteractor addOwnerInteractor;
  final DeleteOwnerInteractor deleteOwnerInteractor;

  AdministrationBloc(
    super.initialState,
    this.addOwnerInteractor,
    this.deleteOwnerInteractor,
    this.getAdministrationInteractor,
    super.context,
  ) {
    on<AdministrationEventPageOpened>(_onPageOpened);
    on<AdministrationEventAddOwner>(_onAddOwnerTapped);
    on<AdministrationEventDeleteOwner>(_deleteOwner);
  }

  Future<void> _onPageOpened(
    AdministrationEventPageOpened event,
    Emitter emit,
  ) async {
    final owners = await getAdministrationInteractor.run(
      tournamentId: event.tournamentId,
    );
    emit(
      state.copyWith(owners: owners, isLoading: false),
    );
  }

  Future<void> _onAddOwnerTapped(
    AdministrationEventAddOwner event,
    Emitter emit,
  ) async {
    await addOwnerInteractor.run(
      tournamentId: event.tournamentId,
      email: event.email,
    );
    await _updateOwners(event.tournamentId, emit);
  }

  Future<void> _deleteOwner(
    AdministrationEventDeleteOwner event,
    Emitter emit,
  ) async {
    await deleteOwnerInteractor.run(
      tournamentId: event.tournamentId,
      ownerId: event.ownerId,
    );
    _updateOwners(event.tournamentId, emit);
  }

  Future<void> _updateOwners(
    int tournamentId,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(isLoading: true),
    );
    final owners = await getAdministrationInteractor.run(
      tournamentId: tournamentId,
    );
    emit(state.copyWith(isLoading: false, owners: owners));
  }

  @override
  void emitOnError(Emitter<AdministrationState> emit) {
    emit(
      state.copyWith(
        isLoading: false,
      ),
    );
  }
}
