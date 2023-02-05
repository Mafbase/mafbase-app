import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/login/login_events.dart';
import 'package:seating_generator_web/ui/login/login_state.dart';

import '../get_it_register.dart';
import '../routers/login_router_mock.dart';

void main() {
  registerGetItTest();
  group('login bloc', () {
    test('init value test', () {
      final bloc = getIt<LoginBloc>();
      expect(bloc.state, LoginState(hasError: false));
    });

    test('test login', () async {
      final bloc = getIt<LoginBloc>();
      bloc.add(
        const LoginEvent.loginButtonTapped(
          email: "strelas",
          password: "qwerty",
          rememberMe: true,
        ),
      );

      final navigator = bloc.router as LoginPageRouterMock;
      expect(
        await navigator.mainPageOpened.first.timeout(
          const Duration(seconds: 1),
        ),
        true,
      );
    });

    test('test login with error', () async {
      final bloc = getIt<LoginBloc>();

      bloc.add(
        const LoginEvent.loginButtonTapped(
          email: "strelas",
          password: "qwertyqwer",
          rememberMe: true,
        ),
      );

      expect(
        await bloc.stream.firstWhere(
          (element) => !element.isLoading,
        ),
        LoginState(hasError: true),
      );
    });

    test('test forgot password event', () async {
      final bloc = getIt<LoginBloc>();

      bloc.add(const LoginEvent.forgotPasswordTapped());

      final navigator = bloc.router as LoginPageRouterMock;

      expect(
        await navigator.forgotPasswordPageOpened.first.timeout(
          const Duration(seconds: 1),
        ),
        true,
      );
    });

    test('remember me test', () async {
      final bloc = getIt<LoginBloc>();
      final storage = getIt<CredentialStorage>();
      await storage.cleanup();
      bloc.add(
        const LoginEvent.loginButtonTapped(
          email: "strelas",
          password: "qwerty",
          rememberMe: true,
        ),
      );

      await Future.delayed(const Duration(milliseconds: 10));
      final credential = await storage.read();
      expect(credential?.login, "strelas");
      expect(credential?.password, "qwerty");
    });

    test('remember me off', () async {
      final bloc = getIt<LoginBloc>();
      final storage = getIt<CredentialStorage>();
      await storage.cleanup();
      bloc.add(
        const LoginEvent.loginButtonTapped(
          email: "strelas",
          password: "qwerty",
          rememberMe: false,
        ),
      );

      await Future.delayed(const Duration(milliseconds: 10));
      final credential = await storage.read();
      expect(credential, null);
    });
  });
}
