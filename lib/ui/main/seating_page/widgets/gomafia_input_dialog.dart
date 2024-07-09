import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';

class GomafiaInputDialog extends StatefulWidget {
  const GomafiaInputDialog({super.key});

  @override
  State<GomafiaInputDialog> createState() => _GomafiaInputDialogState();

  static Future<int?> show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => const GomafiaInputDialog(),
      );
}

class _GomafiaInputDialogState extends State<GomafiaInputDialog> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get validate => RegExp('https:\\/\\/gomafia.pro\\/tournament\\/\\d+')
      .hasMatch(controller.value.text);

  @override
  Widget build(BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Укажите ссылку на турнир',
                  style: MyTheme.of(context).headerTextStyle,
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
                            controller.text.split('/').lastOrNull ?? '',),
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
