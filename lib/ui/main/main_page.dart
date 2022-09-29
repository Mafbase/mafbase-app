import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/main_state.dart';
import 'package:seating_generator_web/ui/main/widgets/custom_menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  final MainPageTab? tab;
  final Widget? child;

  const MainPage({Key? key, this.tab, this.child}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                left: 160,
                top: 0,
                bottom: 0,
                right: 0,
                child: widget.child ?? Container(),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: CustomMenu(
                  models: [
                    CustomMenuItemModel(
                      SvgPicture.asset(AppAssets.contactAsset),
                      () {
                        context.read<MainBloc>().add(
                              const MainEventSwitchTab(
                                tab: MainPageTab.profileSettings,
                              ),
                            );
                      },
                      AppLocalizations.of(context)!.mainProfileHint,
                    ),
                    CustomMenuItemModel(
                      SvgPicture.asset(AppAssets.checkersAsset),
                      () {
                        context.read<MainBloc>().add(
                              const MainEventSwitchTab(
                                tab: MainPageTab.regulations,
                              ),
                            );
                      },
                      AppLocalizations.of(context)!.mainRegulationsHint,
                    ),
                    CustomMenuItemModel(
                      SvgPicture.asset(AppAssets.circledPlusAsset),
                      () {
                        context.read<MainBloc>().add(
                              const MainEventSwitchTab(
                                tab: MainPageTab.addTournament,
                              ),
                            );
                      },
                      AppLocalizations.of(context)!.mainCreateTournamentHint,
                    ),
                    if (widget.tab != null)
                      CustomMenuItemModel(
                        SvgPicture.asset(AppAssets.backArrowAsset),
                        () {
                          context.read<MainBloc>().add(
                                const MainEvent.backButtonPressed(),
                              );
                        },
                        null,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
