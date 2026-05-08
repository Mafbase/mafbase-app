sealed class StreamsAdminEvent {}

class StreamsAdminEventPageOpened extends StreamsAdminEvent {
  final int tournamentId;
  StreamsAdminEventPageOpened({required this.tournamentId});
}

class StreamsAdminEventSetStream extends StreamsAdminEvent {
  final int tableNumber;
  final String? viewerUrl;
  final String? rtmpServerUrl;
  final String? rtmpKey;

  StreamsAdminEventSetStream({
    required this.tableNumber,
    this.viewerUrl,
    this.rtmpServerUrl,
    this.rtmpKey,
  });
}

class StreamsAdminEventGenerateStream extends StreamsAdminEvent {
  final int tableNumber;
  StreamsAdminEventGenerateStream({required this.tableNumber});
}

class StreamsAdminEventStopStream extends StreamsAdminEvent {
  final int streamId;
  StreamsAdminEventStopStream({required this.streamId});
}
