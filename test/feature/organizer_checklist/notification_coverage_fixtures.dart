import 'package:bloc_test/bloc_test.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/notification_coverage_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_state.dart';

/// Блок охвата без логики: события только записываются.
class RecordingNotificationCoverageBloc extends MockBloc<NotificationCoverageEvent, NotificationCoverageState>
    implements NotificationCoverageBloc {
  RecordingNotificationCoverageBloc(NotificationCoverageState state) {
    whenListen(this, const Stream<NotificationCoverageState>.empty(), initialState: state);
  }

  final added = <NotificationCoverageEvent>[];

  @override
  int get tournamentId => 1;

  @override
  void add(NotificationCoverageEvent event) => added.add(event);

  int get loadCount => added.whereType<NotificationCoverageEventLoad>().length;
}

UnreachablePlayerModel unreachablePlayer(int id, String nickname, {bool hasFsmNickname = false}) =>
    UnreachablePlayerModel(
      player: PlayerModel(id: id, nickname: nickname, fsmNickaname: hasFsmNickname ? nickname : null),
      hasFsmNickname: hasFsmNickname,
    );

/// ФСМ-турнир на 20 участников: у 12 есть ФСМ-ник, из 8 остальных на бота подписались двое.
NotificationCoverageModel fsmCoverage() => NotificationCoverageModel(
      isFsm: true,
      total: 20,
      reachable: 14,
      telegram: 9,
      vk: 12,
      push: 4,
      unreachable: [
        unreachablePlayer(11, 'Бармалей'),
        unreachablePlayer(12, 'Вишня'),
        unreachablePlayer(13, 'Гамлет'),
        unreachablePlayer(14, 'Дюймовочка'),
        unreachablePlayer(15, 'Енот'),
        unreachablePlayer(16, 'Жасмин'),
      ],
      unavailable: false,
    );

/// Обычный турнир: оповещения приходят только подписанным на бота, ФСМ-ник не важен.
NotificationCoverageModel notFsmCoverage() => NotificationCoverageModel(
      isFsm: false,
      total: 20,
      reachable: 17,
      telegram: 17,
      vk: 0,
      push: 5,
      unreachable: [
        unreachablePlayer(21, 'Бармалей'),
        unreachablePlayer(22, 'Гамлет', hasFsmNickname: true),
        unreachablePlayer(23, 'Енот'),
      ],
      unavailable: false,
    );

/// telegram-info не ответил: подписки неизвестны, ВК и push посчитаны.
NotificationCoverageModel unavailableCoverage() => const NotificationCoverageModel(
      isFsm: true,
      total: 20,
      reachable: 0,
      telegram: 0,
      vk: 12,
      push: 4,
      unreachable: [],
      unavailable: true,
    );

/// ФСМ-турнир, где ФСМ-ник есть у всех.
NotificationCoverageModel everyoneCoverage() => const NotificationCoverageModel(
      isFsm: true,
      total: 20,
      reachable: 20,
      telegram: 6,
      vk: 20,
      push: 3,
      unreachable: [],
      unavailable: false,
    );
