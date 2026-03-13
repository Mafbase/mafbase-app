import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/fade_transition_page.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/domain/models/password_reset_model.dart';
import 'package:seating_generator_web/ui/login/reset_password_body/reset_password_bloc.dart';
import 'package:seating_generator_web/ui/login/reset_password_body/reset_password_events.dart';
import 'package:seating_generator_web/ui/login/reset_password_body/reset_password_state.dart';
import 'package:seating_generator_web/ui/login/wrapper_login_page.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class ResetPasswordPageBody extends StatefulWidget {
  const ResetPasswordPageBody({super.key});

  @override
  State<ResetPasswordPageBody> createState() => _ResetPasswordPageBodyState();

  static String createLocation({
    required BuildContext context,
    required String email,
  }) {
    return context.namedLocation(
      'resetPassword',
      queryParameters: {
        'email': email,
      },
    );
  }

  static final route = GoRoute(
    path: 'resetPassword',
    name: 'resetPassword',
    redirect: (context, state) {
      if (state.uri.queryParameters['email'] == null) {
        return '/';
      }

      return null;
    },
    pageBuilder: (context, state) {
      final email = state.uri.queryParameters['email'] ?? '';

      return FadeTransitionPage(
        child: BlocProvider<ResetPasswordBloc>(
          key: const Key('ResetPasswordBlocProvider'),
          create: (context) {
            final scope = DependencyScope.of(context);
            final repos = scope.repositoryFactory;
            return ResetPasswordBloc(
              repos.authRepository,
              LoginInteractor(repos.authRepository, scope.storageFactory.credentialStorage, scope.authNotifier),
              ResetPasswordPageRouterImpl(context),
              email,
            );
          },
          child: const ResetPasswordPageBody(),
        ),
      );
    },
  );
}

class _ResetPasswordPageBodyState extends CustomState<ResetPasswordPageBody> {
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool setRepeatError = false;

  @override
  void dispose() {
    _tokenController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget? buildMobile(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            context.locale.resetPasswordTitle,
                            style: MyTheme.of(context).headerTextStyle,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          context.locale.resetPasswordDescription,
                          textAlign: TextAlign.center,
                          style: MyTheme.of(context).defaultTextStyle.copyWith(
                                fontSize: 12,
                              ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _tokenController,
                          hint: context.locale.resetPasswordTokenHint,
                          errorText: state.error == ResetPasswordError.invalidToken
                              ? context.locale.resetPasswordInvalidToken
                              : null,
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
                          errorText:
                              state.error == ResetPasswordError.weakPassword ? context.locale.invalidPassword : null,
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
                          disabled: _tokenController.text.isEmpty ||
                              _passwordController.text.isEmpty ||
                              _passwordController.text.length < 8,
                          text: context.locale.save,
                          minimize: true,
                          onTap: _onSubmit,
                        ),
                        const SizedBox(height: 14),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              context.read<ResetPasswordBloc>().add(
                                    const ResetPasswordEvents.backButtonTapped(),
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
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        return WrapperLoginPage(
          child: Stack(
            children: [
              AutofillGroup(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            context.locale.resetPasswordTitle,
                            style: MyTheme.of(context).headerTextStyle,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          context.locale.resetPasswordDescription,
                          textAlign: TextAlign.center,
                          style: MyTheme.of(context).defaultTextStyle.copyWith(
                                fontSize: 14,
                              ),
                        ),
                        const SizedBox(height: 28),
                        CustomTextField(
                          controller: _tokenController,
                          hint: context.locale.resetPasswordTokenHint,
                          errorText: state.error == ResetPasswordError.invalidToken
                              ? context.locale.resetPasswordInvalidToken
                              : null,
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
                          errorText:
                              state.error == ResetPasswordError.weakPassword ? context.locale.invalidPassword : null,
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
                        ListenableBuilder(
                          listenable: Listenable.merge(
                            [_tokenController, _passwordController],
                          ),
                          builder: (_, __) => CustomButton(
                            disabled: _tokenController.text.isEmpty ||
                                _passwordController.text.isEmpty ||
                                _passwordController.text.length < 8,
                            text: context.locale.save,
                            onTap: _onSubmit,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              context.read<ResetPasswordBloc>().add(
                                    const ResetPasswordEvents.backButtonTapped(),
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
              ),
              if (state.isLoading) const LoadingOverlayWidget(),
            ],
          ),
        );
      },
    );
  }

  void _onSubmit() {
    if (_passwordController.text != _repeatPasswordController.text) {
      setState(() {
        setRepeatError = true;
      });
      return;
    }

    if (_formKey.currentState?.validate() == true) {
      TextInput.finishAutofillContext();
      final bloc = context.read<ResetPasswordBloc>();
      bloc.add(
        ResetPasswordEvents.submit(
          token: _tokenController.text,
          email: bloc.email,
          newPassword: _passwordController.text,
        ),
      );
    }
  }
}
