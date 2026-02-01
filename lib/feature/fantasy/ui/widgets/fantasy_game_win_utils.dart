import 'package:flutter/material.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

extension GameWinTextExtension on BuildContext {
  String? getGameWinText(GameWin? win) {
    switch (win) {
      case GameWin.city:
        return locale.cityWon;
      case GameWin.mafia:
        return locale.mafiaWon;
      case GameWin.draw:
        return locale.draw;
      default:
        return null;
    }
  }
}
