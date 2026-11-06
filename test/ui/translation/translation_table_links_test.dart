import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/feature/translation_links/translation_table_links.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

/// Сборка ссылок до выноса в TranslationTableLinks — из translation_panel.dart и club_translation_links_dialog.dart.
const _legacyRoot = 'https://mafbase.ru';

String _legacyTournamentLink(String path, int tournamentId, String key, int table, String? designKey) {
  final base = '$_legacyRoot/$path?tournamentId=$tournamentId&table=$table&key=$key';
  if (designKey != null) return '$base&design=$designKey';
  return base;
}

String _legacyClubLink(String path, int clubId, String key, int table) =>
    '$_legacyRoot/$path?clubId=$clubId&table=$table&key=$key';

String _legacyCopyAll(AppLocalizations locale, int tablesCount, String Function(String path, int table) link) {
  final buffer = StringBuffer();
  for (var t = 1; t <= tablesCount; t++) {
    buffer.writeln(locale.translationCopyAllTable(t));
    buffer.writeln('${locale.translationContentLink}: ${link('translation', t)}');
    buffer.writeln('${locale.translationControlLink}: ${link('translationControl', t)}');
    if (t < tablesCount) buffer.writeln();
  }
  return buffer.toString();
}

String _legacyWebRoot(Uri base) =>
    '${base.scheme}://${base.host}${base.port != 80 && base.port != 443 ? ':${base.port}' : ''}';

void main() {
  final locale = lookupAppLocalizations(const Locale('ru'));

  group('TranslationTableLinks matches the links copied before', () {
    for (final designKey in [null, 'mafbase']) {
      test('tournament, design $designKey', () {
        for (var table = 1; table <= 3; table++) {
          final links = TranslationTableLinks.tournament(
            tournamentId: 42,
            table: table,
            key: 'a1b2c3',
            designKey: designKey,
          );
          expect(links.content, _legacyTournamentLink('translation', 42, 'a1b2c3', table, designKey));
          expect(links.control, _legacyTournamentLink('translationControl', 42, 'a1b2c3', table, designKey));
        }
      });

      test('tournament clipboard text, design $designKey', () {
        final tables = [
          for (var table = 1; table <= 3; table++)
            TranslationTableLinks.tournament(tournamentId: 42, table: table, key: 'a1b2c3', designKey: designKey),
        ];
        expect(
          translationLinksClipboardText(locale, tables),
          _legacyCopyAll(locale, 3, (path, table) => _legacyTournamentLink(path, 42, 'a1b2c3', table, designKey)),
        );
      });
    }

    test('club', () {
      for (var table = 1; table <= 3; table++) {
        final links = TranslationTableLinks.club(clubId: 7, table: table, key: 'club-key');
        expect(links.content, _legacyClubLink('translation', 7, 'club-key', table));
        expect(links.control, _legacyClubLink('translationControl', 7, 'club-key', table));
      }
    });

    test('club clipboard text', () {
      final tables = [
        for (var table = 1; table <= 2; table++) TranslationTableLinks.club(clubId: 7, table: table, key: 'club-key'),
      ];
      expect(
        translationLinksClipboardText(locale, tables),
        _legacyCopyAll(locale, 2, (path, table) => _legacyClubLink(path, 7, 'club-key', table)),
      );
    });

    test('literal tournament link with design', () {
      expect(
        const TranslationTableLinks.tournament(tournamentId: 42, table: 3, key: 'k', designKey: 'mafbase').content,
        'https://mafbase.ru/translation?tournamentId=42&table=3&key=k&design=mafbase',
      );
    });
  });

  test('web root keeps scheme, host and a non-default port like before', () {
    for (final base in [
      Uri.parse('https://mafbase.ru/tournament/1'),
      Uri.parse('https://stage.mafbase.ru:8443/tournament/1?x=1'),
      Uri.parse('http://localhost:8080/#/tournament/1'),
      Uri.parse('http://mafbase.ru:80/club'),
    ]) {
      expect(translationLinksRootOf(base), _legacyWebRoot(base), reason: '$base');
    }
  });

  test('control route opens the control page of the same table', () {
    final tournamentRoute = const TranslationTableLinks.tournament(tournamentId: 42, table: 3, key: 'k').controlRoute;
    expect(tournamentRoute.args?.tournamentId, 42);
    expect(tournamentRoute.args?.clubId, 0);
    expect(tournamentRoute.args?.table, 3);
    expect(tournamentRoute.args?.translationKey, 'k');

    final clubRoute = const TranslationTableLinks.club(clubId: 7, table: 2, key: 'c').controlRoute;
    expect(clubRoute.args?.tournamentId, 0);
    expect(clubRoute.args?.clubId, 7);
  });
}
