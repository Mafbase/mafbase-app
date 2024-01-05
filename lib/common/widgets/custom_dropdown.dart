import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';

String _mapToString(dynamic value) => value.toString();

class CustomDropdown<T> extends StatefulWidget {
  final Function(T? value)? onChanged;
  final T? initValue;
  final List<T?> items;
  final String Function(T? item) mapToString;
  final bool readOnly;

  const CustomDropdown({
    Key? key,
    this.onChanged,
    this.readOnly = false,
    this.mapToString = _mapToString,
    required this.items,
    required this.initValue,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  T? value;

  @override
  void didUpdateWidget(covariant CustomDropdown<T> oldWidget) {
    if (oldWidget.initValue != widget.initValue) {
      setState(() {
        value = widget.initValue;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      alignment: Alignment.center,
      style: context.theme.defaultTextStyle.copyWith(
        color: Theme.of(context).hintColor,
      ),
      items: widget.items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            widget.mapToString(item),
          ),
        );
      }).toList(),
      onChanged: widget.readOnly
          ? null
          : (newValue) {
              setState(() {
                value = newValue ?? value;
              });
              widget.onChanged?.call(newValue);
            },
    );
  }
}
