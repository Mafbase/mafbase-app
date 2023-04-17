import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/domain/models/sign_up_model.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_bloc.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_events.dart';

import '../get_it_register.dart';
import '../repositories/auth_repository_mock.mocks.dart';
import '../routers/sign_up_router_mock.dart';
import '../util_test.dart';

void main() {
  group('SignUpTestBloc tests', () {
    registerGetItTest();
    test('test init state', () {
      final bloc = getIt<SignUpBloc>();
      final state = bloc.state;
      expect(state.isLoading, false);
      expect(state.emailExist, false);
      expect(state.weakPassword, false);
    });

    test('back button test', () async {
      final bloc = getIt<SignUpBloc>();
      final router = bloc.router as SignUpPageRouterMock;
      const event = SignUpEvents.backButtonTapped();
      final loginOpened =
          router.loginPageOpened.first.then((_) => true).timeout(
                const Duration(seconds: 1),
              );
      bloc.add(event);
      expect(await loginOpened, true);
    });

    test('Sign up tapped success test', () async {
      final bloc = getIt<SignUpBloc>();
      final authRepository = getIt<AuthRepository>() as MockAuthRepository;
      when(authRepository.signUp(any, any)).thenAnswer(
        (_) => Future.value(
          const SignUpModel(
            error: ErrorEnum.needVerification,
            id: 123,
          ),
        ),
      );
      final router = bloc.router as SignUpPageRouterMock;
      const event = SignUpEvents.signUpButtonTapped(
        email: "strelas123",
        password: "1234567",
      );
      final verificationOpened = router.verificationPageOpened.first
          .then((value) => true)
          .timeout(const Duration(seconds: 5));
      bloc.add(event);
      expect(await verificationOpened, true);
    });

    test('Sign up tapped email exist test', () async {
      final bloc = getIt<SignUpBloc>();
      final authRepository = getIt<AuthRepository>() as MockAuthRepository;
      when(authRepository.signUp(any, any)).thenAnswer(
        (_) => Future.value(
          const SignUpModel(error: ErrorEnum.emailExist),
        ),
      );
      const event = SignUpEvents.signUpButtonTapped(
        email: "strelas",
        password: "1234567",
      );
      bloc.add(event);
      await expectState(
        (data) => !data.isLoading && !data.weakPassword && data.emailExist,
        bloc.stream,
      );
    });

    test('Sign up tapped weak password test', () async {
      final bloc = getIt<SignUpBloc>();
      final authRepository = getIt<AuthRepository>() as MockAuthRepository;
      when(authRepository.signUp(any, any)).thenAnswer(
        (_) => Future.value(
          const SignUpModel(error: ErrorEnum.weakPassword),
        ),
      );
      const event = SignUpEvents.signUpButtonTapped(
        email: "strelas123",
        password: "1234",
      );
      bloc.add(event);
      await expectState(
        (data) => !data.isLoading && data.weakPassword && !data.emailExist,
        bloc.stream,
      );
    });
  });
}
