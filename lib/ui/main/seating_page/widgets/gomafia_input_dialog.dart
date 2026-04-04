import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';

class GomafiaInputDialog extends StatefulWidget {
  final String? gomafiaUrl;

  const GomafiaInputDialog({
    super.key,
    this.gomafiaUrl,
  });

  @override
  State<GomafiaInputDialog> createState() => _GomafiaInputDialogState();

  static Future<int?> show(BuildContext context, [String? gomafiaUrl]) => showDialog(
        context: context,
        builder: (context) => GomafiaInputDialog(
          gomafiaUrl: gomafiaUrl,
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
                        'Укажите ссылку на турнир',
                        textAlign: TextAlign.center,
                        style: MyTheme.of(context).headerTextStyle,
                      ),
                    ),
                    const CloseButton(),
                  ],
                ),
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
                    text: 'Подтвердить',
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
