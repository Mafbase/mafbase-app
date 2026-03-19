import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/tournament/ui/models/tournament_menu_models.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentMenu extends StatefulWidget {
  final List<TournamentMenuSection> sections;
  final int tournamentId;

  const TournamentMenu({
    super.key,
    required this.sections,
    required this.tournamentId,
  });

  @override
  State<TournamentMenu> createState() => _TournamentMenuState();
}

class _TournamentMenuState extends State<TournamentMenu> {
  TournamentMenuExpandableItem? _expandedItem;

  void _collapse() {
    setState(() => _expandedItem = null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      width: 240,
      color: theme.darkBlueColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Text(
              context.locale.tournamentMenuTitle,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.sections
                    .map(
                      (section) => _buildSection(
                        context,
                        section,
                        theme,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    TournamentMenuSection section,
    MyTheme theme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 8),
            child: Text(
              section.title,
              style: GoogleFonts.inter(
                color: theme.sidebarSectionTitleColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          ...section.items.map(
            (item) => switch (item) {
              TournamentMenuTapItem() => _TournamentMenuItem(
                  item: item,
                  theme: theme,
                ),
              TournamentMenuExpandableItem() => _ExpandableTournamentMenuItem(
                  item: item,
                  theme: theme,
                  expanded: _expandedItem == item,
                  onToggle: () {
                    setState(() {
                      _expandedItem = _expandedItem == item ? null : item;
                    });
                  },
                  onCollapse: _collapse,
                ),
            },
          ),
        ],
      ),
    );
  }
}

class _TournamentMenuItem extends StatelessWidget {
  final TournamentMenuTapItem item;
  final MyTheme theme;

  const _TournamentMenuItem({
    required this.item,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(8),
        hoverColor: theme.sidebarActiveItemBgColor,
        child: Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: item.selected ? theme.sidebarActiveItemBgColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                item.icon,
                color: item.selected ? Colors.white : theme.sidebarInactiveTextColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.text,
                  style: GoogleFonts.inter(
                    color: item.selected ? Colors.white : theme.sidebarInactiveTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpandableTournamentMenuItem extends StatelessWidget {
  final TournamentMenuExpandableItem item;
  final MyTheme theme;
  final bool expanded;
  final VoidCallback onToggle;
  final VoidCallback onCollapse;

  const _ExpandableTournamentMenuItem({
    required this.item,
    required this.theme,
    required this.expanded,
    required this.onToggle,
    required this.onCollapse,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(8),
            hoverColor: theme.sidebarActiveItemBgColor,
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: expanded ? theme.sidebarActiveItemBgColor : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    color: expanded ? Colors.white : theme.sidebarInactiveTextColor,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.text,
                      style: GoogleFonts.inter(
                        color: expanded ? Colors.white : theme.sidebarInactiveTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
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
          child: expanded
              ? item.contentBuilder(onCollapse)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
