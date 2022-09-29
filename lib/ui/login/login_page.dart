import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/login/login_events.dart';
import 'package:seating_generator_web/ui/login/login_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool remember = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: MyTheme.of(context).background1,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(0, 25),
                    child: SvgPicture.asset(
                      AppAssets.logoAsset,
                      width: 250,
                    ),
                  ),
                  Container(
                    color: MyTheme.of(context).background2,
                    width: 620,
                    child: state.when<Widget>(
                      login: _buildLoginBox,
                      signUp: _buildSignUpBox,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginBox(bool hasError, bool isLoading) {
    return Builder(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 26,
          ),
          key: const Key("loginBox"),
          decoration: BoxDecoration(
            border: Border.all(
              color: MyTheme.of(context).borderColor,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.loginAuth,
                style: MyTheme.of(context).headerTextStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _emailController,
                hint: AppLocalizations.of(context)!.loginEmailHint,
                focusNode: _emailFocusNode,
                onSubmit: (_) {
                  _emailFocusNode.unfocus();
                  _passwordFocusNode.requestFocus();
                },
                icon: Icon(
                  Icons.email_outlined,
                  color: MyTheme.of(context).borderColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                hint: AppLocalizations.of(context)!.loginPasswordHint,
                onSubmit: (_) {
                  _onSubmit();
                },
                canObscure: true,
                icon: Icon(
                  Icons.lock_outline,
                  color: MyTheme.of(context).borderColor,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Transform.translate(
                    offset: const Offset(-3, 0),
                    child: Checkbox(
                      splashRadius: 0,
                      value: remember,
                      checkColor: MyTheme.of(context).checkColor,
                      fillColor: MaterialStatePropertyAll(
                        MyTheme.of(context).borderColor,
                      ),
                      onChanged: (value) {
                        setState(() {
                          remember = value ?? remember;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    AppLocalizations.of(context)!.loginRememberMe,
                    style: MyTheme.of(context).defaultTextStyle,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.loginForgotPassword,
                      style: MyTheme.of(context).defaultTextStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              CustomButton(
                disabled: isLoading,
                text: AppLocalizations.of(context)!.loginIn,
                onTap: _onSubmit,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSignUpBox(bool loginExistError, bool emailExistError) {
    return Container(
      key: const Key("signUpBox"),
      color: Colors.blue,
    );
  }

  void _onSubmit() {
    context.read<LoginBloc>().add(
          LoginEvent.loginButtonTapped(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }
}
