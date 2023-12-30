import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';

class StartGameInfoDialog extends StatelessWidget {
  final int maxGame;

  const StartGameInfoDialog._({
    required this.maxGame,
  });

  static Future<int?> show({
    required BuildContext context,
    required int maxGame,
  }) {
    return showDialog(
      context: context,
      builder: (_) => StartGameInfoDialog._(
        maxGame: maxGame,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Оповещение об игре",
              style: MyTheme.of(context).headerTextStyle,
            ),
            const SizedBox(height: 24),
            FormField<int>(
              validator: (value) =>
                  value != null && value > 0 && value <= maxGame ? null : '',
              builder: (field) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropdown(
                      items: List.generate(maxGame, (index) => index + 1),
                      initValue: field.value,
                      onChanged: (value) => field.didChange(value),
                    ),
                    CustomButton(
                      text: "Отправить",
                      onTap: () {
                        Navigator.pop(context, field.value);
                      },
                      disabled: !field.validate(),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
