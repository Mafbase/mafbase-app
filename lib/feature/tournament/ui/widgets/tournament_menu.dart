import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/tournament/ui/models/tournament_menu_models.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentMenu extends StatelessWidget {
  final List<TournamentMenuSection> sections;

  const TournamentMenu({
    super.key,
    required this.sections,
  });

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
                children: sections
                    .map((section) => _buildSection(
                          context,
                          section,
                          theme,
                        ),)
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
            (item) => _TournamentMenuItem(
              item: item,
              theme: theme,
            ),
          ),
        ],
      ),
    );
  }

}

class _TournamentMenuItem extends StatelessWidget {
  final TournamentMenuItemModel item;
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
            color: item.selected
                ? theme.sidebarActiveItemBgColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                item.icon,
                color: item.selected
                    ? Colors.white
                    : theme.sidebarInactiveTextColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.text,
                  style: GoogleFonts.inter(
                    color: item.selected
                        ? Colors.white
                        : theme.sidebarInactiveTextColor,
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
