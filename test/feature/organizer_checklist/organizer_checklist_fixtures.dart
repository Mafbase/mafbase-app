import 'package:bloc_test/bloc_test.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_effect.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';

/// Блок чеклиста без логики: события только записываются.
class RecordingOrganizerChecklistBloc extends MockBloc<OrganizerChecklistEvent, OrganizerChecklistState>
    implements OrganizerChecklistBloc {
  RecordingOrganizerChecklistBloc(OrganizerChecklistState state, {Stream<OrganizerChecklistState>? states}) {
    whenListen(this, states ?? const Stream<OrganizerChecklistState>.empty(), initialState: state);
  }

  final added = <OrganizerChecklistEvent>[];

  @override
  int get tournamentId => 1;

  @override
  bool get isClosed => false;

  @override
  void add(OrganizerChecklistEvent event) => added.add(event);

  List<OrganizerChecklistEventSetDismissed> get dismissEvents =>
      added.whereType<OrganizerChecklistEventSetDismissed>().toList();

  int get loadCount => added.whereType<OrganizerChecklistEventLoad>().length;
}

class RecordingTournamentPageBloc extends MockBloc<TournamentPageEvent, TournamentPageState>
    implements TournamentPageBloc {
  RecordingTournamentPageBloc(TournamentPageState state, {Stream<TournamentPageState>? states}) {
    whenListen(this, states ?? const Stream<TournamentPageState>.empty(), initialState: state);
  }

  final added = <TournamentPageEvent>[];

  @override
  int get tournamentId => 1;

  @override
  void add(TournamentPageEvent event) => added.add(event);
}

class RecordingSeatingPageBloc extends MockBloc<SeatingPageEvent, SeatingPageState> implements SeatingPageBloc {
  RecordingSeatingPageBloc(SeatingPageState state, {Stream<SeatingPageState>? states}) {
    whenListen(this, states ?? const Stream<SeatingPageState>.empty(), initialState: state);
  }

  final added = <SeatingPageEvent>[];

  @override
  Stream<SeatingPageEffect> get effectsStream => const Stream.empty();

  @override
  void add(SeatingPageEvent event) => added.add(event);
}

const ownerTournament = TournamentPageState(isLoading: false, isMyTournament: true, isBillingLoaded: true);

ChecklistItemModel checklistItem(
  ChecklistKey key,
  ChecklistStatus status, {
  int? current,
  int? total,
  bool unavailable = false,
}) =>
    ChecklistItemModel(key: key, status: status, current: current, total: total, unavailable: unavailable);

/// Турнир на 20 участников: подготовка почти готова, оповещения оплачены, способ трансляции не выбран.
OrganizerChecklistModel checklistMethodNotChosen({bool isFsm = false}) => OrganizerChecklistModel(
      isFsm: isFsm,
      items: [
        checklistItem(ChecklistKey.gamesCount, ChecklistStatus.done),
        checklistItem(ChecklistKey.players, ChecklistStatus.done, current: 20),
        isFsm
            ? checklistItem(ChecklistKey.seating, ChecklistStatus.done)
            : checklistItem(ChecklistKey.seating, ChecklistStatus.warning, current: 3, total: 5),
        checklistItem(ChecklistKey.billing, ChecklistStatus.done),
        checklistItem(ChecklistKey.notifyCoverage, ChecklistStatus.warning, current: 14, total: 20),
        checklistItem(ChecklistKey.tableDescriptions, ChecklistStatus.todo, current: 0, total: 2),
        checklistItem(ChecklistKey.streamMethod, ChecklistStatus.todo),
        checklistItem(ChecklistKey.translationBilling, ChecklistStatus.todo),
        checklistItem(ChecklistKey.obsWidget, ChecklistStatus.locked),
        checklistItem(ChecklistKey.obsScenes, ChecklistStatus.locked),
        checklistItem(ChecklistKey.phoneStream, ChecklistStatus.done, current: 1, total: 2),
        checklistItem(ChecklistKey.phoneOperator, ChecklistStatus.warning, current: 1, total: 2),
      ],
    );

/// ФСМ-турнир с плашками, выбрана трансляция с телефона: пункты OBS скрыты.
OrganizerChecklistModel checklistPhoneChosen() => OrganizerChecklistModel(
      isFsm: true,
      items: [
        checklistItem(ChecklistKey.gamesCount, ChecklistStatus.done),
        checklistItem(ChecklistKey.players, ChecklistStatus.warning, current: 23),
        checklistItem(ChecklistKey.seating, ChecklistStatus.todo),
        checklistItem(ChecklistKey.billing, ChecklistStatus.done),
        checklistItem(ChecklistKey.notifyCoverage, ChecklistStatus.done, current: 23, total: 23),
        checklistItem(ChecklistKey.tableDescriptions, ChecklistStatus.warning, unavailable: true),
        checklistItem(ChecklistKey.streamMethod, ChecklistStatus.done),
        checklistItem(ChecklistKey.translationBilling, ChecklistStatus.done),
        checklistItem(ChecklistKey.obsWidget, ChecklistStatus.dismissed),
        checklistItem(ChecklistKey.obsScenes, ChecklistStatus.dismissed),
        checklistItem(ChecklistKey.phoneStream, ChecklistStatus.todo, current: 0, total: 2),
        checklistItem(ChecklistKey.phoneOperator, ChecklistStatus.todo, current: 0, total: 0),
      ],
    );

/// Бесплатный турнир без трансляции: группа «Трансляция» скрыта целиком, оплата — отдельно.
OrganizerChecklistModel checklistTranslationHidden() => OrganizerChecklistModel(
      isFsm: false,
      items: [
        checklistItem(ChecklistKey.gamesCount, ChecklistStatus.todo),
        checklistItem(ChecklistKey.players, ChecklistStatus.todo, current: 6),
        checklistItem(ChecklistKey.seating, ChecklistStatus.todo, current: 0, total: 0),
        checklistItem(ChecklistKey.billing, ChecklistStatus.dismissed),
        checklistItem(ChecklistKey.notifyCoverage, ChecklistStatus.locked),
        checklistItem(ChecklistKey.tableDescriptions, ChecklistStatus.locked),
        for (final key in ChecklistGroup.translation.keys) checklistItem(key, ChecklistStatus.dismissed),
      ],
    );
