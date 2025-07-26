import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class StartGameInfoRequest extends BaseRequest<bool> {
  StartGameInfoRequest({
    required int tournamentId,
    required int game,
    TimeOfDay? time,
  }) : super(
          "/api/tournament/$tournamentId/startGameInfo",
          data: StartGameInfoEvent(
            game: game,
            localDate: switch (time) {
              final TimeOfDay time => DateFormat('HH:mm').format(
                  DateTime(2000).copyWith(
                    hour: time.hour,
                    minute: time.minute,
                  ),
                ),
              _ => null,
            },
          ),
        );

  @override
  FutureOr<bool> parse(List<int> bytes) {
    return true;
  }
}
