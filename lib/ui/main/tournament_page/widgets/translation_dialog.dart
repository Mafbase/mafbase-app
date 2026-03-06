import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';
import 'package:seating_generator_web/domain/models/translation_key_model.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/design_picker_dialog.dart';
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
  final TranslationRepository repository = getIt();
  late final Future<TranslationKeyModel> keyFuture;
  int table = 1;
  DesignModel? selectedDesign;

  @override
  void initState() {
    keyFuture = repository.getKey(tournamentId: widget.tournamentId);
    super.initState();
  }

  String _buildLink(String root, String path, String key, int table, DesignModel? design) {
    final base = '$root/$path?tournamentId=${widget.tournamentId}&table=$table&key=$key';
    if (design != null) return '$base&design=${design.designKey}';
    return base;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: keyFuture,
      builder: (context, snapshot) {
        final data = snapshot.data;
        final root = kIsWeb && !kDebugMode
            ? '${Uri.base.scheme}://${Uri.base.host}${Uri.base.port != 80 && Uri.base.port != 433 ? ':${Uri.base.port}' : ''}'
            : 'https://mafbase.ru';

        final defaultDesign = data?.designs.where((d) => d.designKey == 'mafbase').firstOrNull
            ?? data?.designs.firstOrNull;
        final effectiveDesign = selectedDesign ?? defaultDesign;
        final key = data?.key;
        final contentLink = _buildLink(root, 'translation', key ?? '', table, effectiveDesign);
        final controlLink = _buildLink(root, 'translationControl', key ?? '', table, effectiveDesign);

        return CustomDialog(
          child: SelectionArea(
            child: key == null
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Stack(
                    children: [
                      Padding(
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
                              if (data!.designs.isNotEmpty)
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '${context.locale.translationDesignLabel}: ',
                                          style: MyTheme.of(context).defaultTextStyle,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            final designs = data.designs;
                                            final currentIndex = effectiveDesign != null
                                                ? designs.indexWhere((d) => d.designKey == effectiveDesign.designKey)
                                                : 0;
                                            final result = await DesignPickerDialog.open(
                                              context: context,
                                              designs: designs,
                                              initialIndex: currentIndex >= 0 ? currentIndex : 0,
                                            );
                                            if (result != null) {
                                              setState(() => selectedDesign = result);
                                            }
                                          },
                                          child: Text(
                                            effectiveDesign?.title ?? '',
                                            style: MyTheme.of(context).defaultTextStyle.copyWith(
                                                  decoration: TextDecoration.underline,
                                                  color: MyTheme.of(context).blueForCard,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
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
                      Positioned(
                        top: 4,
                        left: 4,
                        child: IconButton(
                          tooltip: context.locale.translationCopyAllButton,
                          onPressed: () {
                            final buffer = StringBuffer();
                            for (var t = 1; t <= widget.tablesCount; t++) {
                              final content = _buildLink(root, 'translation', key, t, effectiveDesign);
                              final control = _buildLink(root, 'translationControl', key, t, effectiveDesign);
                              buffer.writeln(context.locale.translationCopyAllTable(t));
                              buffer.writeln('${context.locale.translationContentLink}: $content');
                              buffer.writeln('${context.locale.translationControlLink}: $control');
                              if (t < widget.tablesCount) buffer.writeln();
                            }
                            Clipboard.setData(ClipboardData(text: buffer.toString()));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(context.locale.translationCopiedSnackbar)),
                            );
                          },
                          icon: const Icon(Icons.copy),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
