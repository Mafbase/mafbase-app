import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/tournament/ui/models/tournament_menu_models.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_builder.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentMenuDrawer extends StatelessWidget {
  final int tournamentId;

  const TournamentMenuDrawer({
    super.key,
    required this.tournamentId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Drawer(
      backgroundColor: theme.darkBlueColor,
      child: BlocBuilder<TournamentPageBloc, TournamentPageState>(
        builder: (context, state) {
          context.watch<SeatingPageBloc>();
          final sections = TournamentMenuBuilder.buildSections(
            context,
            state,
            tournamentId,
          );

          return SafeArea(
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
                          style: GoogleFonts.inter(
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
                                padding: EdgeInsets.only(bottom: 4),
                                child: _buildItem(context, item, theme),
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
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

  static Widget _buildItem(
    BuildContext context,
    TournamentMenuItemModel item,
    MyTheme theme,
  ) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: item.selected ? MyTheme.of(context).darkGreyColor : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          item.onTap();
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
}
