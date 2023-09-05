import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';

class CustomTextInfoDialog extends StatefulWidget {
  const CustomTextInfoDialog._({super.key});

  @override
  State<CustomTextInfoDialog> createState() => _CustomTextInfoDialogState();

  static Future<String?> show({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (_) => const CustomTextInfoDialog._(),
    );
  }
}

class _CustomTextInfoDialogState extends State<CustomTextInfoDialog> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Текстовое уведомление",
              style: MyTheme.of(context).headerTextStyle,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 300,
              child: CustomTextField(
                controller: controller,
                label: "Сообщение",
              ),
            ),
            const SizedBox(height: 12),
            ListenableBuilder(
              listenable: controller,
              builder: (context, _) {
                return CustomButton(
                  text: "Отправить",
                  onTap: () => Navigator.pop(context, controller.text),
                  disabled: controller.text.isEmpty,
                  minimize: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
