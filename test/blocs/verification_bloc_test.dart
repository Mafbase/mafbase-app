import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_bloc.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_events.dart';

import '../util_test.dart';

void main() {
  group('VerificationBloc tests', () {
    registerGetItTest();
    test('Test init state', () {
      final bloc = getIt<VerificationBloc>(param2: 1);
      final state = bloc.state;
      expect(state.isLoading, false);
      expect(state.hasError, false);
    });

    test('Test verification success', () async {
      final bloc = getIt<VerificationBloc>(param2: 1);
      final router = bloc.router as VerificationPageRouterMock;
      final loginPageOpened = router.mainPageOpened.first
          .then((value) => true)
          .timeout(const Duration(seconds: 1));

      bloc.add(const VerificationEvents.submit(token: '11'));
      expect(await loginPageOpened, true);
    });

    test('Test verification incorrect', () async {
      final bloc = getIt<VerificationBloc>(param2: 1);

      bloc.add(const VerificationEvents.submit(token: '22'));

      expectState((data) => !data.isLoading && data.hasError, bloc.stream);
    });
  });
}
