import 'dart:typed_data';

sealed class PhotoThemesEvent {}

class PhotoThemesEventInit implements PhotoThemesEvent {
  final int? tournamentId;

  const PhotoThemesEventInit({this.tournamentId});
}

class PhotoThemesEventSelectTheme implements PhotoThemesEvent {
  final int themeId;

  const PhotoThemesEventSelectTheme({required this.themeId});
}

class PhotoThemesEventCreateTheme implements PhotoThemesEvent {
  final String name;

  const PhotoThemesEventCreateTheme({required this.name});
}

class PhotoThemesEventRenameTheme implements PhotoThemesEvent {
  final int themeId;
  final String name;

  const PhotoThemesEventRenameTheme({
    required this.themeId,
    required this.name,
  });
}

class PhotoThemesEventDeleteTheme implements PhotoThemesEvent {
  final int themeId;

  const PhotoThemesEventDeleteTheme({required this.themeId});
}

class PhotoThemesEventUploadPhoto implements PhotoThemesEvent {
  final int themeId;
  final int playerId;
  final Uint8List bytes;
  final String filename;

  const PhotoThemesEventUploadPhoto({
    required this.themeId,
    required this.playerId,
    required this.bytes,
    required this.filename,
  });
}

class PhotoThemesEventDeletePhoto implements PhotoThemesEvent {
  final int themeId;
  final int playerId;

  const PhotoThemesEventDeletePhoto({
    required this.themeId,
    required this.playerId,
  });
}

class PhotoThemesEventAddPlayer implements PhotoThemesEvent {
  final int playerId;

  const PhotoThemesEventAddPlayer({required this.playerId});
}

class PhotoThemesEventAddFromTournament implements PhotoThemesEvent {
  final int tournamentId;

  const PhotoThemesEventAddFromTournament({required this.tournamentId});
}

class PhotoThemesEventRemovePlayer implements PhotoThemesEvent {
  final int playerId;

  const PhotoThemesEventRemovePlayer({required this.playerId});
}
