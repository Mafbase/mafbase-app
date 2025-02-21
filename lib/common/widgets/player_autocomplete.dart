import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:seating_generator_web/app/assets.dart';
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
  final OptionsViewOpenDirection openDirection;

  const CustomAutoComplete({
    super.key,
    required this.controller,
    required this.displayStringForOption,
    required this.focusNode,
    required this.onSelected,
    required this.onSubmit,
    required this.optionsBuilder,
    required this.hint,
    this.openDirection = OptionsViewOpenDirection.down,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<PlayerModel>(
      optionsBuilder: readOnly ? (_) => [] : optionsBuilder,
      key: key,
      optionsViewOpenDirection: openDirection,
      textEditingController: controller,
      displayStringForOption: displayStringForOption,
      focusNode: focusNode,
      optionsViewBuilder: (
        context,
        onSelected,
        options,
      ) {
        return Align(
          alignment: openDirection == OptionsViewOpenDirection.up
              ? Alignment.bottomLeft
              : Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
              child: ListView.builder(
                reverse: openDirection == OptionsViewOpenDirection.up,
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
                          padding: const EdgeInsets.only(
                            right: 16.0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: option.imageUrl == null
                                    ? Image.asset(
                                        AppAssets.playerPhoto,
                                        fit: BoxFit.cover,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: option.imageUrl!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              const SizedBox(width: 16),
                              Text(displayStringForOption(option)),
                            ],
                          ),
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
