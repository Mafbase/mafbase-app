import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_event.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_state.dart';

class TranslationContentPage extends StatefulWidget {
  const TranslationContentPage({super.key});

  @override
  State<TranslationContentPage> createState() => _TranslationContentPageState();

  static const routeName = 'translation_content';

  static String createLocation({
    required BuildContext context,
    required int tournamentId,
    required int table,
  }) {
    return context.namedLocation(
      routeName,
      queryParameters: {"tournamentId": tournamentId, "table": table},
    );
  }
}

class _TranslationContentPageState extends State<TranslationContentPage> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    context
        .read<TranslationContentBloc>()
        .add(const TranslationContentEvent.pageOpened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationContentBloc, TranslationContentState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 0, 255, 0),
          body: Column(
            children: [
              const Spacer(),
              Row(
                children: List.generate(10, (index) {
                  if (!state.isNotEmpty()) {
                    return Expanded(child: Container());
                  } else {
                    return Expanded(
                      child: _TranslationPlayerCard(
                        place: index + 1,
                        nickname: state.nicknames![index],
                        image: state.images![index],
                        role: state.roles![index],
                        status: state.statuses![index],
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TranslationPlayerCard extends StatelessWidget {
  final String nickname;
  final String image;
  final PlayerRole role;
  final PlayerStatus status;
  final int place;

  const _TranslationPlayerCard({
    required this.nickname,
    required this.image,
    required this.role,
    required this.status,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    color(context) ?? const Color(0x00000000),
                    BlendMode.color,
                  ),
                  child: Image.network(
                    image.isEmpty
                        ? "https://st.depositphotos.com/1594920/2878/i/600/depositphotos_28781557-stock-photo-domestic-goose-anser-anser-domesticus.jpg"
                        : image,
                    fit: BoxFit.cover,
                    width: constraints.maxWidth,
                    height: constraints.maxWidth * 4 / 3,
                  ),
                ),
              ),
              Positioned.fill(child: _StatusOverlay(status: status)),
              Positioned(
                bottom: 4,
                left: 4,
                right: 4,
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth / 10,
                        vertical: constraints.maxWidth / 20,
                      ),
                      decoration: BoxDecoration(
                        color: MyTheme.of(context).greyColor,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: Text(
                        nickname,
                        textAlign: TextAlign.center,
                        style: MyTheme.of(context)
                            .headerTextStyle
                            .copyWith(fontSize: constraints.maxWidth / 10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: constraints.maxWidth * 4 / 3 + 8,
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth / 10,
                          vertical: constraints.maxWidth / 20,
                        ),
                        decoration: BoxDecoration(
                          color: MyTheme.of(context).greyColor,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child: Text(
                          place.toString(),
                          style: MyTheme.of(context).headerTextStyle.copyWith(
                                fontSize: constraints.maxWidth / 10,
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                left: -12,
                top: -12,
                height: constraints.maxWidth / 3,
                width: constraints.maxWidth / 3,
                child: _RoleWidget(role: role),
              ),
              Positioned(
                right: -12,
                top: -12,
                height: constraints.maxWidth / 3,
                width: constraints.maxWidth / 3,
                child: _StatusWidget(
                  status: status,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Color? color(BuildContext context) {
    switch (status) {
      case PlayerStatus.deleted:
      case PlayerStatus.killed:
      case PlayerStatus.voted:
        return MyTheme.of(context).blueForCard;
      // case PlayerStatus.killed:
      //   return MyTheme.of(context).redForCard;
      // case PlayerStatus.voted:
      //   return MyTheme.of(context).greenForCard;
      default:
        return null;
    }
  }
}

class _RoleWidget extends StatefulWidget {
  final PlayerRole role;

  const _RoleWidget({required this.role});

  @override
  State<_RoleWidget> createState() => _RoleWidgetState();
}

class _RoleWidgetState extends State<_RoleWidget>
    with TickerProviderStateMixin {
  static const Duration animationDuration = Duration(milliseconds: 300);
  late final controller = AnimationController(
    vsync: this,
    duration: animationDuration,
  );
  PlayerRole? role;

  String? get asset {
    switch (role) {
      case PlayerRole.don:
        return AppAssets.donAsset();
      case PlayerRole.maf:
        return AppAssets.mafiaAsset();
      case PlayerRole.sheriff:
        return AppAssets.sheriffAsset();
      default:
        return null;
    }
  }

  @override
  void initState() {
    role = widget.role;
    controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _RoleWidget oldWidget) {
    if (oldWidget.role != widget.role) {
      controller.animateTo(0).then((value) {
        setState(() {
          role = widget.role;
        });
        controller.forward();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final asset = this.asset;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: controller.value,
          child: child,
        );
      },
      child: asset == null ? Container() : Image.asset(asset),
    );
  }
}

class _StatusWidget extends StatefulWidget {
  final PlayerStatus status;

  const _StatusWidget({required this.status});

  @override
  State<_StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<_StatusWidget>
    with TickerProviderStateMixin {
  static const Duration animationDuration = Duration(milliseconds: 300);

  late final controller = AnimationController(
    vsync: this,
    duration: animationDuration,
  );

  PlayerStatus? oldStatus;

  String? get asset {
    switch (oldStatus ?? widget.status) {
      case PlayerStatus.deleted:
        return AppAssets.deletedStatus;
      case PlayerStatus.voted:
        return AppAssets.votedStatus;
      case PlayerStatus.killed:
        return AppAssets.killedStatus;
      default:
        return null;
    }
  }

  @override
  void initState() {
    controller.forward();
    oldStatus = widget.status;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _StatusWidget oldWidget) {
    final status = widget.status;
    if (status != oldWidget.status) {
      controller.animateTo(0).then((value) {
        setState(() {
          oldStatus = status;
        });
        controller.animateTo(1);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: controller.value,
          child: child,
        );
      },
      child: asset == null ? Container() : Image.asset(asset!),
    );
  }
}

class _StatusOverlay extends StatefulWidget {
  final PlayerStatus status;

  const _StatusOverlay({required this.status});

  @override
  State<_StatusOverlay> createState() => _StatusOverlayState();
}

class _StatusOverlayState extends State<_StatusOverlay>
    with TickerProviderStateMixin {
  static const animationDuration = Duration(milliseconds: 300);
  late final controller = AnimationController(
    vsync: this,
    duration: animationDuration,
  );

  PlayerStatus? status;

  @override
  void initState() {
    status = widget.status;
    controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _StatusOverlay oldWidget) {
    if (oldWidget.status != widget.status) {
      controller.animateTo(0).then((value) {
        setState(() {
          status = widget.status;
        });
        controller.forward();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: controller.value,
          child: child,
        );
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Transform.rotate(
            angle: pi / 4,
            child: LayoutBuilder(
              builder: (context, constraints) => Text(
                text,
                style: MyTheme.of(context).btnTextStyle.copyWith(
                  fontSize: constraints.maxWidth / 7,
                  shadows: [
                    const BoxShadow(
                      color: Colors.black,
                      blurRadius: 10,
                      spreadRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String get text {
    switch (status) {
      case PlayerStatus.deleted:
        return "Удален";
      case PlayerStatus.killed:
        return "Убит";
      case PlayerStatus.voted:
        return "Заголосован";
      default:
        return "";
    }
  }
}
