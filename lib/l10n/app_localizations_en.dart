// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginAuth => 'Authorization';

  @override
  String get loginEmailHint => 'Your email';

  @override
  String get loginPasswordHint => 'Password';

  @override
  String get loginIn => 'Sign in';

  @override
  String get loginRememberMe => 'Remember me';

  @override
  String get loginForgotPassword => 'Forgot password?';

  @override
  String get mainProfileHint => 'Profile settings';

  @override
  String get mainCreateTournamentHint => 'Create tournament';

  @override
  String get mainRegulationsHint => 'Tournament regulations';

  @override
  String get insertSeatingSuccess => 'Seating successfully saved';

  @override
  String get insertSeatingError => 'An error occurred while saving the seating';

  @override
  String get send => 'Send';

  @override
  String get seating => 'Seating';

  @override
  String get idHint => '23';

  @override
  String get tournamentsListTitle => 'Tournaments';

  @override
  String get tournamentsListDateHeader => 'Tournament date';

  @override
  String get tournamentsListGamesCountHeader => 'Number of games';

  @override
  String get tournamentsListStatusHeader => 'Status';

  @override
  String get tournamentsListNameHeader => 'Tournament name';

  @override
  String get tournamentStatusActive => 'Active';

  @override
  String get tournamentStatusWaitForBilling => 'Waiting for payment';

  @override
  String get tournamentStatusEnded => 'Ended';

  @override
  String get loginRegistration => 'Sign up';

  @override
  String get loginRegister => 'Registration';

  @override
  String get addPlayer => 'Add participant';

  @override
  String get nicknameHint => 'Nickname';

  @override
  String get fsmNicknameHint => 'FSM nickname (optional)';

  @override
  String get mafbankNicknameHint => 'Mafbank nickname (optional)';

  @override
  String get addPlayerDialogTitle => 'Add participant';

  @override
  String get add => 'Add';

  @override
  String get finalGamesHint => 'Number of final games';

  @override
  String get swissGamesHint => 'Number of Swiss games';

  @override
  String get defaultGamesHint => 'Number of qualifying games';

  @override
  String get settings => 'Settings';

  @override
  String get yourEmail => 'Your email';

  @override
  String get wrongEmail =>
      'Profile with this email already exists / Invalid email';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get repeatPassword => 'Repeat password';

  @override
  String get invalidPassword => 'Password is too weak';

  @override
  String get notMatchPasswords => 'Passwords do not match';

  @override
  String get requiredForEnter => '- required field';

  @override
  String get authorization => 'Authorize';

  @override
  String get sendOneMoreCode => 'Send code again';

  @override
  String get verificationText =>
      'An email with a registration confirmation code has been sent to your email, enter it below.\n';

  @override
  String get confirmRegistration => 'Registration confirmation';

  @override
  String get enterCode => 'Enter code';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get confirmText => 'Are you sure?';

  @override
  String get save => 'Save';

  @override
  String get participants => 'Participants';

  @override
  String get separateTitle => 'Seat';

  @override
  String get addSeparationBtnText => 'Add pair';

  @override
  String get tournamentPageListOfPlayers => 'List of participants';

  @override
  String get withoutCi => 'Without compensation';

  @override
  String get ci => 'Compensation';

  @override
  String get createTournamentLabel => 'Tournament name';

  @override
  String get create => 'Create';

  @override
  String get dateTimeRangePlaceholder => 'Tournament dates';

  @override
  String get fsmSeatingHeader => 'Load seating from FSM tournament';

  @override
  String get tournamentSettingsTitle => 'Tournament settings';

  @override
  String get defaultGamesLabel => 'Number of regular games';

  @override
  String get swissGamesLabel => 'Number of Swiss games';

  @override
  String get finalGamesLabel => 'Number of final games';

  @override
  String get invalidCode => 'Invalid code';

  @override
  String get addGame => 'Add new game';

  @override
  String get deleteGame => 'Delete';

  @override
  String get invalidEmailOrPassword => 'Invalid email or password';

  @override
  String tableAndGame(int table, int game) {
    return 'Game $game, Table $table';
  }

  @override
  String get mafiaWon => 'Mafia won';

  @override
  String get cityWon => 'City won';

  @override
  String get draw => 'Draw';

  @override
  String get tournamentSettingsUpdateSuccess =>
      'Tournament settings successfully updated';

  @override
  String get clubsHeader => 'Clubs';

  @override
  String get description => 'Description';

  @override
  String get openRating => 'Open club rating';

  @override
  String billClubButtonText(int amount) {
    return 'Pay $amount₽';
  }

  @override
  String get billClubButtonDisabledText => 'Pay';

  @override
  String billClubDialogOption(int days) {
    return '$days days';
  }

  @override
  String get clubDescription => 'Club description';

  @override
  String get clubEditOwners => 'Edit administrators';

  @override
  String get ownersTitle => 'Administrators';

  @override
  String get ownersEmpty => 'No administrators added yet';

  @override
  String get ownersAddTitle => 'Add administrator';

  @override
  String get ownersEmail => 'Email';

  @override
  String get ownersEmailInvalid => 'Enter a valid email address';

  @override
  String ownersRemoveOwner(String email) {
    return 'Remove administrator $email?';
  }

  @override
  String get logout => 'Log out';

  @override
  String get contacts => 'Contacts';

  @override
  String get aboutApp => 'About app';

  @override
  String get politicaAlert =>
      'By clicking the Sign in button, you fully accept ';

  @override
  String get politicaHref => 'Privacy Policy';

  @override
  String get playersCount => 'Number of players';

  @override
  String get translationHelp => 'Overlays';

  @override
  String get profile => 'Profile';

  @override
  String profileAuthorizedAs(String email) {
    return 'You are authorized as: $email';
  }

  @override
  String get profileLinkedPlayer => 'Linked player profile:';

  @override
  String get profilePlayerNotSelected => 'Player profile is not selected';

  @override
  String get profileChangePlayer => 'Change player profile';

  @override
  String get profileSelectPlayer => 'Select player profile';

  @override
  String profileFsmNickname(String nickname) {
    return 'FSM: $nickname';
  }

  @override
  String get profileDeleteAccount => 'Delete account';

  @override
  String get profilePaymentTitle => 'Payment';

  @override
  String get profileTournamentSubscriptionTitle => 'Tournament subscription';

  @override
  String profileTournamentSubscriptionStatus(String status) {
    return 'Status: $status';
  }

  @override
  String get profileTournamentSubscriptionStatusActive => 'Active';

  @override
  String get profileTournamentSubscriptionStatusInactive => 'Inactive';

  @override
  String profileTournamentSubscriptionPlan(String plan) {
    return 'Plan: $plan';
  }

  @override
  String get profileTournamentSubscriptionPlanUnavailable =>
      'No active subscription';

  @override
  String get profileTournamentSubscriptionTypeUnknown => 'Unknown plan';

  @override
  String
      get profileTournamentSubscriptionTypeTournamentWithAllAddons10Players =>
          'Tournaments + all addons (10 players)';

  @override
  String get profileTournamentSubscriptionCreate => 'Start subscription';

  @override
  String get profileTournamentSubscriptionRenew => 'Renew subscription';

  @override
  String get profileTournamentSubscriptionLoading => 'Loading...';

  @override
  String profileTournamentSubscriptionOption(int days) {
    return '$days days';
  }

  @override
  String get profileTournamentSubscriptionReload => 'Refresh';

  @override
  String get profileTournamentSubscriptionErrorGeneric =>
      'Failed to load subscription data';

  @override
  String get profileTournamentSubscriptionInfoTitle => 'About subscription';

  @override
  String get profileTournamentSubscriptionInfoDescription =>
      'When creating tournaments during the subscription period, the tournament will be marked as paid for 10 players';

  @override
  String billedFor(String date) {
    return 'Paid until $date';
  }

  @override
  String get translationDialogTitle => 'Broadcast';

  @override
  String get translationContentLink => 'Embed link for OBS';

  @override
  String get translationControlLink => 'Control link';

  @override
  String get bucketFieldTitle => 'Buckets for semi-final stage';

  @override
  String get bucketFieldHint => '30;20;30';

  @override
  String get hideResult => 'Hide result';

  @override
  String get local_time_placeholder => 'Select time';

  @override
  String get rating_schema => 'Rating scheme';

  @override
  String get old_fsm_schema => 'Old FSM scheme';

  @override
  String get minus_fsm_schema => 'FSM scheme with minuses';

  @override
  String get fantasy => 'Fantasy';

  @override
  String get fantasyRatingEmpty => 'Rating is empty';

  @override
  String get fantasyRating => 'Rating';

  @override
  String fantasyPoints(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count points',
      one: '$count point',
      zero: '0 points',
    );
    return '$_temp0';
  }

  @override
  String fantasyGame(int number) {
    return 'Game $number';
  }

  @override
  String get fantasyCurrentGameInfoUnavailable =>
      'Current game information unavailable';

  @override
  String get fantasyCurrentGame => 'Current game';

  @override
  String get fantasyNotParticipating =>
      'You are not allowed to participate in fantasy. Contact the tournament administrator to get access.';

  @override
  String get fantasyYourPrediction => 'Your prediction:';

  @override
  String get fantasyPredictionTimeExpired => 'Prediction time has expired';

  @override
  String get fantasyParticipants => 'Participants';

  @override
  String get fantasyNoParticipants => 'No participants added yet';

  @override
  String get fantasyAddParticipant => 'Add participant';

  @override
  String get fantasyEmail => 'Email';

  @override
  String get fantasyEmailInvalid => 'Enter a valid email address';

  @override
  String fantasyRemoveParticipant(String email) {
    return 'Remove participant $email?';
  }

  @override
  String get fantasyNoPrediction => 'No';

  @override
  String get fantasyPredictionSeparator => ' → ';

  @override
  String get fantasyPointsShort => ' points';

  @override
  String get fantasyStatusDisabled => 'Disabled';

  @override
  String get fantasyStatusEnabledForSelected => 'Enabled for selected';

  @override
  String get fantasyStatusEnabledForAll => 'Enabled for all';

  @override
  String get fantasyStatusLabel => 'Fantasy status';

  @override
  String get seatingPlayerNotFound => 'Player with nickname not found: ';

  @override
  String get seatingSelectOrCreatePlayer =>
      'Select a player from the list or create a new one';

  @override
  String get seatingCurrentFsmNickname =>
      'Current FSM nickname of selected player: ';

  @override
  String get confirm => 'Confirm';

  @override
  String get ok => 'Ok';

  @override
  String get rating => 'Rating';

  @override
  String get period => 'Period: ';

  @override
  String get ratingNoGamesFound =>
      'No games found for this period. Try changing the period.';

  @override
  String get ratingNumber => '#';

  @override
  String get ratingPlayer => 'Player';

  @override
  String get ratingScorePerGame => 'Score per game';

  @override
  String get ratingMvp => 'MVP';

  @override
  String get ratingMvpCitizen => 'MVP (citizen)';

  @override
  String get ratingMvpSheriff => 'MVP (sheriff)';

  @override
  String get ratingMvpDon => 'MVP (don)';

  @override
  String get ratingMvpMafia => 'MVP (mafia)';

  @override
  String get ratingWinRate => 'Win rate';

  @override
  String get ratingWinRateCitizen => 'Win rate as citizen';

  @override
  String get ratingWinRateSheriff => 'Win rate as sheriff';

  @override
  String get ratingWinRateMafia => 'Win rate as mafia';

  @override
  String get ratingWinRateDon => 'Win rate as don';

  @override
  String get ratingKillPercentage => 'Kill percentage';

  @override
  String get ratingPoints => 'Points';

  @override
  String get ratingPlus => '+';

  @override
  String get ratingCi => 'Ci';

  @override
  String get ratingWin => 'w';

  @override
  String get ratingRoleWin => 'rw';

  @override
  String get ratingDies => 'd';

  @override
  String get ratingGames => 'g';

  @override
  String get ratingGameFilter => 'Game filter';

  @override
  String get ratingGameFilterHint => 'Минимум игр';

  @override
  String get ratingGameFilterTitle => 'Фильтр по количеству игр';

  @override
  String get ratingGameFilterDescription =>
      'Показывать только игроков, которые сыграли минимум указанное количество игр за выбранный период.';

  @override
  String ratingGameFilterCurrent(int count) {
    return 'Minimum $count games';
  }

  @override
  String get date => 'Date:';

  @override
  String get error => 'Error';

  @override
  String get cancel => 'Cancel';

  @override
  String get tempTryLuck => 'Try your luck!';

  @override
  String get tempTryNextTime => 'Try again next time';

  @override
  String get tempGotCard => 'You got a card!';

  @override
  String get tempGotGoldCard => 'You got a GOLDEN card!';

  @override
  String get next => 'Next';

  @override
  String unknownError(String error) {
    return 'An unknown error occurred: $error';
  }

  @override
  String get forgotPasswordTitle => 'Восстановление пароля';

  @override
  String get forgotPasswordDescription =>
      'Введите ваш email, и мы отправим вам инструкции по восстановлению пароля';

  @override
  String get forgotPasswordEmailNotFound =>
      'Пользователь с таким email не найден';

  @override
  String get resetPasswordTitle => 'Сброс пароля';

  @override
  String get resetPasswordDescription =>
      'Введите токен из письма и новый пароль';

  @override
  String get resetPasswordTokenHint => 'Токен из письма';

  @override
  String get resetPasswordInvalidToken => 'Неверный токен';

  @override
  String get fantasyNotificationsDisabled => 'У вас выключены пуш-уведомления';

  @override
  String get fantasyNotificationsDisabledDescription =>
      'Включите уведомления, чтобы получать сообщения о доступности нового предсказания';

  @override
  String get fantasyEnableNotifications => 'Включить уведомления';

  @override
  String get fantasyNotificationsEnabled => 'Уведомления успешно включены';

  @override
  String get customColumns => 'Custom columns';

  @override
  String get customColumnsEditor => 'Column editor';

  @override
  String get customColumnsAdd => 'Add column';

  @override
  String get customColumnsTitle => 'Title';

  @override
  String get customColumnsFormula => 'Formula';

  @override
  String get customColumnsFormulaHint =>
      'Enter formula (e.g. score / totalGames)';

  @override
  String get customColumnsValidate => 'Validate';

  @override
  String get customColumnsFormulaValid => 'Formula is valid';

  @override
  String customColumnsFormulaInvalid(String error) {
    return 'Error: $error';
  }

  @override
  String get customColumnsAvailableVariables => 'Available variables';

  @override
  String get customColumnsDelete => 'Delete column';

  @override
  String customColumnsDeleteConfirm(String title) {
    return 'Delete column \"$title\"?';
  }

  @override
  String get customColumnsEmpty => 'No custom columns';

  @override
  String get customColumnsEditButton => 'Configure columns';

  @override
  String get customColumnsNoValue => '—';

  @override
  String get customColumnsSave => 'Save';

  @override
  String get customColumnsEdit => 'Edit';

  @override
  String get customColumnsOperations =>
      'Operations: +, -, *, /, ^ (power), % (remainder), parentheses';

  @override
  String get customColumnsFunctions =>
      'Functions: sqrt, abs, log, log2, log10, ceil, floor, sin, cos, tan';

  @override
  String get tooltipScore => 'Total score';

  @override
  String get tooltipAddScore => 'Total bonus score';

  @override
  String get tooltipMinusScore => 'Total penalty';

  @override
  String get tooltipWins => 'Total wins';

  @override
  String get tooltipFirstDie => 'First killed count';

  @override
  String get tooltipCi => 'Compensation';

  @override
  String get tooltipTotalGames => 'Total games';

  @override
  String get tooltipCitizenGames => 'Games as citizen';

  @override
  String get tooltipMafiaGames => 'Games as mafia';

  @override
  String get tooltipDonGames => 'Games as don';

  @override
  String get tooltipSheriffGames => 'Games as sheriff';

  @override
  String get tooltipCitizenWins => 'Wins as citizen';

  @override
  String get tooltipMafiaWins => 'Wins as mafia';

  @override
  String get tooltipDonWins => 'Wins as don';

  @override
  String get tooltipSheriffWins => 'Wins as sheriff';

  @override
  String get tooltipCitizenAddScore => 'Bonus as citizen';

  @override
  String get tooltipMafiaAddScore => 'Bonus as mafia';

  @override
  String get tooltipDonAddScore => 'Bonus as don';

  @override
  String get tooltipSheriffAddScore => 'Bonus as sheriff';

  @override
  String get tooltipCitizenScore => 'Score as citizen';

  @override
  String get tooltipMafiaScore => 'Score as mafia';

  @override
  String get tooltipDonScore => 'Score as don';

  @override
  String get tooltipSheriffScore => 'Score as sheriff';

  @override
  String get tooltipCitizenMinusScore => 'Penalty as citizen';

  @override
  String get tooltipMafiaMinusScore => 'Penalty as mafia';

  @override
  String get tooltipDonMinusScore => 'Penalty as don';

  @override
  String get tooltipSheriffMinusScore => 'Penalty as sheriff';

  @override
  String get tooltipBestMoveCitizen => 'Best move bonus as citizen';

  @override
  String get tooltipBestMoveSheriff => 'Best move bonus as sheriff';

  @override
  String get tooltipRefereeCount => 'Referee count';

  @override
  String get tooltipFnMin => 'Minimum of two values';

  @override
  String get tooltipFnMax => 'Maximum of two values';

  @override
  String get tooltipFnAbs => 'Absolute value';

  @override
  String get tooltipFnRound => 'Round';

  @override
  String get tooltipFnFloor => 'Round down';

  @override
  String get tooltipFnCeil => 'Round up';

  @override
  String get playerStatsTitle => 'Player Statistics';

  @override
  String get playerStatsOverall => 'Overall';

  @override
  String get playerStatsCitizen => 'Citizen';

  @override
  String get playerStatsMafia => 'Mafia';

  @override
  String get playerStatsDon => 'Don';

  @override
  String get playerStatsSheriff => 'Sheriff';

  @override
  String get playerStatsGames => 'Games';

  @override
  String get playerStatsWins => 'Wins';

  @override
  String get playerStatsWinRate => 'Win rate';

  @override
  String get playerStatsAvgBonus => 'Avg bonus';

  @override
  String get playerStatsSameCityTop => 'TOP-5 teammates (city)';

  @override
  String get playerStatsSameMafiaTop => 'TOP-5 teammates (mafia)';

  @override
  String get playerStatsDiffTeamTop => 'TOP-5 opponents';

  @override
  String get playerStatsError => 'Failed to load statistics';

  @override
  String get playerStatsNoData => 'No pair data available';
}
