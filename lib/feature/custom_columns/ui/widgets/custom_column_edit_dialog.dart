import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/feature/custom_columns/domain/models/custom_column_model.dart';
import 'package:seating_generator_web/feature/custom_columns/ui/widgets/formula_variables_hint.dart';
import 'package:seating_generator_web/utils.dart';

class CustomColumnEditDialog extends StatefulWidget {
  final int clubId;
  final CustomColumnModel? column;

  const CustomColumnEditDialog({
    super.key,
    required this.clubId,
    this.column,
  });

  static Future<CustomColumnEditResult?> show(
    BuildContext context, {
    required int clubId,
    CustomColumnModel? column,
  }) {
    return showDialog<CustomColumnEditResult>(
      context: context,
      builder: (context) => CustomColumnEditDialog(
        clubId: clubId,
        column: column,
      ),
    );
  }

  @override
  State<CustomColumnEditDialog> createState() => _CustomColumnEditDialogState();
}

class _CustomColumnEditDialogState extends State<CustomColumnEditDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _formulaController;
  String? _validationResult;
  bool _isValidating = false;
  bool _isValid = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.column?.title ?? '');
    _formulaController = TextEditingController(text: widget.column?.formula ?? '')..addListener(_onFormulaChanged);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _titleController.dispose();
    _formulaController.dispose();
    super.dispose();
  }

  void _onFormulaChanged() {
    _debounceTimer?.cancel();
    final text = _formulaController.text.trim();
    if (text.isEmpty) {
      setState(() {
        _validationResult = null;
        _isValid = false;
        _isValidating = false;
      });
      return;
    }
    setState(() => _isValidating = true);
    _debounceTimer = Timer(const Duration(milliseconds: 500), _validate);
  }

  Future<void> _validate() async {
    final formula = _formulaController.text.trim();
    if (formula.isEmpty) return;
    try {
      final repository = RepositoryFactory.of(context).customColumnsRepository;
      final result = await repository.validateFormula(
        clubId: widget.clubId,
        formula: formula,
      );
      if (!mounted) return;
      setState(() {
        _isValidating = false;
        _isValid = result.valid;
        _validationResult = result.valid
            ? context.locale.customColumnsFormulaValid
            : context.locale.customColumnsFormulaInvalid(
                result.error ?? '',
              );
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isValidating = false;
        _isValid = false;
        _validationResult = e.toString();
      });
    }
  }

  void _insertVariable(String variable) {
    final text = _formulaController.text;
    final selection = _formulaController.selection;
    final newText = text.replaceRange(
      selection.start,
      selection.end,
      variable,
    );
    _formulaController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: selection.start + variable.length,
      ),
    );
  }

  void _save() {
    final title = _titleController.text.trim();
    final formula = _formulaController.text.trim();
    if (title.isEmpty || formula.isEmpty) return;
    Navigator.of(context).pop(
      CustomColumnEditResult(title: title, formula: formula),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.column != null;
    return AlertDialog(
      title: Text(
        isEditing ? context.locale.customColumnsEdit : context.locale.customColumnsAdd,
      ),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _titleController,
                label: context.locale.customColumnsTitle,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _formulaController,
                label: context.locale.customColumnsFormula,
                hint: context.locale.customColumnsFormulaHint,
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              if (_isValidating)
                const SizedBox(
                  height: 20,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ],
                  ),
                )
              else if (_validationResult != null)
                Text(
                  _validationResult!,
                  style: TextStyle(
                    color: _isValid ? MyTheme.of(context).greenForCard : MyTheme.of(context).redColor,
                  ),
                ),
              const SizedBox(height: 16),
              FormulaVariablesHint(onVariableTap: _insertVariable),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        TextButton(
          onPressed: _save,
          child: Text(context.locale.customColumnsSave),
        ),
      ],
    );
  }
}

class CustomColumnEditResult {
  final String title;
  final String formula;

  const CustomColumnEditResult({
    required this.title,
    required this.formula,
  });
}
