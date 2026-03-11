import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/domain/interactors/sign_up_interactor.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/fade_transition_page.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_bloc.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_events.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_state.dart';
import 'package:seating_generator_web/ui/login/wrapper_login_page.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class SignUpPageBody extends StatefulWidget {
  const SignUpPageBody({super.key});

  @override
  State<SignUpPageBody> createState() => _SignUpPageBodyState();

  static String createLocation({required BuildContext context}) {
    return context.namedLocation('signUp');
  }

  static final route = GoRoute(
    path: 'signUp',
    name: 'signUp',
    pageBuilder: (context, state) => FadeTransitionPage(
      child: BlocProvider<SignUpBloc>(
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
        child: const SignUpPageBody(),
      ),
    ),
  );
}

class _SignUpPageBodyState extends CustomState<SignUpPageBody> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
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
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return WrapperLoginPage(
          child: Stack(
            children: [
              AutofillGroup(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 16,
                    bottom: 25,
                  ),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          'Регистрация',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        autoFillHints: const [
                          AutofillHints.newUsername,
                          AutofillHints.email,
                        ],
                        isRequiredField: true,
                        icon: Icon(
                          Icons.email_outlined,
                          color: MyTheme.of(context).borderColor,
                        ),
                        hint: context.locale.yourEmail,
                        errorText: state.emailExist
                            ? context.locale.wrongEmail
                            : null,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        canObscure: true,
                        isRequiredField: true,
                        controller: _passwordController,
                        autoFillHints: const [AutofillHints.newPassword],
                        icon: SvgPicture.asset(AppAssets.lock),
                        hint: context.locale.enterPassword,
                        errorText: state.weakPassword
                            ? context.locale.invalidPassword
                            : null,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        canObscure: true,
                        isRequiredField: true,
                        controller: _repeatPasswordController,
                        autoFillHints: const [AutofillHints.newPassword],
                        icon: SvgPicture.asset(AppAssets.lock),
                        hint: context.locale.repeatPassword,
                        errorText: setRepeatError
                            ? context.locale.notMatchPasswords
                            : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.exclamationPoint,
                            width: 3.2,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            context.locale.requiredForEnter,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomButton(
                        disabled: !EmailValidator.validate(
                          _emailController.text,
                        ),
                        text: 'Зарегистрироваться',
                        onTap: _onSubmit,
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
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return WrapperLoginPage(
          child: Stack(
            children: [
              AutofillGroup(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    top: 36,
                    bottom: 45,
                  ),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          'Регистрация',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        autoFillHints: const [
                          AutofillHints.newUsername,
                          AutofillHints.email,
                        ],
                        isRequiredField: true,
                        icon: Icon(
                          Icons.email_outlined,
                          color: MyTheme.of(context).borderColor,
                        ),
                        hint: context.locale.yourEmail,
                        errorText: state.emailExist
                            ? context.locale.wrongEmail
                            : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        canObscure: true,
                        isRequiredField: true,
                        controller: _passwordController,
                        autoFillHints: const [AutofillHints.newPassword],
                        icon: SvgPicture.asset(AppAssets.lock),
                        hint: context.locale.enterPassword,
                        errorText: state.weakPassword
                            ? context.locale.invalidPassword
                            : null,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        canObscure: true,
                        isRequiredField: true,
                        controller: _repeatPasswordController,
                        autoFillHints: const [AutofillHints.newPassword],
                        icon: SvgPicture.asset(AppAssets.lock),
                        hint: context.locale.repeatPassword,
                        errorText: setRepeatError
                            ? context.locale.notMatchPasswords
                            : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.exclamationPoint,
                            width: 3.2,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            context.locale.requiredForEnter,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomButton(
                        disabled: !EmailValidator.validate(
                          _emailController.text,
                        ),
                        text: 'Зарегистрироваться',
                        onTap: _onSubmit,
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
