import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/domain/interactors/sign_up_interactor.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_bloc.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_events.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_state.dart';
import 'package:seating_generator_web/ui/login/wrapper_login_page.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SignUpPageBody extends StatelessWidget {
  const SignUpPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      key: const Key('SignUpBlocProvider'),
      create: (context) {
        final scope = DependencyScope.of(context);
        final repos = scope.repositoryFactory;
        return SignUpBloc(
          SignUpInteractor(repos.authRepository),
          LoginInteractor(repos.authRepository, scope.storageFactory.credentialStorage, scope.authNotifier),
          SignUpPageRouterImpl(context),
        );
      },
      child: const _SignUpPageContent(),
    );
  }
}

class _SignUpPageContent extends StatefulWidget {
  const _SignUpPageContent();

  @override
  State<_SignUpPageContent> createState() => _SignUpPageContentState();
}

class _SignUpPageContentState extends CustomState<_SignUpPageContent> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool setRepeatError = false;

  @override
  void initState() {
    _emailController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _emailController.dispose();
  }

  @override
  Widget? buildMobile(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.backOrGoToDefault()),
        title: Text(context.locale.loginRegister),
      ),
      body: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return WrapperLoginPage(
            child: Stack(
              children: [
                AutofillGroup(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          autoFillHints: const [
                            AutofillHints.newUsername,
                            AutofillHints.email,
                          ],
                          icon: Icon(
                            Icons.email_outlined,
                            color: MyTheme.of(context).borderColor,
                            size: 20,
                          ),
                          hint: context.locale.yourEmail,
                          errorText: state.emailExist ? context.locale.wrongEmail : null,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          canObscure: true,
                          controller: _passwordController,
                          autoFillHints: const [AutofillHints.newPassword],
                          icon: Icon(
                            Icons.lock_outline,
                            color: MyTheme.of(context).borderColor,
                            size: 20,
                          ),
                          hint: context.locale.enterPassword,
                          errorText: state.weakPassword ? context.locale.invalidPassword : null,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          canObscure: true,
                          controller: _repeatPasswordController,
                          autoFillHints: const [AutofillHints.newPassword],
                          icon: Icon(
                            Icons.lock_outline,
                            color: MyTheme.of(context).borderColor,
                            size: 20,
                          ),
                          hint: context.locale.repeatPassword,
                          errorText: setRepeatError ? context.locale.notMatchPasswords : null,
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          disabled: !EmailValidator.validate(
                            _emailController.text,
                          ),
                          text: context.locale.loginRegistration,
                          minimize: true,
                          onTap: _onSubmit,
                        ),
                        const SizedBox(height: 12),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: context.theme.defaultTextStyle.copyWith(
                              color: context.theme.defaultTextStyle.color?.withValues(alpha: 0.5),
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(text: context.locale.politicaAlert),
                              TextSpan(
                                text: context.locale.politicaHref,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrl(
                                      Uri.parse(
                                        'https://mafbase.ru/images/politika.pdf',
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
                        Center(
                          child: TextButton(
                            onPressed: () {
                              context.read<SignUpBloc>().add(
                                    const SignUpEvents.backButtonTapped(),
                                  );
                            },
                            child: Text(
                              context.locale.authorization,
                              style: MyTheme.of(context).defaultTextStyle.copyWith(
                                    color: MyTheme.of(context).darkGreyColor,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.isLoading) const LoadingOverlayWidget(),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.backOrGoToDefault()),
        title: Text(context.locale.loginRegister),
      ),
      body: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return WrapperLoginPage(
            child: Stack(
              children: [
                AutofillGroup(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          autoFillHints: const [
                            AutofillHints.newUsername,
                            AutofillHints.email,
                          ],
                          icon: Icon(
                            Icons.email_outlined,
                            color: MyTheme.of(context).borderColor,
                            size: 20,
                          ),
                          hint: context.locale.yourEmail,
                          errorText: state.emailExist ? context.locale.wrongEmail : null,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          canObscure: true,
                          controller: _passwordController,
                          autoFillHints: const [AutofillHints.newPassword],
                          icon: Icon(
                            Icons.lock_outline,
                            color: MyTheme.of(context).borderColor,
                            size: 20,
                          ),
                          hint: context.locale.enterPassword,
                          errorText: state.weakPassword ? context.locale.invalidPassword : null,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          canObscure: true,
                          controller: _repeatPasswordController,
                          autoFillHints: const [AutofillHints.newPassword],
                          icon: Icon(
                            Icons.lock_outline,
                            color: MyTheme.of(context).borderColor,
                            size: 20,
                          ),
                          hint: context.locale.repeatPassword,
                          errorText: setRepeatError ? context.locale.notMatchPasswords : null,
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          disabled: !EmailValidator.validate(
                            _emailController.text,
                          ),
                          text: context.locale.loginRegistration,
                          onTap: _onSubmit,
                        ),
                        const SizedBox(height: 12),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: context.theme.defaultTextStyle.copyWith(
                              color: context.theme.defaultTextStyle.color?.withValues(alpha: 0.5),
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
                                        'https://mafbase.ru/images/politika.pdf',
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
                        const SizedBox(height: 16),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              context.read<SignUpBloc>().add(
                                    const SignUpEvents.backButtonTapped(),
                                  );
                            },
                            child: Text(
                              context.locale.authorization,
                              style: MyTheme.of(context).defaultTextStyle.copyWith(
                                    color: MyTheme.of(context).darkGreyColor,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.isLoading) const LoadingOverlayWidget(),
              ],
            ),
          );
        },
      ),
    );
  }

  _onSubmit() {
    if (_passwordController.text != _repeatPasswordController.text) {
      setState(() {
        setRepeatError = true;
      });
    } else {
      TextInput.finishAutofillContext();
      context.read<SignUpBloc>().add(
            SignUpEvents.signUpButtonTapped(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }
}
