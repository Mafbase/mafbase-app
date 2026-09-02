sealed class ClubStreamsAdminEvent {}

class ClubStreamsAdminEventPageOpened extends ClubStreamsAdminEvent {
  final int clubId;
  ClubStreamsAdminEventPageOpened({required this.clubId});
}

class ClubStreamsAdminEventSetStream extends ClubStreamsAdminEvent {
  final int tableNumber;
  final String? viewerUrl;
  final String? rtmpServerUrl;
  final String? rtmpKey;

  ClubStreamsAdminEventSetStream({
    required this.tableNumber,
    this.viewerUrl,
    this.rtmpServerUrl,
    this.rtmpKey,
  });
}

class ClubStreamsAdminEventStopStream extends ClubStreamsAdminEvent {
  final int streamId;
  ClubStreamsAdminEventStopStream({required this.streamId});
}

class ClubStreamsAdminEventRotateToken extends ClubStreamsAdminEvent {
  final int streamId;
  ClubStreamsAdminEventRotateToken({required this.streamId});
}
