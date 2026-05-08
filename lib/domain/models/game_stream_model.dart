class GameStreamModel {
  final int id;
  final int tableNumber;
  final String? viewerUrl;
  final bool active;
  final String startedAt;

  const GameStreamModel({
    required this.id,
    required this.tableNumber,
    this.viewerUrl,
    required this.active,
    required this.startedAt,
  });

  factory GameStreamModel.fromJson(Map<String, dynamic> json) {
    return GameStreamModel(
      id: json['id'] as int,
      tableNumber: json['tableNumber'] as int,
      viewerUrl: json['viewerUrl'] as String?,
      active: json['active'] as bool,
      startedAt: json['startedAt'] as String,
    );
  }
}
