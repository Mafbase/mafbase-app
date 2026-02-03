import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/utils.dart';

class GameFilterDialog extends StatefulWidget {
  final int currentFilter;

  const GameFilterDialog({
    super.key,
    required this.currentFilter,
  });

  static Future<int?> show(BuildContext context, {required int currentFilter}) {
    return showDialog<int>(
      context: context,
      builder: (BuildContext dialogContext) => GameFilterDialog(currentFilter: currentFilter),
    );
  }

  @override
  State<GameFilterDialog> createState() => _GameFilterDialogState();
}

class _GameFilterDialogState extends State<GameFilterDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.currentFilter.toString(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.locale.ratingGameFilterTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.locale.ratingGameFilterDescription,
            style: MyTheme.of(context).defaultTextStyle,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: context.locale.ratingGameFilterHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            autofocus: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(
            context.locale.cancel,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            final gameFilter = int.tryParse(_controller.text) ?? 0;
            Navigator.of(context).pop(gameFilter);
          },
          child: Text(
            context.locale.confirm,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
