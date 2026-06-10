import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/utils.dart';

class AddStreamResult {
  final int tableNumber;
  final String? viewerUrl;
  final String? rtmpServerUrl;
  final String? rtmpKey;

  AddStreamResult({
    required this.tableNumber,
    this.viewerUrl,
    this.rtmpServerUrl,
    this.rtmpKey,
  });
}

class AddStreamBottomSheet extends StatefulWidget {
  const AddStreamBottomSheet({super.key});

  static Future<AddStreamResult?> show(BuildContext context) {
    return showModalBottomSheet<AddStreamResult>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => const AddStreamBottomSheet(),
    );
  }

  @override
  State<AddStreamBottomSheet> createState() => _AddStreamBottomSheetState();
}

class _AddStreamBottomSheetState extends State<AddStreamBottomSheet> {
  final _tableController = TextEditingController();
  final _viewerUrlController = TextEditingController();
  final _rtmpServerController = TextEditingController();
  final _rtmpKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _tableController.dispose();
    _viewerUrlController.dispose();
    _rtmpServerController.dispose();
    _rtmpKeyController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() == true) {
      final tableNumber = int.tryParse(_tableController.text.trim());
      if (tableNumber == null) return;

      Navigator.pop(
        context,
        AddStreamResult(
          tableNumber: tableNumber,
          viewerUrl: _viewerUrlController.text.trim().isNotEmpty ? _viewerUrlController.text.trim() : null,
          rtmpServerUrl: _rtmpServerController.text.trim().isNotEmpty ? _rtmpServerController.text.trim() : null,
          rtmpKey: _rtmpKeyController.text.trim().isNotEmpty ? _rtmpKeyController.text.trim() : null,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomPadding),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(locale.streamsAddTitle, style: theme.headerTextStyle),
                ),
                const CloseButton(),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _tableController,
              label: locale.streamsTableNumber,
              textInputType: TextInputType.number,
              validate: (value) {
                if (value == null || value.trim().isEmpty) return locale.streamsTableNumberRequired;
                if (int.tryParse(value.trim()) == null) return locale.streamsTableNumberRequired;
                return null;
              },
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: _viewerUrlController,
              label: locale.streamsViewerUrl,
              hint: 'https://',
              validate: (_) => null,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: _rtmpServerController,
              label: locale.streamsRtmpServer,
              hint: 'rtmp://',
              validate: (_) => null,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: _rtmpKeyController,
              label: locale.streamsRtmpKey,
              validate: (_) => null,
            ),
            const SizedBox(height: 24),
            CustomButton(text: locale.streamsAdd, onTap: _onSubmit),
          ],
        ),
      ),
    );
  }
}

class GenerateStreamBottomSheet extends StatefulWidget {
  const GenerateStreamBottomSheet({super.key});

  static Future<int?> show(BuildContext context) {
    return showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => const GenerateStreamBottomSheet(),
    );
  }

  @override
  State<GenerateStreamBottomSheet> createState() => _GenerateStreamBottomSheetState();
}

class _GenerateStreamBottomSheetState extends State<GenerateStreamBottomSheet> {
  final _tableController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _tableController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() == true) {
      final tableNumber = int.tryParse(_tableController.text.trim());
      if (tableNumber == null) return;
      Navigator.pop(context, tableNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomPadding),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(locale.streamsGenerateTitle, style: theme.headerTextStyle),
                ),
                const CloseButton(),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _tableController,
              label: locale.streamsTableNumber,
              textInputType: TextInputType.number,
              validate: (value) {
                if (value == null || value.trim().isEmpty) return locale.streamsTableNumberRequired;
                if (int.tryParse(value.trim()) == null) return locale.streamsTableNumberRequired;
                return null;
              },
            ),
            const SizedBox(height: 24),
            CustomButton(text: locale.streamsGenerate, onTap: _onSubmit),
          ],
        ),
      ),
    );
  }
}
