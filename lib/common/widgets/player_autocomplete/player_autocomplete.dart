import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete_bloc.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete_event.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';

class PlayerAutoComplete extends StatelessWidget {
  final Function(PlayerModel model) onSelected;
  final VoidCallback? onSubmit;
  final Function({required String initValue})? onNewPlayer;
  final String hint;
  final bool readOnly;
  final OptionsViewOpenDirection openDirection;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String Function(PlayerModel model)? displayStringForOption;
  final List<PlayerModel>? availablePlayers;

  const PlayerAutoComplete({
    super.key,
    required this.onSelected,
    this.onSubmit,
    this.onNewPlayer,
    required this.hint,
    this.readOnly = false,
    this.openDirection = OptionsViewOpenDirection.down,
    this.controller,
    this.focusNode,
    this.displayStringForOption,
    this.availablePlayers,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerAutoCompleteBloc>(
      create: (context) => PlayerAutoCompleteBloc(
        availablePlayers != null ? null : RepositoryFactory.of(context).playersRepository,
        availablePlayers: availablePlayers,
      ),
      child: _PlayerAutoCompleteBody(
        onSelected: onSelected,
        onSubmit: onSubmit,
        onNewPlayer: onNewPlayer,
        hint: hint,
        readOnly: readOnly,
        openDirection: openDirection,
        externalController: controller,
        externalFocusNode: focusNode,
        displayStringForOption: displayStringForOption ?? (model) => model.nickname,
      ),
    );
  }
}

class _PlayerAutoCompleteBody extends StatefulWidget {
  final Function(PlayerModel model) onSelected;
  final VoidCallback? onSubmit;
  final Function({required String initValue})? onNewPlayer;
  final String hint;
  final bool readOnly;
  final OptionsViewOpenDirection openDirection;
  final TextEditingController? externalController;
  final FocusNode? externalFocusNode;
  final String Function(PlayerModel model) displayStringForOption;

  const _PlayerAutoCompleteBody({
    required this.onSelected,
    this.onSubmit,
    this.onNewPlayer,
    required this.hint,
    required this.readOnly,
    required this.openDirection,
    this.externalController,
    this.externalFocusNode,
    required this.displayStringForOption,
  });

  @override
  State<_PlayerAutoCompleteBody> createState() => _PlayerAutoCompleteBodyState();
}

class _PlayerAutoCompleteBodyState extends State<_PlayerAutoCompleteBody> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final bool _ownsController;
  late final bool _ownsFocusNode;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.externalController == null;
    _ownsFocusNode = widget.externalFocusNode == null;
    _controller = widget.externalController ?? TextEditingController();
    _focusNode = widget.externalFocusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    if (_ownsController) _controller.dispose();
    if (_ownsFocusNode) _focusNode.dispose();
    super.dispose();
  }

  Completer<Iterable<PlayerModel>>? _completer;

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<PlayerModel>(
      optionsBuilder: widget.readOnly
          ? (_) async => []
          : (event) async {
              _completer?.complete([]);
              final completer = Completer<Iterable<PlayerModel>>();
              _completer = completer;
              final future =
                  context.read<PlayerAutoCompleteBloc>().stream.firstWhere((element) => element.query == event.text);
              context.read<PlayerAutoCompleteBloc>().add(PlayerAutoCompleteEvent.search(event.text));
              future.then((e) {
                if (completer.isCompleted) {
                  return;
                }

                completer.complete(e.results);
                _completer = null;
              });

              return [
                ...(await completer.future),
                if (widget.onNewPlayer != null && _controller.text.isNotEmpty) PlayerModel(nickname: _controller.text),
              ];
            },
      optionsViewOpenDirection: widget.openDirection,
      textEditingController: _controller,
      displayStringForOption: (model) =>
          model.id == PlayerModel.undefinedId ? '+' : widget.displayStringForOption(model),
      focusNode: _focusNode,
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: widget.openDirection == OptionsViewOpenDirection.up ? Alignment.bottomLeft : Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
              child: ListView.builder(
                reverse: widget.openDirection == OptionsViewOpenDirection.up,
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
                        final bool highlight = AutocompleteHighlightedOption.of(context) == index;
                        if (highlight) {
                          SchedulerBinding.instance.addPostFrameCallback(
                            (Duration timeStamp) {
                              Scrollable.ensureVisible(
                                context,
                                alignment: 0.5,
                              );
                            },
                          );
                        }
                        return Container(
                          color: highlight ? Theme.of(context).focusColor : null,
                          padding: const EdgeInsets.only(right: 16.0),
                          child: option.id == PlayerModel.undefinedId
                              ? const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(Icons.add),
                                )
                              : Row(
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
                                    Text(
                                      widget.displayStringForOption(option),
                                    ),
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
      onSelected: (playerModel) {
        if (playerModel.id == PlayerModel.undefinedId) {
          widget.onNewPlayer?.call(initValue: playerModel.nickname);
        } else {
          _controller.text = widget.displayStringForOption(playerModel);
          widget.onSelected(playerModel);
        }
      },
      fieldViewBuilder: (context, controller, focusNode, onSubmit) {
        return CustomTextField(
          readOnly: widget.readOnly,
          focusNode: focusNode,
          controller: controller,
          label: widget.hint,
          onSubmit: (text) {
            onSubmit();
            widget.onSubmit?.call();
          },
        );
      },
    );
  }
}
