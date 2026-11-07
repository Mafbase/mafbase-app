final _gomafiaTournamentUrl = RegExp(r'https://gomafia.pro/tournament/(\d+)');

const gomafiaTournamentUrlExample = 'https://gomafia.pro/tournament/1';

bool isGomafiaTournamentUrl(String text) => _gomafiaTournamentUrl.hasMatch(text);

/// Ссылка без лишнего вокруг номера турнира — в таком виде её сохраняет и импорт рассадки с GoMafia.
String? normalizeGomafiaTournamentUrl(String text) {
  final id = _gomafiaTournamentUrl.firstMatch(text)?.group(1);
  return id == null ? null : 'https://gomafia.pro/tournament/$id';
}
