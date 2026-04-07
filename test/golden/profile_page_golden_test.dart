import 'golden_utils.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_bloc.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_effect.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_event.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_page.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_state.dart';

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState> implements ProfileBloc {
  @override
  Stream<ProfileEffect> get effectsStream => const Stream.empty();
}

const _player = PlayerModel(
  id: 1,
  nickname: 'Белый Волк',
  fsmNickaname: 'BW2024',
);

MockProfileBloc _createMockBloc(ProfileState state) {
  final bloc = MockProfileBloc();
  whenListen(
    bloc,
    const Stream<ProfileState>.empty(),
    initialState: state,
  );
  return bloc;
}

AuthNotifier _authorizedNotifier() {
  final notifier = AuthNotifier();
  notifier.value = const AuthNotifierModel.authorized(userId: 1);
  return notifier;
}

AuthNotifier _authorizedHideBillingNotifier() {
  final notifier = AuthNotifier();
  notifier.value = const AuthNotifierModel.authorized(userId: 1, hideBilling: true);
  return notifier;
}

Widget _pageWidget(ProfileBloc bloc, AuthNotifier authNotifier) => themedWidget(
      MultiProvider(
        providers: [
          BlocProvider<ProfileBloc>.value(value: bloc),
          ChangeNotifierProvider<AuthNotifier>.value(value: authNotifier),
        ],
        child: const ProfilePage(),
      ),
    );

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('ProfilePage golden tests', () {
    testGoldens('loading state', (tester) async {
      final bloc = _createMockBloc(const ProfileState(isLoading: true));
      final authNotifier = _authorizedNotifier();
      addTearDown(bloc.close);
      addTearDown(authNotifier.dispose);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc, authNotifier), name: 'loading');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('profile_page/loading'),
        customPump: (t) => t.pump(),
      );
    });

    testGoldens('no player linked', (tester) async {
      final bloc = _createMockBloc(const ProfileState());
      final authNotifier = _authorizedNotifier();
      addTearDown(bloc.close);
      addTearDown(authNotifier.dispose);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc, authNotifier), name: 'no_player');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('profile_page/no_player'),
        customPump: (t) => t.pump(),
      );
    });

    testGoldens('with player', (tester) async {
      final bloc = _createMockBloc(const ProfileState(playerProfile: _player));
      final authNotifier = _authorizedNotifier();
      addTearDown(bloc.close);
      addTearDown(authNotifier.dispose);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc, authNotifier), name: 'with_player');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('profile_page/with_player'),
        customPump: (t) => t.pump(),
      );
    });

    testGoldens('uploading photo', (tester) async {
      final bloc = _createMockBloc(
        const ProfileState(playerProfile: _player, isUploadingPhoto: true),
      );
      final authNotifier = _authorizedNotifier();
      addTearDown(bloc.close);
      addTearDown(authNotifier.dispose);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc, authNotifier), name: 'uploading');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('profile_page/uploading'),
        customPump: (t) => t.pump(),
      );
    });

    testGoldens('billing hidden', (tester) async {
      final bloc = _createMockBloc(const ProfileState(playerProfile: _player));
      final authNotifier = _authorizedHideBillingNotifier();
      addTearDown(bloc.close);
      addTearDown(authNotifier.dispose);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc, authNotifier), name: 'billing_hidden');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('profile_page/billing_hidden'),
        customPump: (t) => t.pump(),
      );
    });
  });
}
