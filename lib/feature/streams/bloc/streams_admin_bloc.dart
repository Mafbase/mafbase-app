import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/repositories/stream_repository.dart';
import 'package:seating_generator_web/feature/streams/bloc/streams_admin_event.dart';
import 'package:seating_generator_web/feature/streams/bloc/streams_admin_state.dart';

class StreamsAdminBloc extends Bloc<StreamsAdminEvent, StreamsAdminState> {
  final StreamRepository _streamRepository;
  late int _tournamentId;

  StreamsAdminBloc(this._streamRepository) : super(const StreamsAdminState()) {
    on<StreamsAdminEventPageOpened>(_onPageOpened);
    on<StreamsAdminEventSetStream>(_onSetStream);
    on<StreamsAdminEventGenerateStream>(_onGenerateStream);
    on<StreamsAdminEventStopStream>(_onStopStream);
  }

  Future<void> _onPageOpened(StreamsAdminEventPageOpened event, Emitter emit) async {
    _tournamentId = event.tournamentId;
    final streams = await _streamRepository.getStreamsAdmin(tournamentId: _tournamentId);
    emit(state.copyWith(streams: streams, isLoading: false));
  }

  Future<void> _onSetStream(StreamsAdminEventSetStream event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _streamRepository.setStream(
        tournamentId: _tournamentId,
        tableNumber: event.tableNumber,
        viewerUrl: event.viewerUrl,
        rtmpServerUrl: event.rtmpServerUrl,
        rtmpKey: event.rtmpKey,
      );
      final streams = await _streamRepository.getStreamsAdmin(tournamentId: _tournamentId);
      emit(state.copyWith(streams: streams));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onGenerateStream(StreamsAdminEventGenerateStream event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _streamRepository.generateStream(tournamentId: _tournamentId, tableNumber: event.tableNumber);
      final streams = await _streamRepository.getStreamsAdmin(tournamentId: _tournamentId);
      emit(state.copyWith(streams: streams));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onStopStream(StreamsAdminEventStopStream event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _streamRepository.stopStream(tournamentId: _tournamentId, streamId: event.streamId);
      final streams = await _streamRepository.getStreamsAdmin(tournamentId: _tournamentId);
      emit(state.copyWith(streams: streams));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
