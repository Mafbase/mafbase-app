import 'package:flutter/material.dart';

abstract class InfoRepository {
  Future startGameInfo({
    required int tournamentId,
    required int game,
    TimeOfDay? time,
  });

  Future customTextInfo({required int tournamentId, required String text});
}
