import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/menu_button.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_state.dart';

class MainPage extends StatefulWidget {
  final MainPageTab? tab;

  const MainPage({Key? key, this.tab}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: Row(
            children: [
              SizedBox(
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
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 45,
                                  left: 45,
                                  right: 45,
                                ),
                                child: MenuButton(
                                  icon:
                                      SvgPicture.asset(AppAssets.contactAsset),
                                  onTap: () {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 45,
                                  left: 45,
                                  right: 45,
                                ),
                                child: MenuButton(
                                  icon:
                                      SvgPicture.asset(AppAssets.checkersAsset),
                                  onTap: () {
                                    GoRouter.of(context)
                                        .go('/${MainPageTab.regulations.name}');
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 45,
                                  left: 45,
                                  right: 45,
                                ),
                                child: MenuButton(
                                  icon: SvgPicture.asset(
                                    AppAssets.circledPlusAsset,
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              if (widget.tab != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 45,
                                    left: 45,
                                    right: 45,
                                  ),
                                  child: MenuButton(
                                    icon: SvgPicture.asset(
                                      AppAssets.backArrowAsset,
                                    ),
                                    onTap: () {
                                      GoRouter.of(context).pop();
                                    },
                                  ),
                                ),
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
              ),
              Expanded(child: Text(widget.tab?.name ?? "null")),
            ],
          ),
        );
      },
    );
  }
}
