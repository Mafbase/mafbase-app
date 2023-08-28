import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';

abstract class TournamentsRepository {
  Future<List<TournamentModel>> getTournaments();

  Future<int> createTournament({
    required String name,
    required DateTimeRange range,
  });

  Future createSeating({required int id});

  Future<TournamentModel> getTournament({required int tournamentId});

  Future<List<TournamentModel>> getMyTournaments();

  Future<bool> isOwner(int tournamentId);
}
