import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_bloc.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_event.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_state.dart';
import 'package:seating_generator_web/utils.dart';

class AddPlayerToThemeWidget extends StatefulWidget {
  const AddPlayerToThemeWidget({super.key});

  @override
  State<AddPlayerToThemeWidget> createState() => _AddPlayerToThemeWidgetState();
}

class _AddPlayerToThemeWidgetState extends State<AddPlayerToThemeWidget> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoThemesBloc, PhotoThemesState>(
      buildWhen: (prev, curr) =>
          prev.availablePlayers != curr.availablePlayers ||
          prev.selectedThemeId != curr.selectedThemeId,
      builder: (context, state) {
        if (state.selectedThemeId == null) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: SizedBox(
            width: 250,
            child: CustomAutoComplete(
              controller: _controller,
              focusNode: _focusNode,
              hint: context.locale.photoThemesAddPlayer,
              displayStringForOption: (model) => model.nickname,
              onSelected: (player) {
                if (player.id != PlayerModel.undefinedId) {
                  context.read<PhotoThemesBloc>().add(
                        PhotoThemesEventAddPlayer(playerId: player.id),
                      );
                  _controller.clear();
                }
              },
              onSubmit: () {},
              optionsBuilder: (value) {
                if (value.text.isEmpty) return [];
                final query = value.text.toLowerCase();
                return state.availablePlayers
                    .where(
                      (p) => p.nickname.toLowerCase().contains(query),
                    )
                    .take(5)
                    .toList();
              },
            ),
          ),
        );
      },
    );
  }
}
