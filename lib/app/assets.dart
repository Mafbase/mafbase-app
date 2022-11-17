class AppAssets {
  static const String logoAsset = "assets/logo.svg";
  static const String contactAsset = "assets/contact.svg";
  static const String checkersAsset = "assets/checkers.svg";
  static const String circledPlusAsset = "assets/circled_plus.svg";
  static const String backArrowAsset = "assets/back_arrow.svg";
  static const String bubbleArrowAsset = "assets/bubble_arrow.svg";
  static const String exclamationPoint = 'assets/exclamation_point.svg';
  static const String smile = 'assets/smile.svg';
  static const String lock = 'assets/lock.svg';
  static const String deletedStatus = 'assets/deleted_status.svg';
  static const String killedStatus = 'assets/killed_status.svg';
  static const String votedStatus = 'assets/voted_status.svg';

  static String donAsset({bool disabled = false}) =>
      'assets/don${disabled ? '_disabled' : ''}.svg';

  static String citizenAsset({bool disabled = false}) =>
      'assets/citizen${disabled ? '_disabled' : ''}.svg';

  static String mafiaAsset({bool disabled = false}) =>
      'assets/mafia${disabled ? '_disabled' : ''}.svg';

  static String sheriffAsset({bool disabled = false}) =>
      'assets/sheriff${disabled ? '_disabled' : ''}.svg';
}