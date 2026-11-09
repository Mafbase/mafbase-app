import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/translation_links/translation_table_links.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/link_actions.dart';
import 'package:seating_generator_web/utils/platform.dart';

/// Сигнатура совместима с `GoogleFonts.inter`: так меню турнира передаёт строке свой шрифт.
typedef TranslationLinksFont = TextStyle Function({double? fontSize, FontWeight? fontWeight, Color? color});

/// Ссылки стола: страницу управления можно открыть сразу, ссылку для OBS — скопировать и отправить.
class TranslationTableLinksRow extends StatelessWidget {
  final TranslationTableLinks links;
  final Color? foregroundColor;
  final TranslationLinksFont? font;

  const TranslationTableLinksRow({
    super.key,
    required this.links,
    this.foregroundColor,
    this.font,
  });

  static const _singleLineMinWidth = 440.0;

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;
    final color = foregroundColor ?? theme.textColor;

    TextStyle style({required double fontSize, FontWeight? fontWeight}) =>
        font?.call(fontSize: fontSize, fontWeight: fontWeight, color: color) ??
        theme.defaultTextStyle.copyWith(fontSize: fontSize, fontWeight: fontWeight, color: color);

    final title = Text(
      locale.translationTableTitle(links.table),
      style: style(fontSize: 13, fontWeight: FontWeight.w600),
    );
    final control = _LinkActions(
      label: locale.translationTableControl,
      labelStyle: style(fontSize: 12),
      color: color,
      actions: [
        (
          icon: Icons.copy,
          tooltip: locale.translationLinkCopy,
          onPressed: (BuildContext context) => copyLink(context, links.control, message: locale.translationLinkCopied),
        ),
        (
          icon: Icons.open_in_new,
          tooltip: locale.translationLinkOpen,
          onPressed: (BuildContext context) => openTranslationControl(context, links),
        ),
      ],
    );
    final obs = _LinkActions(
      label: locale.translationTableObs,
      labelStyle: style(fontSize: 12),
      color: color,
      actions: [
        (
          icon: Icons.copy,
          tooltip: locale.translationLinkCopy,
          onPressed: (BuildContext context) => copyLink(context, links.content, message: locale.translationLinkCopied),
        ),
        if (isWebPlatform)
          (
            icon: Icons.open_in_new,
            tooltip: locale.translationLinkOpen,
            onPressed: (BuildContext _) => openLinkInNewTab(links.content),
          )
        else
          (
            icon: Icons.share_outlined,
            tooltip: locale.translationLinkShare,
            onPressed: (BuildContext context) => shareLink(context, links.content),
          ),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= _singleLineMinWidth) {
          return Row(
            children: [
              SizedBox(width: 72, child: title),
              Expanded(child: control),
              const SizedBox(width: 12),
              Expanded(child: obs),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title, control, obs],
        );
      },
    );
  }
}

typedef _LinkAction = ({IconData icon, String tooltip, void Function(BuildContext context) onPressed});

class _LinkActions extends StatelessWidget {
  final String label;
  final TextStyle labelStyle;
  final Color color;
  final List<_LinkAction> actions;

  const _LinkActions({
    required this.label,
    required this.labelStyle,
    required this.color,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: labelStyle, overflow: TextOverflow.ellipsis),
        ),
        for (final action in actions)
          Builder(
            builder: (buttonContext) => IconButton(
              onPressed: () => action.onPressed(buttonContext),
              icon: Icon(action.icon),
              tooltip: action.tooltip,
              color: color,
              iconSize: 18,
              visualDensity: VisualDensity.compact,
            ),
          ),
      ],
    );
  }
}
