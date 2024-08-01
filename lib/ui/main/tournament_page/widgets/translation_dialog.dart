import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TranslationDialog extends StatefulWidget {
  final int tablesCount;
  final int tournamentId;

  const TranslationDialog._({
    required this.tournamentId,
    required this.tablesCount,
  });

  static Future open({
    required BuildContext context,
    required int tournamentId,
    required int tablesCount,
  }) {
    return showDialog(
      context: context,
      builder: (_) => TranslationDialog._(
        tournamentId: tournamentId,
        tablesCount: tablesCount,
      ),
    );
  }

  @override
  State<TranslationDialog> createState() => _TranslationDialogState();
}

class _TranslationDialogState extends State<TranslationDialog> {
  int table = 1;

  @override
  Widget build(BuildContext context) {
    final root = kIsWeb && !kDebugMode
        ? '${Uri.base.scheme}://${Uri.base.host}${Uri.base.port != 80 && Uri.base.port != 433 ? ':${Uri.base.port}' : ''}'
        : 'https://mafbase.ru';
    final contentLink =
        '$root/translation?tournamentId=${widget.tournamentId}&table=$table';
    final controlLink =
        '$root/translationControl?tournamentId=${widget.tournamentId}&table=$table';

    return CustomDialog(
      child: SelectionArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    context.locale.translationDialogTitle,
                    style: MyTheme.of(context).headerTextStyle,
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Стол: ',
                        style: MyTheme.of(context).defaultTextStyle,
                      ),
                      CustomDropdown(
                        items: List.generate(
                          widget.tablesCount,
                          (index) => index + 1,
                        ),
                        initValue: table,
                        onChanged: (value) => setState(
                          () => table = value ?? table,
                        ),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    style: MyTheme.of(context).defaultTextStyle,
                    children: [
                      TextSpan(
                        text: '${context.locale.translationContentLink}\n',
                      ),
                      TextSpan(
                        text: contentLink,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: MyTheme.of(context).blueForCard,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrlString(contentLink);
                          },
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    style: MyTheme.of(context).defaultTextStyle,
                    children: [
                      TextSpan(
                        text: '${context.locale.translationControlLink}\n',
                      ),
                      TextSpan(
                        text: controlLink,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: MyTheme.of(context).blueForCard,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrlString(controlLink);
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
