import 'dart:async';

sealed class InfoTableDescriptionEvent {}

class InfoTableDescriptionEventInit implements InfoTableDescriptionEvent {
  final String tournamentId;

  const InfoTableDescriptionEventInit(this.tournamentId);
}

class InfoTableDescriptionEventDelete implements InfoTableDescriptionEvent {
  final int table;

  const InfoTableDescriptionEventDelete(this.table);
}

class InfoTableDescriptionEventAdd implements InfoTableDescriptionEvent {
  final int table;

  const InfoTableDescriptionEventAdd(this.table);
}

class InfoTableDescriptionEventAddWithDescription implements InfoTableDescriptionEvent {
  final int table;
  final String description;

  const InfoTableDescriptionEventAddWithDescription({required this.table, required this.description});
}

class InfoTableDescriptionEventChange implements InfoTableDescriptionEvent {
  final int table;
  final String description;

  const InfoTableDescriptionEventChange({required this.table, required this.description});
}

class InfoTableDescriptionEventSave implements InfoTableDescriptionEvent {
  final Completer<void> completer;
  final int? pendingTable;
  final String? pendingDescription;

  InfoTableDescriptionEventSave({
    Completer<void>? completer,
    this.pendingTable,
    this.pendingDescription,
  }) : completer = completer ?? Completer<void>();
}
