import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/shared/player/data/players_repository_dependency.dart';
import 'package:seating_generator_web/shared/player/domain/interactors/add_photo_interactor.dart';
import 'package:seating_generator_web/feature/profile_dialog/domain/interactors/edit_player_interactor.dart';
import 'package:seating_generator_web/shared/player/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/profile_dialog/ui/profile_dialog_event.dart';
import 'package:seating_generator_web/feature/profile_dialog/ui/profile_dialog_router.dart';
import 'package:seating_generator_web/feature/profile_dialog/ui/profile_dialog_state.dart';

class ProfileDialogBloc extends Bloc<ProfileDialogEvent, ProfileDialogState> {
  final ProfileDialogRouter router;
  late final EditPlayerInteractor _editPlayerInteractor = EditPlayerInteractor(_scope.playersRepository);
  late final AddPhotoInteractor _addPhotoInteractor = AddPhotoInteractor(_scope.playersRepository);
  final DependencyScope _scope;
  final int playerId;

  ProfileDialogBloc({required PlayerModel player, required DependencyScope scope, required this.router})
    : playerId = player.id,
      _scope = scope,
      super(ProfileDialogState(imageUrl: player.imageUrl, isLoading: false)) {
    on<ProfileDialogEventSubmit>(_onSubmit);
    on<ProfileDialogEventEditImage>(_onEditImage);
  }

  Future<void> _onEditImage(ProfileDialogEventEditImage event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _addPhotoInteractor.run(bytes: event.bytes, filename: event.fileName, playerId: playerId);
      router.close();
    } finally {
      if (!emit.isDone) emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onSubmit(ProfileDialogEventSubmit event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _editPlayerInteractor.run(
        PlayerModel(
          id: playerId,
          nickname: event.nickname,
          mafbankNickname: event.mafbankNickname,
          fsmNickaname: event.fsmNickname,
        ),
      );
      router.close();
    } finally {
      if (!emit.isDone) emit(state.copyWith(isLoading: false));
    }
  }
}
