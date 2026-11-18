sealed class SeatingPageEffect {
  factory SeatingPageEffect.fixPlayers(
    List<String> players,
    int gomafiaId,
  ) = SeatingPageEffectFixPlayers;
}

class SeatingPageEffectFixPlayers implements SeatingPageEffect {
  final List<String> players;
  final int gomafiaId;

  SeatingPageEffectFixPlayers(this.players, this.gomafiaId);
}
