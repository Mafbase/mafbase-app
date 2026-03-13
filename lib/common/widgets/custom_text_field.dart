import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

String? _validate(String? value) => null;

class CustomTextField extends StatefulWidget {
  final Widget? icon;
  final TextEditingController controller;
  final Iterable<String>? autoFillHints;
  final bool canObscure;
  final String? errorText;
  final Widget? suffixIcon;
  final String? hint;
  final String? label;
  final Function(String s)? onSubmit;
  final Function(String s)? onChanged;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final String? Function(String? value) validate;
  final int? maxLines;

  const CustomTextField({
    super.key,
    this.icon,
    this.label,
    this.textInputType,
    this.readOnly = false,
    required this.controller,
    this.suffixIcon,
    this.hint,
    this.onSubmit,
    this.errorText,
    this.focusNode,
    this.autoFillHints,
    this.textInputAction,
    this.canObscure = false,
    this.validate = _validate,
    this.onChanged,
    this.maxLines,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomTextFieldState();
  }
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText = widget.canObscure;

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final hasError = widget.errorText != null;

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: theme.borderColor,
        width: 1.5,
      ),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: theme.redColor,
        width: 1.5,
      ),
    );

    return TextFormField(
      scrollPadding: const EdgeInsets.all(50),
      onChanged: widget.onChanged,
      autofillHints: widget.autoFillHints,
      validator: widget.validate,
      readOnly: widget.readOnly,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onSubmit,
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: obscureText,
      maxLines: widget.maxLines ?? 1,
      minLines: 1,
      style: theme.fieldTextStyle,
      decoration: InputDecoration(
        prefixIcon: widget.icon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 14, right: 10),
                child: widget.icon,
              )
            : null,
        prefixIconConstraints: widget.icon != null ? const BoxConstraints(minWidth: 44, minHeight: 20) : null,
        suffixIcon: _buildSuffixIcon(),
        errorText: widget.errorText,
        errorMaxLines: 1,
        errorStyle: TextStyle(
          color: theme.redColor,
          fontSize: 12,
        ),
        hintText: widget.hint,
        labelText: widget.label,
        hintStyle: TextStyle(color: theme.hintColor),
        filled: false,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: outlineBorder,
        enabledBorder: hasError ? errorBorder : outlineBorder,
        focusedBorder: outlineBorder.copyWith(
          borderSide: BorderSide(
            color: theme.darkGreyColor,
            width: 1.5,
          ),
        ),
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    final theme = MyTheme.of(context);

    if (widget.canObscure) {
      return IconButton(
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        icon: Icon(
          obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: theme.borderColor,
          size: 20,
        ),
      );
    }

    return widget.suffixIcon;
  }
}
