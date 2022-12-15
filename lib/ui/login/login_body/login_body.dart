import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/login/login_events.dart';
import 'package:seating_generator_web/ui/login/login_state.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({Key? key}) : super(key: key);

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
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
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 26,
            ),
            key: const Key("loginBox"),
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
                        checkColor: MyTheme.of(context).borderColor,
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
                  disabled: state.isLoading,
                  text: AppLocalizations.of(context)!.loginIn,
                  onTap: _onSubmit,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextButton(
                  onPressed: _onSignUpTapped,
                  child: Text(
                    AppLocalizations.of(context)!.loginRegistration,
                    style: MyTheme.of(context).defaultTextStyle,
                  ),
                )
              ],
            ),
          ),
        );
      },
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

  void _onSignUpTapped() {
    context.read<LoginBloc>().add(const LoginEvent.signUpButtonTapped());
  }
}
