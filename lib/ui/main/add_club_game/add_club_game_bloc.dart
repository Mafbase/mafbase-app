import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/data/storages/prefer_add_game_settings_storage.dart';
import 'package:seating_generator_web/domain/interactors/add_club_game_interactor.dart';
import 'package:seating_generator_web/domain/interactors/create_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/edit_tournament_game_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_all_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_ci_schemes_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_club_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournament_game_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournament_interactor.dart';
import 'package:seating_generator_web/domain/models/ci_scheme_model.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_effect.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_event.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_router.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_state.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/add_player_dialog.dart';

class AddClubGameBloc extends Bloc<AddClubGameEvent, AddClubGameState>
    with EffectEmitter<AddClubGameEffect, AddClubGameState> {
  final GetAllPlayersInteractor _getAllPlayersInteractor = getIt();
  final AddClubGameInteractor _addClubGameInteractor = getIt();
  final ClubRepository _repository = getIt();
  final int? clubId;
  final int? tournamentId;
  final BuildContext? _context;
  late final AddClubGameRouter router = getIt(param1: _context);
  final CreatePlayerInteractor _createPlayerInteractor = getIt();
  final GetCiSchemesInteractor _getCiSchemesInteractor = getIt();
  final GetClubInteractor _getClubInteractor = getIt();
  final EditTournamentGameInteractor _editTournamentGameInteractor = getIt();
  final GetTournamentGameInteractor _getTournamentGameInteractor = getIt();
  final GetTournamentInteractor _getTournamentInteractor = getIt();
  final TournamentsRepository _tournamentsRepository = getIt();
  final PreferAddGameSettingsStorage _settingsStorage =
      PreferAddGameSettingsStorageImpl();

  AddClubGameBloc({
    this.clubId,
    this.tournamentId,
    BuildContext? context,
  })  : assert((clubId == null) != (tournamentId == null)),
        _context = context,
        super(AddClubGameState(isTournament: tournamentId != null)) {
    on<AddClubGameEventPageOpened>(_onPageOpened);
    on<AddClubGameEventSubmit>(_onSubmit);
    on<AddClubGameEventPageEdit>(_onEdit);
    on<AddClubGameEventNewPlayer>(_onNewPlayer);
    on<AddClubGameEventNewGame>(_onNewGame);
    on<AddClubGameEventDeleteGame>(_onDeleteGame);
  }

  _onDeleteGame(
    AddClubGameEventDeleteGame event,
    Emitter emit,
  ) async {
    if (clubId == null) {
      return;
    }

    await _repository.deleteGame(gameId: event.gameId, clubId: clubId!);
    router.pop();
  }

  _onNewGame(AddClubGameEventNewGame event, Emitter emit) async {
    if (clubId == null) {
      return;
    }
    router.openNewGame(clubId!, event.dateTime);
  }

  _onNewPlayer(AddClubGameEventNewPlayer event, Emitter emit) async {
    if (_context == null) {
      return;
    }

    final newPlayer = await AddPlayerDialog.open(
      context: _context!,
      availablePlayers: state.players,
      initValue: event.nickname,
    );

    if (newPlayer == null) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    final id = await _createPlayerInteractor.run(playerModel: newPlayer);
    final players = await _getAllPlayersInteractor.run();
    emit(state.copyWith(players: players));
    emitEffect(
      AddClubGameEffect.setPlayer(
        index: event.index,
        player: players.firstWhere(
          (element) => element.id == id,
        ),
      ),
    );
    emit(state.copyWith(isLoading: false));
  }

  _onEdit(AddClubGameEventPageEdit event, Emitter emit) {
    router.editPage(
      clubId,
      tournamentId,
      event.gameId,
    );
  }

  _onSubmit(
    AddClubGameEventSubmit event,
    Emitter emit,
  ) async {
    if (event.gameResult.hasRatingScheme()) {
      _settingsStorage.saveScheme(event.gameResult.ratingScheme);
    }

    emit(state.copyWith(isLoading: true));
    if (clubId != null) {
      int? gameId;
      if (event.gameId == null) {
        gameId = await _addClubGameInteractor.run(
          clubId: clubId!,
          result: event.gameResult,
        );
      } else {
        await _repository.editGame(event.gameResult, clubId!, event.gameId!);
      }
      router.openGame(clubId!, gameId ?? event.gameId!);
    } else {
      await _editTournamentGameInteractor.call(
        tournamentId: tournamentId!,
        gameId: event.gameId!,
        result: event.gameResult,
      );
      router.pop();
    }
    emit(state.copyWith(isLoading: false));
  }

  _onPageOpened(
    AddClubGameEventPageOpened event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    if (clubId != null) {
      final list = await Future.wait([
        _getAllPlayersInteractor.run(),
        _repository.isOwner(clubId!),
        _getClubInteractor.run(clubId: clubId!),
        _getCiSchemesInteractor.run(),
      ]);
      final players = list[0] as List<PlayerModel>;
      final isOwner = list[1] as bool;
      final club = list[2] as ClubModel;
      final ciSchemes = list[3] as List<CiSchemeModel>;
      if (!event.viewOnly && !isOwner) {
        router.openLoginPage();
        return;
      }

      emit(
        state.copyWith(
          isLoading: event.gameId != null,
          players: players,
          canEdit: isOwner,
          clubName: club.name,
          ciSchemes: ciSchemes,
        ),
      );
      if (event.gameId != null) {
        final game = await _repository.getGame(event.gameId!, clubId!);
        emitEffect(
          AddClubGameEffect.setValues(
            ratingsSchema: game.ratingScheme,
            players: game.players
                .map(
                  (e) =>
                      players.firstWhere((element) => element.id == e).nickname,
                )
                .toList(),
            addScore: game.addScore.map((e) => e / 100).toList(),
            roles: List.generate(
              10,
              (index) {
                if (game.sheriff == index) {
                  return PlayerRole.sheriff;
                }
                if (game.don == index) {
                  return PlayerRole.don;
                }
                if (game.mafia1 == index || game.mafia2 == index) {
                  return PlayerRole.maf;
                }
                return PlayerRole.citizen;
              },
            ),
            win: game.win,
            bestMove: game.bestMove,
            referee: players
                .firstWhere((element) => element.id == game.referee)
                .nickname,
            died: game.hasFirstDie() ? game.firstDie : null,
            date: DateTime.parse(game.date),
            ciModel: (game.hasCiId()
                    ? state.ciSchemes.firstWhereOrNull(
                        (element) => element.id == game.ciId,
                      )
                    : CiSchemeModel.empty) ??
                CiSchemeModel.empty,
          ),
        );
        emit(state.copyWith(isLoading: false));
      } else {
        final defaultScheme = await _settingsStorage.getDefaultRatingScheme();

        emitEffect(
          AddClubGameEffect.setValues(
            ratingsSchema: defaultScheme ?? RatingScheme.oldFSM,
          ),
        );
      }
    } else {
      final list = await Future.wait([
        _getAllPlayersInteractor.run(),
        _getTournamentGameInteractor(
          gameId: event.gameId!,
          tournamentId: tournamentId!,
        ),
        _getTournamentInteractor(tournamentId: tournamentId!),
        _tournamentsRepository.isOwner(tournamentId!),
      ]);
      final players = list[0] as List<PlayerModel>;
      final game = list[1] as ClubGameResult;
      final tournament = list[2] as TournamentModel;
      final isOwner = list[3] as bool;

      emitEffect(
        AddClubGameEffect.setValues(
          players: game.players
              .map(
                (e) => players.firstWhereOrNull((element) => element.id == e),
              )
              .whereType<PlayerModel>()
              .map((e) => e.nickname)
              .toList(),
          addScore: game.addScore.map((e) => e / 100).toList(),
          roles: List.generate(10, (index) {
            if (game.hasMafia1() && index == game.mafia1 ||
                game.hasMafia2() && index == game.mafia2) {
              return PlayerRole.maf;
            }
            if (game.hasDon() && index == game.don) {
              return PlayerRole.don;
            }
            if (game.hasSheriff() && index == game.sheriff) {
              return PlayerRole.sheriff;
            }
            return PlayerRole.citizen;
          }),
          win: game.win,
          bestMove: game.bestMove,
          referee: players
                  .firstWhereOrNull((element) => game.referee == element.id)
                  ?.nickname ??
              "Не указан",
          died: game.hasFirstDie() ? game.firstDie : null,
          date: DateTime.now(),
          ciModel: CiSchemeModel.empty,
        ),
      );

      emit(
        state.copyWith(
          isLoading: false,
          players: players,
          canEdit: isOwner,
          clubName: tournament.name,
          ciSchemes: [],
          isTournament: true,
        ),
      );
    }
  }

}
