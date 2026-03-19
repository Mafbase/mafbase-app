import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';
import 'package:seating_generator_web/utils.dart';

class SeparationsSection extends StatelessWidget {
  final List<Pair<PlayerModel, PlayerModel>> pairs;
  final VoidCallback onAdd;
  final void Function(int index) onDelete;

  const SeparationsSection({
    super.key,
    required this.pairs,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;
    final count = pairs.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: theme.borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onPressed: () => _openSeparationsSheet(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count > 0 ? '${locale.seatingSeparations} ($count)' : locale.seatingSeparations,
              style: theme.defaultTextStyle,
            ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, size: 20, color: theme.greyColor),
          ],
        ),
      ),
    );
  }

  void _openSeparationsSheet(BuildContext context) {
    final locale = context.locale;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        final theme = MyTheme.of(context);

        return BlocProvider.value(
          value: context.read<SeatingPageBloc>(),
          child: BlocSelector<SeatingPageBloc, SeatingPageState, List<Pair<PlayerModel, PlayerModel>>>(
            selector: (state) => state.cannotMeet,
            builder: (context, pairs) => DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.3,
              maxChildSize: 0.85,
              expand: false,
              builder: (context, scrollController) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        Text(
                          locale.seatingSeparations,
                          style: theme.defaultTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  if (pairs.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          locale.addSeparationBtnText,
                          style: theme.defaultTextStyle.copyWith(color: theme.greyColor),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemCount: pairs.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 6),
                        itemBuilder: (context, index) {
                          final pair = pairs[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: theme.background2,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: theme.borderColor),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    pair.first.nickname,
                                    style: theme.defaultTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: theme.greyColor,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    pair.second.nickname,
                                    style: theme.defaultTextStyle,
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    showDialog<bool>(
                                      context: ctx,
                                      builder: (_) => const ConfirmDialog(),
                                    ).then((value) {
                                      if (value == true) {
                                        onDelete(index);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.delete_outline,
                                      size: 20,
                                      color: theme.redColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: onAdd,
                          icon: const Icon(Icons.add),
                          label: Text(locale.addSeparationBtnText),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
