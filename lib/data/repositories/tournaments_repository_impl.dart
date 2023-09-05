import 'package:flutter/material.dart';
import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/requests/create_seating_request.dart';
import 'package:seating_generator_web/data/requests/create_tournament_request.dart';
import 'package:seating_generator_web/data/requests/get_my_tournaments_request.dart';
import 'package:seating_generator_web/data/requests/get_tournament_request.dart';
import 'package:seating_generator_web/data/requests/get_tournaments_request.dart';
import 'package:seating_generator_web/data/requests/tournament_check_request.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentsRepositoryImpl extends BaseRepository
    implements TournamentsRepository {
  TournamentsRepositoryImpl(super.client);

  @override
  Future<List<TournamentModel>> getTournaments() {
    return GetTournamentsRequest().execute(client).then((value) {
      return value.tournaments.map((tournament) {
        return tournament.toDomainModel();
      }).toList();
    });
  }

  @override
  Future<int> createTournament({
    required String name,
    required DateTimeRange range,
  }) {
    return CreateTournamentRequest(name: name, dateTimeRange: range)
        .execute(client)
        .then((value) => value.id);
  }

  @override
  Future createSeating({required int id}) {
    return CreateSeatingRequest(tournamentId: id).execute(client);
  }

  @override
  Future<TournamentModel> getTournament({required int tournamentId}) {
    return GetTournamentRequest(id: tournamentId)
        .execute(client)
        .then((value) => value.toDomainModel());
  }

  @override
  Future<List<TournamentModel>> getMyTournaments() {
    return GetMyTournamentsRequest().execute(client).then((value) {
      return value.tournaments.map((tournament) {
        return tournament.toDomainModel();
      }).toList();
    });
  }

  @override
  Future<bool> isOwner(int tournamentId) {
    return TournamentCheckRequest(tournamentId: tournamentId)
        .execute(client)
        .then(
          (value) => value,
          onError: (err) => err is UnauthenticatedError ? false : throw err,
        );
  }
}

extension TournamentExt on Tournament {
  TournamentModel toDomainModel() => TournamentModel(
        id: id,
        name: name,
        status: TournamentStatus.from(status),
        dateStart: dateFormatForRequests.parse(dateStart),
        dateEnd: dateFormatForRequests.parse(dateEnd),
        gamesCount: gamesCount,
        billedTranslation: billedTranslation,
        billedPlayers: billedPlayers,
        notificationEnabled: notificationEnabled,
      );
}
