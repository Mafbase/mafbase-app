import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/add_photo_interactor.dart';
import 'package:seating_generator_web/domain/interactors/edit_player_interactor.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/profile_dialog/profile_dialog_event.dart';
import 'package:seating_generator_web/ui/profile_dialog/profile_dialog_router.dart';
import 'package:seating_generator_web/ui/profile_dialog/profile_dialog_state.dart';

class ProfileDialogBloc
    extends Bloc<ProfileDialogEvent, ProfileDialogState> {
  final BuildContext? _context;
  late final ProfileDialogRouter router = getIt(param1: _context);
  final EditPlayerInteractor _editPlayerInteractor = getIt();
  final AddPhotoInteractor _addPhotoInteractor = getIt();
  final int playerId;

  ProfileDialogBloc(PlayerModel player, [BuildContext? context])
      : playerId = player.id,
        _context = context,
        super(
          ProfileDialogState(
            imageUrl: player.imageUrl,
            isLoading: false,
          ),
        ) {
    on<ProfileDialogEventSubmit>(_onSubmit);
    on<ProfileDialogEventEditImage>(_onEditImage);
  }

  _onEditImage(ProfileDialogEventEditImage event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    await _addPhotoInteractor.run(
      bytes: event.bytes,
      filename: event.fileName,
      playerId: playerId,
    );
    router.close();
  }

  _onSubmit(ProfileDialogEventSubmit event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    await _editPlayerInteractor.run(
      PlayerModel(
        id: playerId,
        nickname: event.nickname,
        mafbankNickname:
            event.mafbankNickname.isEmpty ? null : event.mafbankNickname,
        fsmNickaname: event.fsmNickname.isEmpty ? null : event.fsmNickname,
      ),
    );
    router.close();
  }

}
