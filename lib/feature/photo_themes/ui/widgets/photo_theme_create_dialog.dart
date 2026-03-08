import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/utils.dart';

class PhotoThemeCreateDialog extends StatefulWidget {
  final String? initialName;

  const PhotoThemeCreateDialog({super.key, this.initialName});

  static Future<String?> show(BuildContext context, {String? initialName}) =>
      showDialog<String>(
        context: context,
        builder: (_) => PhotoThemeCreateDialog(initialName: initialName),
      );

  bool get isRenameMode => initialName != null;

  @override
  State<PhotoThemeCreateDialog> createState() =>
      _PhotoThemeCreateDialogState();
}

class _PhotoThemeCreateDialogState extends State<PhotoThemeCreateDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSave() {
    final name = _controller.text.trim();
    if (name.isNotEmpty) {
      Navigator.pop(context, name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text(
                widget.isRenameMode
                    ? context.locale.photoThemesRename
                    : context.locale.photoThemesCreate,
                style: MyTheme.of(context).headerTextStyle,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _controller,
                hint: context.locale.photoThemesNameHint,
                onSubmit: (_) => _onSave(),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: context.locale.photoThemesSave,
                onTap: _onSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
