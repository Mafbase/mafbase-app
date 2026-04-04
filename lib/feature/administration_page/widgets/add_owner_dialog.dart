import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/utils.dart';

class AddOwnerDialog extends StatefulWidget {
  final String? title;

  const AddOwnerDialog({
    super.key,
    this.title,
  });

  @override
  State<AddOwnerDialog> createState() => _AddOwnerDialogState();

  static Future<String?> open({
    required BuildContext context,
    String? title,
  }) =>
      showDialog(
        context: context,
        builder: (context) => AddOwnerDialog(title: title),
      );
}

class _AddOwnerDialogState extends State<AddOwnerDialog> {
  final FocusNode _focusNode = FocusNode();
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Container(
        width: 580,
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 40,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(width: 48),
                  Expanded(
                    child: Text(
                      widget.title ?? context.locale.ownersAddTitle,
                      textAlign: TextAlign.center,
                      style: MyTheme.of(context).headerTextStyle,
                    ),
                  ),
                  const CloseButton(),
                ],
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: CustomTextField(
                  readOnly: false,
                  focusNode: _focusNode,
                  controller: _controller,
                  label: context.locale.ownersEmail,
                  validate: (value) {
                    if (value != null) {
                      if (EmailValidator.validate(value)) {
                        return null;
                      }
                    }
                    return context.locale.ownersEmailInvalid;
                  },
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(text: context.locale.add, onTap: onSubmit),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit() {
    if (_formKey.currentState?.validate() == true) {
      Navigator.pop(context, _controller.text);
    }
  }
}
