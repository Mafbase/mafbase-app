import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/menu_button.dart';

class CustomMenu extends StatefulWidget {
  final List<CustomMenuItemModel> models;

  const CustomMenu({Key? key, required this.models}) : super(key: key);

  @override
  State<CustomMenu> createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: MyTheme.of(context).darkBlueColor,
              child: Center(
                child: Column(
                  children: [
                    ...widget.models.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 45,
                          left: 45,
                          right: 45,
                        ),
                        child: MenuButton(
                          icon: e.icon,
                          onTap: e.onTap,
                          label: e.hint,
                        ),
                      );
                    }),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 42,
            color: MyTheme.of(context).darkGreyColor,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: MyTheme.of(context).greyColor,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: MyTheme.of(context).redColor,
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

class CustomMenuItemModel {
  final Widget icon;
  final Function onTap;
  final String? hint;

  const CustomMenuItemModel(this.icon, this.onTap, this.hint);
}
