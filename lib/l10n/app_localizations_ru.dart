// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get loginAuth => 'Авторизация';

  @override
  String get loginEmailHint => 'Ваша электронная почта';

  @override
  String get loginPasswordHint => 'Пароль';

  @override
  String get loginIn => 'Войти';

  @override
  String get loginRememberMe => 'Запомнить меня';

  @override
  String get loginForgotPassword => 'Забыли пароль?';

  @override
  String get mainProfileHint => 'Настройки профиля';

  @override
  String get mainCreateTournamentHint => 'Создать турнир';

  @override
  String get mainRegulationsHint => 'Регламент турнира';

  @override
  String get insertSeatingSuccess => 'Рассадка успешно сохранена';

  @override
  String get insertSeatingError =>
      'Произошла какая-то ошибка при сохранении рассадки';

  @override
  String get send => 'Отправить';

  @override
  String get seating => 'Рассадка';

  @override
  String get idHint => '23';

  @override
  String get tournamentsListTitle => 'Турниры';

  @override
  String get tournamentsListDateHeader => 'Дата турнира';

  @override
  String get tournamentsListGamesCountHeader => 'Количество игр';

  @override
  String get tournamentsListStatusHeader => 'Статус';

  @override
  String get tournamentsListNameHeader => 'Название турнира';

  @override
  String get tournamentStatusActive => 'Активен';

  @override
  String get tournamentStatusWaitForBilling => 'Ожидание оплаты';

  @override
  String get tournamentStatusEnded => 'Завершён';

  @override
  String get loginRegistration => 'Зарегистрироваться';

  @override
  String get loginRegister => 'Регистрация';

  @override
  String get addPlayer => 'Добавить участника';

  @override
  String get nicknameHint => 'Никнейм';

  @override
  String get fsmNicknameHint => 'Никнейм в ФСМ (не обязательно)';

  @override
  String get mafbankNicknameHint => 'Никнейм как на мафбанке (не обязательно)';

  @override
  String get addPlayerDialogTitle => 'Добавление участника';

  @override
  String get add => 'Добавить';

  @override
  String get finalGamesHint => 'Количество финальных игр';

  @override
  String get swissGamesHint => 'Количество игр в швейцарке';

  @override
  String get defaultGamesHint => 'Количество отборочных игр';

  @override
  String get settings => 'Настройки';

  @override
  String get yourEmail => 'Ваша электронная почта';

  @override
  String get wrongEmail =>
      'Профиль с такой почтой уже существует / Неверная почта';

  @override
  String get enterPassword => 'Введите пароль';

  @override
  String get repeatPassword => 'Повторите пароль';

  @override
  String get invalidPassword => 'Слишком слабый пароль';

  @override
  String get notMatchPasswords => 'Пароли не совпадают';

  @override
  String get requiredForEnter => '- обязательное поле для заполнения';

  @override
  String get authorization => 'Авторизоваться';

  @override
  String get sendOneMoreCode => 'Отправить код повторно';

  @override
  String get verificationText =>
      'На вашу почту отправлено письмо с кодом для подтверждения регистрации, введите его ниже.\n';

  @override
  String get confirmRegistration => 'Подтверждение регистрации';

  @override
  String get enterCode => 'Введите код';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get confirmText => 'Вы уверены?';

  @override
  String get save => 'Сохранить';

  @override
  String get participants => 'Участники';

  @override
  String get separateTitle => 'Рассадить';

  @override
  String get addSeparationBtnText => 'Добавить пару';

  @override
  String get tournamentPageListOfPlayers => 'Список участников';

  @override
  String get withoutCi => 'Без коменсации';

  @override
  String get ci => 'Компенсация';

  @override
  String get createTournamentLabel => 'Название турнира';

  @override
  String get create => 'Создать';

  @override
  String get dateTimeRangePlaceholder => 'Даты турнира';

  @override
  String get fsmSeatingHeader => 'Загрузка рассадки с ФСМ турнира';

  @override
  String get tournamentSettingsTitle => 'Настройки турнира';

  @override
  String get defaultGamesLabel => 'Количество обычных игр';

  @override
  String get swissGamesLabel => 'Количество игр по швейцарке';

  @override
  String get finalGamesLabel => 'Количество финальных игр';

  @override
  String get invalidCode => 'Неверный код';

  @override
  String get addGame => 'Добавить новую игру';

  @override
  String get deleteGame => 'Удалить';

  @override
  String get invalidEmailOrPassword => 'Неверная почта или пароль';

  @override
  String tableAndGame(int table, int game) {
    return 'Игра $game, Стол $table';
  }

  @override
  String get mafiaWon => 'Победа мафии';

  @override
  String get cityWon => 'Победа города';

  @override
  String get draw => 'Ничья';

  @override
  String get tournamentSettingsUpdateSuccess =>
      'Настройки турнира успешно обновлены';

  @override
  String get clubsHeader => 'Клубы';

  @override
  String get description => 'Описание';

  @override
  String get openRating => 'Открыть рейтинг клуба';

  @override
  String billClubButtonText(int amount) {
    return 'Оплатить $amount₽';
  }

  @override
  String get billClubButtonDisabledText => 'Оплатить';

  @override
  String billClubDialogOption(int days) {
    return '$days дней';
  }

  @override
  String get clubDescription => 'Описание клуба';

  @override
  String get clubEditOwners => 'Редактировать администраторов';

  @override
  String get ownersTitle => 'Администраторы';

  @override
  String get ownersEmpty => 'Пока не добавлен ни один администратор';

  @override
  String get ownersAddTitle => 'Добавление администратора';

  @override
  String get ownersEmail => 'Почта';

  @override
  String get ownersEmailInvalid => 'Введите корректный адрес электронной почты';

  @override
  String ownersRemoveOwner(String email) {
    return 'Удалить администратора $email?';
  }

  @override
  String get logout => 'Выйти из аккаунта';

  @override
  String get contacts => 'Контакты';

  @override
  String get aboutApp => 'О приложении';

  @override
  String get politicaAlert => 'Нажимая кнопку Войти, Вы полностью принимаете ';

  @override
  String get politicaHref => 'Политику персональных данных';

  @override
  String get playersCount => 'Количество игроков';

  @override
  String get translationHelp => 'Плашки';

  @override
  String get profile => 'Профиль';

  @override
  String profileAuthorizedAs(String email) {
    return 'Вы авторизованы как: $email';
  }

  @override
  String get profileLinkedPlayer => 'Связанный профиль игрока:';

  @override
  String get profilePlayerNotSelected => 'Профиль игрока не выбран';

  @override
  String get profileChangePlayer => 'Изменить профиль игрока';

  @override
  String get profileSelectPlayer => 'Выбрать профиль игрока';

  @override
  String profileFsmNickname(String nickname) {
    return 'ФСМ: $nickname';
  }

  @override
  String get profileDeleteAccount => 'Удалить аккаунт';

  @override
  String get profilePaymentTitle => 'Оплата';

  @override
  String get profileTournamentSubscriptionTitle => 'Подписка на турниры';

  @override
  String profileTournamentSubscriptionStatus(String status) {
    return 'Статус: $status';
  }

  @override
  String get profileTournamentSubscriptionStatusActive => 'Активна';

  @override
  String get profileTournamentSubscriptionStatusInactive => 'Неактивна';

  @override
  String profileTournamentSubscriptionPlan(String plan) {
    return 'Тариф: $plan';
  }

  @override
  String get profileTournamentSubscriptionPlanUnavailable =>
      'Подписка не оформлена';

  @override
  String get profileTournamentSubscriptionTypeUnknown => 'Неизвестный тариф';

  @override
  String
      get profileTournamentSubscriptionTypeTournamentWithAllAddons10Players =>
          'Турниры + все дополнения (10 игроков)';

  @override
  String get profileTournamentSubscriptionCreate => 'Оформить подписку';

  @override
  String get profileTournamentSubscriptionRenew => 'Продлить подписку';

  @override
  String get profileTournamentSubscriptionLoading => 'Загрузка...';

  @override
  String profileTournamentSubscriptionOption(int days) {
    return '$days дней';
  }

  @override
  String get profileTournamentSubscriptionReload => 'Обновить';

  @override
  String get profileTournamentSubscriptionErrorGeneric =>
      'Не удалось загрузить данные о подписке';

  @override
  String get profileTournamentSubscriptionInfoTitle => 'О подписке';

  @override
  String get profileTournamentSubscriptionInfoDescription =>
      'При создании турниров в период подписки, будет выставляться статус оплаченного турнира на 10 человек';

  @override
  String billedFor(String date) {
    return 'Оплачено до $date';
  }

  @override
  String get translationDialogTitle => 'Трансляция';

  @override
  String get translationContentLink => 'Ссылка для встраивания в обс';

  @override
  String get translationControlLink => 'Ссылка для управления';

  @override
  String get bucketFieldTitle => 'Корзины для полуфинального этапа';

  @override
  String get bucketFieldHint => '30;20;30';

  @override
  String get hideResult => 'Скрыть результат';

  @override
  String get local_time_placeholder => 'Выбрать время';

  @override
  String get rating_schema => 'Схема рассчета';

  @override
  String get old_fsm_schema => 'Старая схема ФСМ';

  @override
  String get minus_fsm_schema => 'Схема ФСМ с минусами';

  @override
  String get fantasy => 'Фентези';

  @override
  String get fantasyRatingEmpty => 'Рейтинг пока пуст';

  @override
  String get fantasyRating => 'Рейтинг';

  @override
  String fantasyPoints(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count очков',
      many: '$count очков',
      few: '$count очка',
      one: '$count очко',
      zero: '0 очков',
    );
    return '$_temp0';
  }

  @override
  String fantasyGame(int number) {
    return 'Игра $number';
  }

  @override
  String get fantasyCurrentGameInfoUnavailable =>
      'Информация о текущей игре недоступна';

  @override
  String get fantasyCurrentGame => 'Текущая игра';

  @override
  String get fantasyNotParticipating =>
      'Вы не допущены к участию в фентези. Обратитесь к администратору турнира для получения доступа.';

  @override
  String get fantasyYourPrediction => 'Ваше предсказание:';

  @override
  String get fantasyPredictionTimeExpired => 'Время для предсказаний истекло';

  @override
  String get fantasyParticipants => 'Участники';

  @override
  String get fantasyNoParticipants => 'Пока не добавлен ни один участник';

  @override
  String get fantasyAddParticipant => 'Добавление участника';

  @override
  String get fantasyEmail => 'Почта';

  @override
  String get fantasyEmailInvalid =>
      'Введите корректный адрес электронной почты';

  @override
  String fantasyRemoveParticipant(String email) {
    return 'Удалить участника $email?';
  }

  @override
  String get fantasyNoPrediction => 'Нет';

  @override
  String get fantasyPredictionSeparator => ' → ';

  @override
  String get fantasyPointsShort => ' очков';

  @override
  String get fantasyStatusDisabled => 'Отключено';

  @override
  String get fantasyStatusEnabledForSelected => 'Включено для выбранных';

  @override
  String get fantasyStatusEnabledForAll => 'Включено для всех';

  @override
  String get fantasyStatusLabel => 'Статус фентези';

  @override
  String get seatingPlayerNotFound => 'Не найден игрок с никнеймом: ';

  @override
  String get seatingSelectOrCreatePlayer =>
      'Выберите игрока из списка, либо создайте нового';

  @override
  String get seatingCurrentFsmNickname =>
      'Текущий ФСМ никнейм выбранного игрока: ';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get ok => 'Ок';

  @override
  String get rating => 'Рейтинг';

  @override
  String get period => 'Период: ';

  @override
  String get ratingNoGamesFound =>
      'За данный период не найдено ни одной игры. Попробуйте изменить период.';

  @override
  String get ratingNumber => '№';

  @override
  String get ratingPlayer => 'Игрок';

  @override
  String get ratingScorePerGame => 'Балл за игру';

  @override
  String get ratingMvp => 'MVP';

  @override
  String get ratingMvpCitizen => 'MVP (мирный)';

  @override
  String get ratingMvpSheriff => 'MVP (шериф)';

  @override
  String get ratingMvpDon => 'MVP (дон)';

  @override
  String get ratingMvpMafia => 'MVP (мафия)';

  @override
  String get ratingWinRate => 'Винрейт';

  @override
  String get ratingWinRateCitizen => 'Винрейт за мирного';

  @override
  String get ratingWinRateSheriff => 'Винрейт за шерифа';

  @override
  String get ratingWinRateMafia => 'Винрейт за мафию';

  @override
  String get ratingWinRateDon => 'Винрейт за дона';

  @override
  String get ratingKillPercentage => 'Процент убийств';

  @override
  String get ratingPoints => 'Очки';

  @override
  String get ratingPlus => '+';

  @override
  String get ratingCi => 'Ci';

  @override
  String get ratingWin => 'п';

  @override
  String get ratingRoleWin => 'дк';

  @override
  String get ratingDies => 'по';

  @override
  String get ratingGames => 'и';

  @override
  String get ratingGameFilter => 'Минимум игр:';

  @override
  String get ratingGameFilterHint => 'Минимум игр';

  @override
  String get ratingGameFilterTitle => 'Фильтр по количеству игр';

  @override
  String get ratingGameFilterDescription =>
      'Показывать только игроков, которые сыграли минимум указанное количество игр за выбранный период.';

  @override
  String ratingGameFilterCurrent(int count) {
    return 'Текущий фильтр: $count игр';
  }

  @override
  String get date => 'Дата:';

  @override
  String get error => 'Ошибка';

  @override
  String get cancel => 'Закрыть';

  @override
  String get tempTryLuck => 'Испытай удачу!';

  @override
  String get tempTryNextTime => 'Попробуй в следующий раз';

  @override
  String get tempGotCard => 'Ты получил карточку!';

  @override
  String get tempGotGoldCard => 'Ты получил ЗОЛОТУЮ карточку!';

  @override
  String get next => 'Дальше';

  @override
  String unknownError(String error) {
    return 'Произошла неизвестная ошибка $error';
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
  String get customColumns => 'Формулы';

  @override
  String get customColumnsEditor => 'Редактор столбцов';

  @override
  String get customColumnsAdd => 'Добавить столбец';

  @override
  String get customColumnsTitle => 'Название';

  @override
  String get customColumnsFormula => 'Формула';

  @override
  String get customColumnsFormulaHint =>
      'Введите формулу (напр. score / totalGames)';

  @override
  String get customColumnsValidate => 'Проверить';

  @override
  String get customColumnsFormulaValid => 'Формула корректна';

  @override
  String customColumnsFormulaInvalid(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get customColumnsAvailableVariables => 'Доступные переменные';

  @override
  String get customColumnsDelete => 'Удалить столбец';

  @override
  String customColumnsDeleteConfirm(String title) {
    return 'Удалить столбец \"$title\"?';
  }

  @override
  String get customColumnsEmpty => 'Нет пользовательских столбцов';

  @override
  String get customColumnsEditButton => 'Настроить столбцы';

  @override
  String get customColumnsNoValue => '—';

  @override
  String get customColumnsSave => 'Сохранить';

  @override
  String get customColumnsEdit => 'Редактировать';

  @override
  String get customColumnsOperations =>
      'Операции: +, -, *, /, ^ (степень), % (остаток), скобки';

  @override
  String get customColumnsFunctions =>
      'Функции: sqrt, abs, log, log2, log10, ceil, floor, sin, cos, tan';

  @override
  String get tooltipScore => 'Общий балл';

  @override
  String get tooltipAddScore => 'Общий доп. балл';

  @override
  String get tooltipMinusScore => 'Общий штраф';

  @override
  String get tooltipWins => 'Общее кол-во побед';

  @override
  String get tooltipFirstDie => 'Кол-во первых убитых';

  @override
  String get tooltipCi => 'Компенсация';

  @override
  String get tooltipTotalGames => 'Всего игр';

  @override
  String get tooltipCitizenGames => 'Игр за мирного';

  @override
  String get tooltipMafiaGames => 'Игр за мафию';

  @override
  String get tooltipDonGames => 'Игр за дона';

  @override
  String get tooltipSheriffGames => 'Игр за шерифа';

  @override
  String get tooltipCitizenWins => 'Побед за мирного';

  @override
  String get tooltipMafiaWins => 'Побед за мафию';

  @override
  String get tooltipDonWins => 'Побед за дона';

  @override
  String get tooltipSheriffWins => 'Побед за шерифа';

  @override
  String get tooltipCitizenAddScore => 'Доп. балл за мирного';

  @override
  String get tooltipMafiaAddScore => 'Доп. балл за мафию';

  @override
  String get tooltipDonAddScore => 'Доп. балл за дона';

  @override
  String get tooltipSheriffAddScore => 'Доп. балл за шерифа';

  @override
  String get tooltipCitizenScore => 'Балл за мирного';

  @override
  String get tooltipMafiaScore => 'Балл за мафию';

  @override
  String get tooltipDonScore => 'Балл за дона';

  @override
  String get tooltipSheriffScore => 'Балл за шерифа';

  @override
  String get tooltipCitizenMinusScore => 'Штраф за мирного';

  @override
  String get tooltipMafiaMinusScore => 'Штраф за мафию';

  @override
  String get tooltipDonMinusScore => 'Штраф за дона';

  @override
  String get tooltipSheriffMinusScore => 'Штраф за шерифа';

  @override
  String get tooltipBestMoveCitizen => 'Доп. балл за лучший ход мирного';

  @override
  String get tooltipBestMoveSheriff => 'Доп. балл за лучший ход шерифа';

  @override
  String get tooltipRefereeCount => 'Кол-во судейств';

  @override
  String get tooltipFnMin => 'Минимум из двух значений';

  @override
  String get tooltipFnMax => 'Максимум из двух значений';

  @override
  String get tooltipFnAbs => 'Модуль числа';

  @override
  String get tooltipFnRound => 'Округление';

  @override
  String get tooltipFnFloor => 'Округление вниз';

  @override
  String get tooltipFnCeil => 'Округление вверх';
}
