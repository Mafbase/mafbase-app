import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';

class ClubDescriptionEditDialog extends StatefulWidget {
  final String initialValue;

  const ClubDescriptionEditDialog._({required this.initialValue});

  static Future<String?> show({
    required BuildContext context,
    required String initialValue,
  }) {
    return showDialog<String>(
      context: context,
      builder: (_) => ClubDescriptionEditDialog._(initialValue: initialValue),
    );
  }

  @override
  State<ClubDescriptionEditDialog> createState() => _ClubDescriptionEditDialogState();
}

class _ClubDescriptionEditDialogState extends State<ClubDescriptionEditDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(width: 48),
                  Expanded(
                    child: Text(
                      'Описание клуба',
                      textAlign: TextAlign.center,
                      style: MyTheme.of(context).headerTextStyle,
                    ),
                  ),
                  const CloseButton(),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _controller,
                label: 'Описание',
                textInputType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: 6,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Сохранить',
                  onTap: () => Navigator.pop(context, _controller.text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
