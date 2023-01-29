import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seating_generator_web/app/assets.dart';
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
  final bool isRequiredField;
  final Function(String s)? onSubmit;
  final Function(String s)? onChanged;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final bool readOnly;
  final String? Function(String? value) validate;

  const CustomTextField({
    Key? key,
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
    this.canObscure = false,
    this.isRequiredField = false,
    this.validate = _validate,
    this.onChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomTextFieldState();
  }
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText = widget.canObscure;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            if (widget.icon != null)
              Padding(
                padding: const EdgeInsets.only(
                  right: 24,
                ),
                child: widget.icon!,
              ),
            Expanded(
              child: TextFormField(
                onChanged: widget.onChanged,
                autofillHints: widget.autoFillHints,
                validator: widget.validate,
                readOnly: widget.readOnly,
                keyboardType: widget.textInputType,
                onFieldSubmitted: widget.onSubmit,
                focusNode: widget.focusNode,
                controller: widget.controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  suffixIcon: widget.suffixIcon,
                  errorText: widget.errorText,
                  errorMaxLines: 1,
                  hintText: widget.hint,
                  labelText: widget.label,
                  border: const UnderlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.canObscure)
                IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: MyTheme.of(context).borderColor,
                  ),
                ),
              const SizedBox(
                width: 10,
              ),
              if (widget.isRequiredField)
                SvgPicture.asset(
                  AppAssets.exclamationPoint,
                  height: 18,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
