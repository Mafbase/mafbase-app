import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';

class CustomAutoComplete extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String Function(PlayerModel model) displayStringForOption;
  final Function(PlayerModel model) onSelected;
  final VoidCallback onSubmit;
  final Iterable<PlayerModel> Function(TextEditingValue text) optionsBuilder;
  final String hint;
  final bool readOnly;

  const CustomAutoComplete({
    Key? key,
    required this.controller,
    required this.displayStringForOption,
    required this.focusNode,
    required this.onSelected,
    required this.onSubmit,
    required this.optionsBuilder,
    required this.hint,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<PlayerModel>(
      optionsBuilder: readOnly ? (_) => [] : optionsBuilder,
      key: key,
      textEditingController: controller,
      displayStringForOption: displayStringForOption,
      focusNode: focusNode,
      optionsViewBuilder: (
          context,
          onSelected,
          options,
          ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final PlayerModel option = options.elementAt(index);
                  return InkWell(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Builder(
                      builder: (BuildContext context) {
                        final bool highlight =
                            AutocompleteHighlightedOption.of(context) == index;
                        if (highlight) {
                          SchedulerBinding.instance
                              .addPostFrameCallback((Duration timeStamp) {
                            Scrollable.ensureVisible(context, alignment: 0.5);
                          });
                        }
                        return Container(
                          color:
                          highlight ? Theme.of(context).focusColor : null,
                          padding: const EdgeInsets.all(16.0),
                          child: Text(displayStringForOption(option)),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      onSelected: onSelected,
      fieldViewBuilder: (context, controller, focusNode, onSubmit) {
        return CustomTextField(
          readOnly: readOnly,
          focusNode: focusNode,
          controller: controller,
          label: hint,
          onSubmit: (text) {
            onSubmit();
          },
        );
      },
    );
  }
}
