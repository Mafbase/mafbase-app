import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class WrapperLoginPage extends StatefulWidget {
  final Widget child;

  const WrapperLoginPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<WrapperLoginPage> createState() => _WrapperLoginPageState();
}

class _WrapperLoginPageState extends CustomState<WrapperLoginPage> {
  @override
  Widget buildDesktop(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyTheme.of(context).background1,
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: LayoutBuilder(
                builder: (context, constraints) => Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Transform.translate(
                    offset: const Offset(0, 25),
                    child: SvgPicture.asset(
                      AppAssets.logoAsset,
                      width: 200,
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 10),
              sliver: SliverToBoxAdapter(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        constraints: const BoxConstraints(
                          maxWidth: 600,
                        ),
                        decoration: BoxDecoration(
                          color: MyTheme.of(context).background2,
                          border: Border.all(
                            color: MyTheme.of(context).borderColor,
                            width: 2,
                          ),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            debugPrint(constraints.toString());
                            return widget.child;
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
