import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/fade_transition_page.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/login/login_events.dart';
import 'package:seating_generator_web/ui/login/login_state.dart';
import 'package:seating_generator_web/utils.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({Key? key}) : super(key: key);

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();

  static void open({
    required BuildContext context,
    String? nextPath,
  }) =>
      context.go(
        context.namedLocation('login'),
        extra: nextPath,
      );

  static final GoRoute route = GoRoute(
    path: 'login',
    name: 'login',
    pageBuilder: (context, state) => FadeTransitionPage(
      child: BlocProvider(
        create: (context) => getIt.get<LoginBloc>(
          param1: context,
          param2: state.extra,
        ),
        child: const LoginPageBody(),
      ),
    ),
  );
}

class _LoginPageBodyState extends State<LoginPageBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
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
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 26,
              ),
              key: const Key("loginBox"),
              child: AutofillGroup(
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
                      autoFillHints: const [
                        AutofillHints.username,
                        AutofillHints.email,
                      ],
                      validate: (value) {
                        if (value != null) {
                          if (EmailValidator.validate(value)) {
                            return null;
                          }
                        }
                        return "Введите корректный адресс электронной почты";
                      },
                      controller: _emailController,
                      hint: AppLocalizations.of(context)!.loginEmailHint,
                      errorText: state.hasError
                          ? context.locale.invalidEmailOrPassword
                          : null,
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
                      autoFillHints: const [AutofillHints.password],
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() == true) {
      TextInput.finishAutofillContext();
      context.read<LoginBloc>().add(
            LoginEvent.loginButtonTapped(
              email: _emailController.text,
              password: _passwordController.text,
              rememberMe: remember,
            ),
          );
    }
  }

  void _onSignUpTapped() {
    context.read<LoginBloc>().add(const LoginEvent.signUpButtonTapped());
  }
}
