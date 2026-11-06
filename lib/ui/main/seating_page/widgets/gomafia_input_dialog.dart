import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/utils.dart';

class GomafiaInputDialog extends StatefulWidget {
  final String? gomafiaUrl;
  final int playersCount;

  const GomafiaInputDialog({
    super.key,
    this.gomafiaUrl,
    this.playersCount = 0,
  });

  @override
  State<GomafiaInputDialog> createState() => _GomafiaInputDialogState();

  /// [playersCount] — сколько участников уже в турнире: импорт заменит их всех.
  static Future<int?> show(
    BuildContext context, {
    String? gomafiaUrl,
    int playersCount = 0,
  }) =>
      showDialog(
        context: context,
        builder: (context) => GomafiaInputDialog(
          gomafiaUrl: gomafiaUrl,
          playersCount: playersCount,
        ),
      );
}

class _GomafiaInputDialogState extends State<GomafiaInputDialog> {
  late final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.gomafiaUrl ?? '';
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get validate => RegExp('https:\\/\\/gomafia.pro\\/tournament\\/\\d+').hasMatch(controller.value.text);

  @override
  Widget build(BuildContext context) => CustomDialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 48),
                    Expanded(
                      child: Text(
                        context.locale.gomafiaInputTitle,
                        textAlign: TextAlign.center,
                        style: MyTheme.of(context).headerTextStyle,
                      ),
                    ),
                    const CloseButton(),
                  ],
                ),
                if (widget.playersCount > 0) ...[
                  const SizedBox(height: 8),
                  _GomafiaReplaceWarning(playersCount: widget.playersCount),
                  const SizedBox(height: 8),
                ],
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'https://gomafia.pro/tournament/1',
                  ),
                ),
                const SizedBox(height: 16),
                ListenableBuilder(
                  listenable: controller,
                  builder: (context, _) => CustomButton(
                    text: context.locale.confirm,
                    onTap: () {
                      Navigator.pop(
                        context,
                        int.tryParse(
                          controller.text.split('/').lastOrNull ?? '',
                        ),
                      );
                    },
                    disabled: !validate,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _GomafiaReplaceWarning extends StatelessWidget {
  final int playersCount;

  const _GomafiaReplaceWarning({required this.playersCount});

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.redColor.withValues(alpha: 0.08),
        border: Border.all(color: theme.redColor.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, size: 20, color: theme.redColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              context.locale.gomafiaInputReplaceWarning(playersCount),
              style: theme.defaultTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
