import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class WrapperLoginPage extends StatefulWidget {
  final Widget child;

  const WrapperLoginPage({
    super.key,
    required this.child,
  });

  @override
  State<WrapperLoginPage> createState() => _WrapperLoginPageState();
}

class _WrapperLoginPageState extends CustomState<WrapperLoginPage> {
  @override
  Widget? buildMobile(BuildContext context) {
    return Scaffold(
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
                      width: 140,
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                bottom: 10,
                left: 20,
                right: 20,
              ),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 520,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: MyTheme.of(context).background2,
                      border: Border.all(
                        color: MyTheme.of(context).borderColor,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                      width: 180,
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 10),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 520,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: MyTheme.of(context).background2,
                      border: Border.all(
                        color: MyTheme.of(context).borderColor,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
