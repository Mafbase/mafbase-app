import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';

String _mapToString(dynamic value) => value.toString();

class CustomDropdown<T> extends StatefulWidget {
  final Function(T? value)? onChanged;
  final T? initValue;
  final List<T?> items;
  final String Function(T? item) mapToString;

  const CustomDropdown({
    Key? key,
    this.onChanged,
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
  void didChangeDependencies() {
    value = widget.initValue;
    super.didChangeDependencies();
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
      onChanged: (newValue) {
        setState(() {
          value = newValue ?? value;
        });
        widget.onChanged?.call(newValue);
      },
    );
  }
}
