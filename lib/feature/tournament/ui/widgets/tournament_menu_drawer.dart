import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/feature/tournament/ui/models/tournament_menu_models.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_builder.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentMenuDrawer extends StatefulWidget {
  final int tournamentId;

  const TournamentMenuDrawer({
    super.key,
    required this.tournamentId,
  });

  @override
  State<TournamentMenuDrawer> createState() => _TournamentMenuDrawerState();
}

class _TournamentMenuDrawerState extends State<TournamentMenuDrawer> {
  TournamentMenuExpandableItem? _expandedItem;

  void _collapse() {
    setState(() => _expandedItem = null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Drawer(
      backgroundColor: theme.darkBlueColor,
      child: BlocSelector<SeatingPageBloc, SeatingPageState, bool>(
        selector: (state) => state.isLoading,
        builder: (context, seatingLoading) {
          return BlocBuilder<TournamentPageBloc, TournamentPageState>(
            builder: (context, state) {
              final showBill = context.read<AuthNotifier>().value.mapOrNull(
                        authorized: (model) => !model.hideBilling,
                      ) ??
                  true;
              final sections = TournamentMenuBuilder.buildSections(
                context,
                state,
                widget.tournamentId,
                showBill: showBill,
                seatingLoading: seatingLoading,
              );

              return SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              context.locale.tournamentMenuTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        children: sections
                            .expand(
                              (section) => [
                                _buildSectionTitle(section.title, theme),
                                ...section.items.map(
                                  (item) => Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: switch (item) {
                                      TournamentMenuTapItem() => _buildTapItem(context, item, theme),
                                      TournamentMenuExpandableItem() => _buildExpandableItem(context, item, theme),
                                    },
                                  ),
                                ),
                                const SafeArea(
                                  top: false,
                                  child: SizedBox(height: 4),
                                ),
                              ],
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  static Widget _buildSectionTitle(String title, MyTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 8, bottom: 4),
      child: Text(
        title,
        style: GoogleFonts.inter(
          color: theme.sidebarSectionTitleColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTapItem(
    BuildContext context,
    TournamentMenuTapItem item,
    MyTheme theme,
  ) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: item.selected ? MyTheme.of(context).darkGreyColor : Colors.transparent,
      child: InkWell(
        onTap: () {
          Scaffold.of(context).closeEndDrawer();
          if (!item.selected) item.onTap();
        },
        borderRadius: BorderRadius.circular(8),
        hoverColor: theme.sidebarActiveItemBgColor,
        child: Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(
                item.icon,
                color: item.selected ? Colors.white : theme.sidebarInactiveTextColor,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.text,
                  style: GoogleFonts.inter(
                    color: item.selected ? Colors.white : theme.sidebarInactiveTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableItem(
    BuildContext context,
    TournamentMenuExpandableItem item,
    MyTheme theme,
  ) {
    final expanded = _expandedItem?.text == item.text;

    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(8),
          color: expanded ? theme.sidebarActiveItemBgColor : Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _expandedItem = expanded ? null : item;
              });
            },
            borderRadius: BorderRadius.circular(8),
            hoverColor: theme.sidebarActiveItemBgColor,
            child: Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    color: expanded ? Colors.white : theme.sidebarInactiveTextColor,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.text,
                      style: GoogleFonts.inter(
                        color: expanded ? Colors.white : theme.sidebarInactiveTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    expanded ? Icons.expand_less : Icons.expand_more,
                    color: expanded ? Colors.white : theme.sidebarInactiveTextColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: expanded ? item.contentBuilder(_collapse) : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
