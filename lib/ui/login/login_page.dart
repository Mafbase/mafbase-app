import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class LoginPage extends StatefulWidget {
  final Widget child;

  const LoginPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.of(context).background1,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.translate(
              offset: const Offset(0, 25),
              child: SvgPicture.asset(
                AppAssets.logoAsset,
                width: 250,
              ),
            ),
            Expanded(
              child: Container(
                color: MyTheme.of(context).background2,
                width: 620,
                margin: const EdgeInsets.only(bottom: 20),
                child: widget.child,
              ),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpBox(bool loginExistError, bool emailExistError) {
    return Container(
      key: const Key("signUpBox"),
      color: Colors.blue,
    );
  }
}
