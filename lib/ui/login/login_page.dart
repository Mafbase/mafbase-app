import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/fade_transition_page.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/login/login_body/login_body.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_bloc.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_page_body.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_page_body.dart';

class LoginPage extends StatefulWidget {
  final Widget child;

  const LoginPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();

  static final RouteBase route = ShellRoute(
    routes: [
      LoginPageBody.route,
      SignUpPageBody.route,
      VerificationPageBody.route,
    ],
    builder: (context, state, child) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<SignUpBloc>(
            key: const Key('SignUpBlocProvider'),
            create: (context) => getIt.get<SignUpBloc>(param1: context),
          )
        ],
        child: LoginPage(
          child: child,
        ),
      );
    },
  );
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyTheme.of(context).background1,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => Transform.translate(
                  offset: const Offset(0, 25),
                  child: SvgPicture.asset(
                    AppAssets.logoAsset,
                    width: constraints.maxHeight,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: MyTheme.of(context).background2,
                  border: Border.all(
                    color: MyTheme.of(context).borderColor,
                    width: 2,
                  ),
                ),
                width: 620,
                margin: const EdgeInsets.only(bottom: 20),
                child: widget.child,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
