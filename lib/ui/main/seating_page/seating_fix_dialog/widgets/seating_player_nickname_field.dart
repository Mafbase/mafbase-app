import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/utils.dart';

class SeatingPlayerNicknameField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<PlayerModel> onSelected;
  final ValueChanged<String> onNewPlayer;
  final VoidCallback onChanged;

  const SeatingPlayerNicknameField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSelected,
    required this.onNewPlayer,
    required this.onChanged,
  });

  @override
  State<SeatingPlayerNicknameField> createState() => _SeatingPlayerNicknameFieldState();
}

class _SeatingPlayerNicknameFieldState extends State<SeatingPlayerNicknameField> {
  List<PlayerModel> _results = [];
  String? _searchedNickname;
  bool _searchFailed = false;
  late String _text = widget.controller.text;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    if (_text == widget.controller.text) return;
    setState(() {
      _text = widget.controller.text;
      _searchedNickname = null;
      _results = [];
      _searchFailed = false;
    });
    widget.onChanged();
  }

  bool get _searchCompleted => _searchedNickname == _text.trim() && _text.trim().isNotEmpty;

  bool get _nicknameExists =>
      _searchCompleted &&
      _results.any(
        (player) => player.nickname.trim().toLowerCase() == _text.trim().toLowerCase(),
      );

  bool get _canCreate => _searchCompleted && !_nicknameExists;

  void _createPlayer() {
    if (!_canCreate) return;
    widget.onNewPlayer(_text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final message = _nicknameExists
        ? context.locale.seatingNicknameAlreadyExists
        : _searchFailed
            ? context.locale.seatingNicknameSearchFailed
            : !_searchCompleted
                ? context.locale.seatingNicknameSearchRequired
                : null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 300,
          child: Row(
            children: [
              Expanded(
                child: PlayerAutoComplete(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  label: context.locale.nicknameHint,
                  onSelected: widget.onSelected,
                  onResultsChanged: (results) => _results = results,
                  onSearchStateChanged: (isLoading, query) {
                    setState(() {
                      _searchedNickname = !isLoading ? query : null;
                      _searchFailed = !isLoading && query == null;
                    });
                  },
                ),
              ),
              IconButton(
                tooltip: context.locale.seatingCreatePlayer,
                onPressed: _canCreate ? _createPlayer : null,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        if (message != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              message,
              style: TextStyle(color: _nicknameExists || _searchFailed ? Theme.of(context).colorScheme.error : null),
            ),
          ),
      ],
    );
  }
}
