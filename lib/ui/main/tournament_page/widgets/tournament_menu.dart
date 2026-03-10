import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class TournamentMenu extends StatefulWidget {
  final List<MenuItemModel> items;

  const TournamentMenu({
    super.key,
    required this.items,
  });

  @override
  State<TournamentMenu> createState() => _TournamentMenuState();
}

class _TournamentMenuState extends State<TournamentMenu> {
  @override
  Widget build(BuildContext context) => Container(
        width: 380,
        color: MyTheme.of(context).darkBlueColor,
        child: Column(
          children: widget.items
              .map(
                (e) => Material(
                  color: MyTheme.of(context).darkGreyColor,
                  child: InkWell(
                    onTap: e.onTap,
                    child: SizedBox(
                      height: 64,
                      child: Center(
                        child: Text(
                          e.text,
                          style: MyTheme.of(context).btnTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
}

class MenuItemModel {
  final String text;
  final VoidCallback onTap;

  const MenuItemModel({required this.text, required this.onTap});
}
