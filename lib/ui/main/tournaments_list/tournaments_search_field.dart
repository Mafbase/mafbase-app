import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class TournamentsSearchField extends StatefulWidget {
  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final String hintText;

  const TournamentsSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.hintText,
    this.enabled = true,
  });

  @override
  State<TournamentsSearchField> createState() => _TournamentsSearchFieldState();
}

class _TournamentsSearchFieldState extends State<TournamentsSearchField> {
  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: theme.background2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
          controller: widget.controller,
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          style: theme.fieldTextStyle,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            prefixIcon: Icon(
              Icons.search,
              color: theme.greyColor,
              size: 24,
            ),
            hintText: widget.hintText,
            hintStyle: theme.hintTextStyle,
            border: InputBorder.none,
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: widget.controller,
              builder: (context, value, _) {
                if (value.text.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: IconButton(
                    icon: Icon(Icons.close, color: theme.greyColor),
                    onPressed: () {
                      widget.controller.clear();
                      widget.onClear();
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
