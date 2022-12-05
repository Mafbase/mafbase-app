import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/utils.dart';

class ConfirmDialog extends StatelessWidget {
  static Future<bool?> open(BuildContext context) => showDialog(
        context: context,
        builder: (context) => const ConfirmDialog(),
      );

  const ConfirmDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 300,
          height: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Text(
                context.locale.confirmText,
                style: MyTheme.of(context).defaultTextStyle,
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text(
                      context.locale.no,
                      style: MyTheme.of(context).textBtnTextStyle,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      context.locale.yes,
                      style: MyTheme.of(context).textBtnTextStyle,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
