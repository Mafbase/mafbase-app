import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/domain/interactors/verification_interactor.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/fade_transition_page.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_bloc.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_events.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_state.dart';
import 'package:seating_generator_web/utils.dart';

class VerificationPageBody extends StatefulWidget {
  static const String name = 'verification';
  static GoRoute route = GoRoute(
    path: 'verification/:id',
    name: name,
    pageBuilder: (context, state) {
      final id = int.parse(state.pathParameters["id"]!);
      return FadeTransitionPage(
        child: BlocProvider<VerificationBloc>(
          create: (BuildContext context) {
            final repos = RepositoryFactory.of(context);
            return VerificationBloc(
              VerificationPageRouterImpl(context),
              VerificationInteractor(repos.authRepository),
              id,
            );
          },
          child: const VerificationPageBody(),
        ),
      );
    },
  );

  static String namedLocation(BuildContext context, int id) {
    return context.namedLocation(name, pathParameters: {'id': id.toString()});
  }

  const VerificationPageBody({super.key});

  @override
  State<VerificationPageBody> createState() => _VerificationPageBodyState();
}

class _VerificationPageBodyState extends State<VerificationPageBody> {
  TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationBloc, VerificationState>(
      builder: (context, state) {
        return Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 42,
                    right: 42,
                    bottom: 42,
                    top: 26,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          context.locale.confirmRegistration,
                          style: MyTheme.of(context).headerTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SvgPicture.asset(AppAssets.email),
                      const SizedBox(
                        height: 24,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: context.locale.verificationText,
                              style:
                                  MyTheme.of(context).defaultTextStyle.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                            ),
                            TextSpan(
                              text: context.locale.sendOneMoreCode,
                              style:
                                  MyTheme.of(context).defaultTextStyle.copyWith(
                                        fontSize: 20,
                                        decoration: TextDecoration.underline,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      CustomTextField(
                        controller: codeController,
                        hint: context.locale.enterCode,
                        errorText:
                            state.hasError ? context.locale.invalidCode : null,
                        isRequiredField: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                        text: context.locale.send,
                        disabled: state.isLoading,
                        onTap: () {
                          context.read<VerificationBloc>().add(
                                VerificationEvents.submit(
                                  token: codeController.text,
                                ),
                              );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<VerificationBloc>().add(
                                const VerificationEvents.loginButtonTapped(),
                              );
                        },
                        child: Text(
                          context.locale.authorization,
                          style: MyTheme.of(context)
                              .defaultTextStyle
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<VerificationBloc>().add(
                                const VerificationEvents.signUpButtonTapped(),
                              );
                        },
                        child: Text(
                          context.locale.loginRegistration,
                          style: MyTheme.of(context)
                              .defaultTextStyle
                              .copyWith(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (state.isLoading) const LoadingOverlayWidget(),
          ],
        );
      },
    );
  }
}
