import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/repositories/stream_repository.dart';
import 'package:seating_generator_web/feature/club_streams/bloc/club_streams_admin_event.dart';
import 'package:seating_generator_web/feature/club_streams/bloc/club_streams_admin_state.dart';

class ClubStreamsAdminBloc extends Bloc<ClubStreamsAdminEvent, ClubStreamsAdminState> {
  final StreamRepository _streamRepository;
  late int _clubId;

  ClubStreamsAdminBloc(this._streamRepository) : super(const ClubStreamsAdminState()) {
    on<ClubStreamsAdminEventPageOpened>(_onPageOpened);
    on<ClubStreamsAdminEventSetStream>(_onSetStream);
    on<ClubStreamsAdminEventStopStream>(_onStopStream);
    on<ClubStreamsAdminEventRotateToken>(_onRotateToken);
  }

  Future<void> _onPageOpened(ClubStreamsAdminEventPageOpened event, Emitter emit) async {
    _clubId = event.clubId;
    try {
      final streams = await _streamRepository.getClubStreamsAdmin(clubId: _clubId);
      emit(state.copyWith(streams: streams));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onSetStream(ClubStreamsAdminEventSetStream event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _streamRepository.setClubStream(
        clubId: _clubId,
        tableNumber: event.tableNumber,
        viewerUrl: event.viewerUrl,
        rtmpServerUrl: event.rtmpServerUrl,
        rtmpKey: event.rtmpKey,
      );
      final streams = await _streamRepository.getClubStreamsAdmin(clubId: _clubId);
      emit(state.copyWith(streams: streams));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onStopStream(ClubStreamsAdminEventStopStream event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _streamRepository.stopClubStream(clubId: _clubId, streamId: event.streamId);
      final streams = await _streamRepository.getClubStreamsAdmin(clubId: _clubId);
      emit(state.copyWith(streams: streams));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onRotateToken(ClubStreamsAdminEventRotateToken event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _streamRepository.rotateClubStreamToken(clubId: _clubId, streamId: event.streamId);
      final streams = await _streamRepository.getClubStreamsAdmin(clubId: _clubId);
      emit(state.copyWith(streams: streams));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
