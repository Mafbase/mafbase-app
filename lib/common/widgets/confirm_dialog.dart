import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/utils.dart';

class ConfirmDialog extends StatelessWidget {
  final String? text;

  static Future<bool?> open(BuildContext context, [String? text]) => showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
          text: text,
        ),
      );

  const ConfirmDialog({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(width: 48),
                  Expanded(
                    child: Text(
                      context.locale.confirmText,
                      textAlign: TextAlign.center,
                      style: MyTheme.of(context).headerTextStyle,
                    ),
                  ),
                  const CloseButton(),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              if (text != null)
                Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: context.theme.defaultTextStyle,
                ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        isRed: true,
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        text: context.locale.yes,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                        text: context.locale.no,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
