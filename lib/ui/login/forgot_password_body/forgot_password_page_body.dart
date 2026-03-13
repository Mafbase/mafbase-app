import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/fade_transition_page.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/login/forgot_password_body/forgot_password_bloc.dart';
import 'package:seating_generator_web/ui/login/forgot_password_body/forgot_password_events.dart';
import 'package:seating_generator_web/ui/login/forgot_password_body/forgot_password_state.dart';
import 'package:seating_generator_web/ui/login/wrapper_login_page.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class ForgotPasswordPageBody extends StatefulWidget {
  const ForgotPasswordPageBody({super.key});

  @override
  State<ForgotPasswordPageBody> createState() => _ForgotPasswordPageBodyState();

  static String createLocation({required BuildContext context}) {
    return context.namedLocation('forgotPassword');
  }

  static final route = GoRoute(
    path: 'forgotPassword',
    name: 'forgotPassword',
    pageBuilder: (context, state) => FadeTransitionPage(
      child: BlocProvider<ForgotPasswordBloc>(
        key: const Key('ForgotPasswordBlocProvider'),
        create: (context) => ForgotPasswordBloc(
          RepositoryFactory.of(context).authRepository,
          ForgotPasswordPageRouterImpl(context),
        ),
        child: const ForgotPasswordPageBody(),
      ),
    ),
  );
}

class _ForgotPasswordPageBodyState extends CustomState<ForgotPasswordPageBody> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget? buildMobile(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
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
                            context.locale.forgotPasswordTitle,
                            style: MyTheme.of(context).headerTextStyle,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          context.locale.forgotPasswordDescription,
                          textAlign: TextAlign.center,
                          style: MyTheme.of(context).defaultTextStyle.copyWith(
                                fontSize: 12,
                              ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _emailController,
                          autoFillHints: const [
                            AutofillHints.username,
                            AutofillHints.email,
                          ],
                          icon: Icon(
                            Icons.email_outlined,
                            color: MyTheme.of(context).borderColor,
                            size: 20,
                          ),
                          hint: context.locale.loginEmailHint,
                          errorText: state.hasError ? context.locale.forgotPasswordEmailNotFound : null,
                          validate: (value) {
                            if (value != null) {
                              if (EmailValidator.validate(value)) {
                                return null;
                              }
                            }
                            return context.locale.fantasyEmailInvalid;
                          },
                        ),
                        const SizedBox(height: 20),
                        ListenableBuilder(
                          listenable: _emailController,
                          builder: (context, _) => CustomButton(
                            disabled: !EmailValidator.validate(
                              _emailController.text,
                            ),
                            text: context.locale.send,
                            onTap: _onSubmit,
                            minimize: true,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              context.read<ForgotPasswordBloc>().add(
                                    const ForgotPasswordEvents.backButtonTapped(),
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
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) => WrapperLoginPage(
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
                          context.locale.forgotPasswordTitle,
                          style: MyTheme.of(context).headerTextStyle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        context.locale.forgotPasswordDescription,
                        textAlign: TextAlign.center,
                        style: MyTheme.of(context).defaultTextStyle.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      const SizedBox(height: 28),
                      CustomTextField(
                        controller: _emailController,
                        autoFillHints: const [AutofillHints.email],
                        icon: Icon(
                          Icons.email_outlined,
                          color: MyTheme.of(context).borderColor,
                          size: 20,
                        ),
                        hint: context.locale.loginEmailHint,
                        errorText: state.hasError ? context.locale.forgotPasswordEmailNotFound : null,
                        validate: (value) {
                          if (value != null) {
                            if (EmailValidator.validate(value)) {
                              return null;
                            }
                          }
                          return context.locale.fantasyEmailInvalid;
                        },
                      ),
                      const SizedBox(height: 24),
                      ListenableBuilder(
                        listenable: _emailController,
                        builder: (context, _) => CustomButton(
                          disabled: !EmailValidator.validate(
                            _emailController.text,
                          ),
                          text: context.locale.send,
                          onTap: _onSubmit,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            context.read<ForgotPasswordBloc>().add(
                                  const ForgotPasswordEvents.backButtonTapped(),
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
            if (state.isLoading)
              const Positioned.fill(
                child: LoadingOverlayWidget(),
              ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() == true) {
      TextInput.finishAutofillContext();
      context.read<ForgotPasswordBloc>().add(
            ForgotPasswordEvents.submit(email: _emailController.text),
          );
    }
  }
}
