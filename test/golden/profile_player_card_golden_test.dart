import 'golden_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/main/profile_page/widgets/profile_player_card.dart';

const _player = PlayerModel(
  id: 1,
  nickname: 'Белый Волк',
  fsmNickaname: 'BW2024',
);

const _playerNoFsm = PlayerModel(
  id: 2,
  nickname: 'Тень',
);

const _desktopDevices = [lightDesktop, darkDesktop];
const _mobileDevices = [lightMobile, darkMobile];

Widget _cardDesktop({
  PlayerModel? player,
  bool isUploadingPhoto = false,
  bool withEditPhoto = false,
}) =>
    themedWidget(
      ProfilePlayerCard(
        player: player,
        isMobile: false,
        onChangePlayer: () {},
        onLinkPlayer: () {},
        onEditPhoto: withEditPhoto ? () {} : null,
        isUploadingPhoto: isUploadingPhoto,
      ),
    );

Widget _cardMobile({
  PlayerModel? player,
  bool isUploadingPhoto = false,
  bool withEditPhoto = false,
}) =>
    themedWidget(
      ProfilePlayerCard(
        player: player,
        isMobile: true,
        onChangePlayer: () {},
        onLinkPlayer: () {},
        onEditPhoto: withEditPhoto ? () {} : null,
        isUploadingPhoto: isUploadingPhoto,
      ),
    );

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('ProfilePlayerCard golden tests', () {
    testGoldens('not linked — desktop', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: _desktopDevices)
        ..addScenario(widget: _cardDesktop(), name: 'not_linked');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('profile_player_card/not_linked_desktop'),
        customPump: (t) => t.pump(),
      );
    });

    testGoldens('not linked — mobile', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: _mobileDevices)
        ..addScenario(widget: _cardMobile(), name: 'not_linked');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('profile_player_card/not_linked_mobile'),
        customPump: (t) => t.pump(),
      );
    });

    testGoldens('with player, camera badge — desktop', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: _desktopDevices)
        ..addScenario(
          widget: _cardDesktop(player: _player, withEditPhoto: true),
          name: 'camera',
        );

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('profile_player_card/camera_desktop'),
        customPump: (t) => t.pump(),
      );
    });

    testGoldens('with player, camera badge — mobile', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: _mobileDevices)
        ..addScenario(
          widget: _cardMobile(player: _player, withEditPhoto: true),
          name: 'camera',
        );

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('profile_player_card/camera_mobile'),
        customPump: (t) => t.pump(),
      );
    });

    testGoldens('uploading photo — desktop', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: _desktopDevices)
        ..addScenario(
          widget: _cardDesktop(player: _player, isUploadingPhoto: true),
          name: 'uploading',
        );

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('profile_player_card/uploading_desktop'),
        customPump: (t) => t.pump(),
      );
    });

    testGoldens('uploading photo — mobile', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: _mobileDevices)
        ..addScenario(
          widget: _cardMobile(player: _player, isUploadingPhoto: true),
          name: 'uploading',
        );

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('profile_player_card/uploading_mobile'),
        customPump: (t) => t.pump(),
      );
    });

    testGoldens('with player no fsm nickname — desktop', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: _desktopDevices)
        ..addScenario(
          widget: _cardDesktop(player: _playerNoFsm, withEditPhoto: true),
          name: 'no_fsm',
        );

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('profile_player_card/no_fsm_desktop'),
        customPump: (t) => t.pump(),
      );
    });
  });
}
