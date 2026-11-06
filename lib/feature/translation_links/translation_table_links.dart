import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/utils/link_actions.dart';
import 'package:seating_generator_web/utils/platform.dart';

/// Собранное веб-приложение строит ссылки на свой сайт, чтобы со stage они вели на stage.
String translationLinksRoot() => kIsWeb && !kDebugMode ? translationLinksRootOf(Uri.base) : 'https://mafbase.ru';

@visibleForTesting
String translationLinksRootOf(Uri base) {
  final port = base.port != 80 && base.port != 443 ? ':${base.port}' : '';
  return '${base.scheme}://${base.host}$port';
}

/// Ссылки плашек одного стола турнира или клуба.
class TranslationTableLinks {
  final int? tournamentId;
  final int? clubId;
  final int table;
  final String key;
  final String? designKey;

  const TranslationTableLinks.tournament({
    required int this.tournamentId,
    required this.table,
    required this.key,
    this.designKey,
  }) : clubId = null;

  const TranslationTableLinks.club({
    required int this.clubId,
    required this.table,
    required this.key,
  })  : tournamentId = null,
        designKey = null;

  /// Ссылка для источника «Браузер» в OBS.
  String get content => _link('translation');

  String get control => _link('translationControl');

  TranslationControlRoute get controlRoute => TranslationControlRoute(
        tournamentId: tournamentId ?? 0,
        clubId: clubId ?? 0,
        table: table,
        translationKey: key,
      );

  String _link(String path) {
    final owner = clubId != null ? 'clubId=$clubId' : 'tournamentId=$tournamentId';
    final link = '${translationLinksRoot()}/$path?$owner&table=$table&key=$key';
    return designKey == null ? link : '$link&design=$designKey';
  }
}

/// Обе ссылки каждого стола, столы разделены пустой строкой.
String translationLinksClipboardText(AppLocalizations locale, List<TranslationTableLinks> tables) {
  final buffer = StringBuffer();
  for (final (index, links) in tables.indexed) {
    buffer.writeln(locale.translationCopyAllTable(links.table));
    buffer.writeln('${locale.translationContentLink}: ${links.content}');
    buffer.writeln('${locale.translationControlLink}: ${links.control}');
    if (index < tables.length - 1) buffer.writeln();
  }
  return buffer.toString();
}

/// В приложении страница управления открывается внутри него, в браузере — в новой вкладке.
Future<void> openTranslationControl(BuildContext context, TranslationTableLinks links) async {
  if (isWebPlatform) {
    await openLinkInNewTab(links.control);
  } else {
    await context.router.push(links.controlRoute);
  }
}
