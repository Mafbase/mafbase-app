import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class TournamentMenu extends StatefulWidget {
  final List<MenuItemModel> items;

  const TournamentMenu({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<TournamentMenu> createState() => _TournamentMenuState();
}

class _TournamentMenuState extends State<TournamentMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: MyTheme.of(context).darkGreyColor,
              child: SingleChildScrollView(
                child: Column(
                  children: widget.items.map(
                    (e) {
                      return Material(
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
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 330,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: MyTheme.of(context).redColor,
                          child: Center(
                            child: SvgPicture.asset(AppAssets.logoAsset),
                          ),
                        ),
                      ),
                      Container(
                        height: 42,
                        color: MyTheme.of(context).darkBlueColor,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: MyTheme.of(context).greyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItemModel {
  final String text;
  final VoidCallback onTap;

  const MenuItemModel({required this.text, required this.onTap});
}
