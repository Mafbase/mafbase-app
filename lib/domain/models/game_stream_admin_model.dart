class GameStreamAdminModel {
  final int id;
  final int tableNumber;
  final String? viewerUrl;
  final String? rtmpServerUrl;
  final String? rtmpKey;
  final bool active;
  final String startedAt;

  const GameStreamAdminModel({
    required this.id,
    required this.tableNumber,
    this.viewerUrl,
    this.rtmpServerUrl,
    this.rtmpKey,
    required this.active,
    required this.startedAt,
  });

  factory GameStreamAdminModel.fromJson(Map<String, dynamic> json) {
    return GameStreamAdminModel(
      id: json['id'] as int,
      tableNumber: json['tableNumber'] as int,
      viewerUrl: json['viewerUrl'] as String?,
      rtmpServerUrl: json['rtmpServerUrl'] as String?,
      rtmpKey: json['rtmpKey'] as String?,
      active: json['active'] as bool,
      startedAt: json['startedAt'] as String,
    );
  }

  bool get isMafbaseGenerated => rtmpServerUrl != null && rtmpKey != null;
}
