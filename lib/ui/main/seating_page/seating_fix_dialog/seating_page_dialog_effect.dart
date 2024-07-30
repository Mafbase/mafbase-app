sealed class SeatingPageDialogEffect {
  const factory SeatingPageDialogEffect.success() =
      SeatingPageDialogEffectSuccess;
}

class SeatingPageDialogEffectSuccess implements SeatingPageDialogEffect {
  const SeatingPageDialogEffectSuccess();
}
