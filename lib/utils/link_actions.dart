import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> copyLink(BuildContext context, String link, {required String message}) async {
  final messenger = ScaffoldMessenger.of(context);
  await Clipboard.setData(ClipboardData(text: link));
  messenger.showSnackBar(SnackBar(content: Text(message)));
}

/// [context] — виджет кнопки: на iPad системное меню «Поделиться» открывается рядом с ним.
Future<void> shareLink(BuildContext context, String link) {
  final box = context.findRenderObject() as RenderBox?;
  return SharePlus.instance.share(
    ShareParams(
      text: link,
      sharePositionOrigin: box == null ? null : box.localToGlobal(Offset.zero) & box.size,
    ),
  );
}

/// В вебе открывает новую вкладку, в приложении — браузер или приложение по ссылке.
Future<void> openLinkInNewTab(String link) => launchUrl(
      Uri.parse(link),
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: '_blank',
    );
