import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/di/storage_factory.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/fade_transition_page.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/login/login_events.dart';
import 'package:seating_generator_web/ui/login/login_state.dart';
import 'package:seating_generator_web/ui/login/forgot_password_body/forgot_password_page_body.dart';
import 'package:seating_generator_web/ui/login/reset_password_body/reset_password_page_body.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_page_body.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_page_body.dart';
import 'package:seating_generator_web/ui/login/wrapper_login_page.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();

  static String createLocation({
    required BuildContext context,
    String? nextPath,
  }) =>
      context.namedLocation(
        'login',
        queryParameters: {
          if (nextPath != null) 'next': nextPath,
        },
      );

  static final GoRoute route = GoRoute(
    path: '/auth',
    name: 'login',
    routes: [
      SignUpPageBody.route,
      VerificationPageBody.route,
      ForgotPasswordPageBody.route,
      ResetPasswordPageBody.route,
    ],
    pageBuilder: (context, state) => FadeTransitionPage(
      child: BlocProvider(
        create: (context) {
          final scope = DependencyScope.of(context);
          final repos = scope.repositoryFactory;
          final storages = scope.storageFactory;
          return LoginBloc(
            LoginInteractor(repos.authRepository, storages.credentialStorage, scope.authNotifier),
            LoginPageRouterImpl(context, state.uri.queryParameters['next']),
          );
        },
        child: const LoginPageBody(),
      ),
    ),
  );
}

class _LoginPageBodyState extends CustomState<LoginPageBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget buildMobile(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return WrapperLoginPage(
          child: Form(
            key: _formKey,
            child: Container(
              key: const Key("loginBox"),
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.loginAuth,
                        style: MyTheme.of(context).headerTextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      key: const Key("login_field"),
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
                        return "Введите корректный адрес электронной почты";
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
                      key: const Key("password_field"),
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
                      height: 15,
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(
                                  const LoginEvent.forgotPasswordTapped(),
                                );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.loginForgotPassword,
                            style: MyTheme.of(context).defaultTextStyle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    CustomButton(
                      disabled: state.isLoading,
                      key: const Key("auth_button"),
                      text: AppLocalizations.of(context)!.loginIn,
                      minimize: true,
                      onTap: _onSubmit,
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: context.theme.defaultTextStyle.copyWith(
                          color: context.theme.defaultTextStyle.color
                              ?.withValues(alpha: 0.5),
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(text: context.locale.politicaAlert),
                          TextSpan(
                            text: context.locale.politicaHref,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(
                                  Uri.parse(
                                    // TODO: replace
                                    "https://mafbase.ru/images/politika.pdf",
                                  ),
                                );
                              },
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextButton(
                      onPressed: _onSignUpTapped,
                      child: Text(
                        AppLocalizations.of(context)!.loginRegistration,
                        style: MyTheme.of(context).defaultTextStyle,
                      ),
                    ),
                    if (state.isLoading)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(),
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

  @override
  Widget buildDesktop(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return WrapperLoginPage(
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.loginAuth,
                        style: MyTheme.of(context).headerTextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      key: const Key("login_field"),
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
                        return "Введите корректный адрес электронной почты";
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
                      key: const Key("password_field"),
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
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(
                                  const LoginEvent.forgotPasswordTapped(),
                                );
                          },
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
                      key: const Key("auth_button"),
                      text: AppLocalizations.of(context)!.loginIn,
                      onTap: _onSubmit,
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: context.theme.defaultTextStyle.copyWith(
                          color: context.theme.defaultTextStyle.color
                              ?.withValues(alpha: 0.5),
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(text: context.locale.politicaAlert),
                          TextSpan(
                            text: context.locale.politicaHref,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(
                                  Uri.parse(
                                    // TODO: replace
                                    "https://mafbase.ru/images/politika.pdf",
                                  ),
                                );
                              },
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: _onSignUpTapped,
                      child: Text(
                        AppLocalizations.of(context)!.loginRegistration,
                        style: MyTheme.of(context).defaultTextStyle,
                      ),
                    ),
                    if (state.isLoading)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(),
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
            ),
          );
    }
  }

  void _onSignUpTapped() {
    context.read<LoginBloc>().add(const LoginEvent.signUpButtonTapped());
  }
}
