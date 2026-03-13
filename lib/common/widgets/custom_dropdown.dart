import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';

String _mapToString(dynamic value) => value.toString();

class CustomDropdown<T> extends StatefulWidget {
  final Function(T? value)? onChanged;
  final T? initValue;
  final List<T?> items;
  final String Function(T? item) mapToString;
  final bool readOnly;
  final bool expand;

  const CustomDropdown({
    super.key,
    this.onChanged,
    this.readOnly = false,
    this.mapToString = _mapToString,
    this.expand = true,
    required this.items,
    required this.initValue,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  T? value;

  @override
  void initState() {
    value = widget.initValue;
    super.initState();
  }

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
    final theme = context.theme;

    return SizedBox(
      width: widget.expand ? double.infinity : null,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.readOnly ? theme.background1 : theme.background2,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: theme.borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              icon: Text(
                '▾',
                style: TextStyle(
                  fontSize: 20,
                  color: theme.darkGreyColor,
                ),
              ),
              style: theme.defaultTextStyle.copyWith(
                color: widget.readOnly ? theme.greyColor : Colors.black,
              ),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(8),
              elevation: 4,
              menuMaxHeight: 240,
              items: widget.items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(widget.mapToString(item)),
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
            ),
          ),
        ),
      ),
    );
  }
}
