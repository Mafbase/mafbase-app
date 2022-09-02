import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/widgets/slider.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/login/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: const Offset(0, 25),
                  child: SvgPicture.asset(AppAssets.logoAsset),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: SliderWidget(
                    child: state.when<Widget>(
                      login: _buildLoginBox,
                      signUp: _buildSignUpBox,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginBox(bool hasError) {
    return Container(
      key: Key("123"),
      color: Colors.red,
    );
  }

  Widget _buildSignUpBox(bool loginExistError, bool emailExistError) {
    return Container(
      key: Key("1234"),
      color: Colors.blue,
    );
  }
}
