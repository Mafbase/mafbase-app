import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/domain/interactors/verification_interactor.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_bloc.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_events.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_state.dart';
import 'package:seating_generator_web/utils.dart';

@RoutePage()
class VerificationPageBody extends StatelessWidget {
  final int id;

  const VerificationPageBody({
    super.key,
    @PathParam('id') required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerificationBloc>(
      create: (BuildContext context) {
        final repos = RepositoryFactory.of(context);
        return VerificationBloc(
          VerificationPageRouterImpl(context),
          VerificationInteractor(repos.authRepository),
          id,
        );
      },
      child: const _VerificationPageContent(),
    );
  }
}

class _VerificationPageContent extends StatefulWidget {
  const _VerificationPageContent();

  @override
  State<_VerificationPageContent> createState() => _VerificationPageContentState();
}

class _VerificationPageContentState extends State<_VerificationPageContent> {
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
                              style: MyTheme.of(context).defaultTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            TextSpan(
                              text: context.locale.sendOneMoreCode,
                              style: MyTheme.of(context).defaultTextStyle.copyWith(
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
                        errorText: state.hasError ? context.locale.invalidCode : null,
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
                          style: MyTheme.of(context).defaultTextStyle.copyWith(fontSize: 20),
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
                          style: MyTheme.of(context).defaultTextStyle.copyWith(fontSize: 20),
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
