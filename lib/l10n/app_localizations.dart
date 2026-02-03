import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @loginAuth.
  ///
  /// In ru, this message translates to:
  /// **'Авторизация'**
  String get loginAuth;

  /// No description provided for @loginEmailHint.
  ///
  /// In ru, this message translates to:
  /// **'Ваша электронная почта'**
  String get loginEmailHint;

  /// No description provided for @loginPasswordHint.
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get loginPasswordHint;

  /// No description provided for @loginIn.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get loginIn;

  /// No description provided for @loginRememberMe.
  ///
  /// In ru, this message translates to:
  /// **'Запомнить меня'**
  String get loginRememberMe;

  /// No description provided for @loginForgotPassword.
  ///
  /// In ru, this message translates to:
  /// **'Забыли пароль?'**
  String get loginForgotPassword;

  /// No description provided for @mainProfileHint.
  ///
  /// In ru, this message translates to:
  /// **'Настройки профиля'**
  String get mainProfileHint;

  /// No description provided for @mainCreateTournamentHint.
  ///
  /// In ru, this message translates to:
  /// **'Создать турнир'**
  String get mainCreateTournamentHint;

  /// No description provided for @mainRegulationsHint.
  ///
  /// In ru, this message translates to:
  /// **'Регламент турнира'**
  String get mainRegulationsHint;

  /// No description provided for @insertSeatingSuccess.
  ///
  /// In ru, this message translates to:
  /// **'Рассадка успешно сохранена'**
  String get insertSeatingSuccess;

  /// No description provided for @insertSeatingError.
  ///
  /// In ru, this message translates to:
  /// **'Произошла какая-то ошибка при сохранении рассадки'**
  String get insertSeatingError;

  /// No description provided for @send.
  ///
  /// In ru, this message translates to:
  /// **'Отправить'**
  String get send;

  /// No description provided for @seating.
  ///
  /// In ru, this message translates to:
  /// **'Рассадка'**
  String get seating;

  /// No description provided for @idHint.
  ///
  /// In ru, this message translates to:
  /// **'23'**
  String get idHint;

  /// No description provided for @tournamentsListTitle.
  ///
  /// In ru, this message translates to:
  /// **'Турниры'**
  String get tournamentsListTitle;

  /// No description provided for @tournamentsListDateHeader.
  ///
  /// In ru, this message translates to:
  /// **'Дата турнира'**
  String get tournamentsListDateHeader;

  /// No description provided for @tournamentsListGamesCountHeader.
  ///
  /// In ru, this message translates to:
  /// **'Количество игр'**
  String get tournamentsListGamesCountHeader;

  /// No description provided for @tournamentsListStatusHeader.
  ///
  /// In ru, this message translates to:
  /// **'Статус'**
  String get tournamentsListStatusHeader;

  /// No description provided for @tournamentsListNameHeader.
  ///
  /// In ru, this message translates to:
  /// **'Название турнира'**
  String get tournamentsListNameHeader;

  /// No description provided for @tournamentStatusActive.
  ///
  /// In ru, this message translates to:
  /// **'Активен'**
  String get tournamentStatusActive;

  /// No description provided for @tournamentStatusWaitForBilling.
  ///
  /// In ru, this message translates to:
  /// **'Ожидание оплаты'**
  String get tournamentStatusWaitForBilling;

  /// No description provided for @tournamentStatusEnded.
  ///
  /// In ru, this message translates to:
  /// **'Завершён'**
  String get tournamentStatusEnded;

  /// No description provided for @loginRegistration.
  ///
  /// In ru, this message translates to:
  /// **'Зарегистрироваться'**
  String get loginRegistration;

  /// No description provided for @loginRegister.
  ///
  /// In ru, this message translates to:
  /// **'Регистрация'**
  String get loginRegister;

  /// No description provided for @addPlayer.
  ///
  /// In ru, this message translates to:
  /// **'Добавить участника'**
  String get addPlayer;

  /// No description provided for @nicknameHint.
  ///
  /// In ru, this message translates to:
  /// **'Никнейм'**
  String get nicknameHint;

  /// No description provided for @fsmNicknameHint.
  ///
  /// In ru, this message translates to:
  /// **'Никнейм в ФСМ (не обязательно)'**
  String get fsmNicknameHint;

  /// No description provided for @mafbankNicknameHint.
  ///
  /// In ru, this message translates to:
  /// **'Никнейм как на мафбанке (не обязательно)'**
  String get mafbankNicknameHint;

  /// No description provided for @addPlayerDialogTitle.
  ///
  /// In ru, this message translates to:
  /// **'Добавление участника'**
  String get addPlayerDialogTitle;

  /// No description provided for @add.
  ///
  /// In ru, this message translates to:
  /// **'Добавить'**
  String get add;

  /// No description provided for @finalGamesHint.
  ///
  /// In ru, this message translates to:
  /// **'Количество финальных игр'**
  String get finalGamesHint;

  /// No description provided for @swissGamesHint.
  ///
  /// In ru, this message translates to:
  /// **'Количество игр в швейцарке'**
  String get swissGamesHint;

  /// No description provided for @defaultGamesHint.
  ///
  /// In ru, this message translates to:
  /// **'Количество отборочных игр'**
  String get defaultGamesHint;

  /// No description provided for @settings.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settings;

  /// No description provided for @yourEmail.
  ///
  /// In ru, this message translates to:
  /// **'Ваша электронная почта'**
  String get yourEmail;

  /// No description provided for @wrongEmail.
  ///
  /// In ru, this message translates to:
  /// **'Профиль с такой почтой уже существует / Неверная почта'**
  String get wrongEmail;

  /// No description provided for @enterPassword.
  ///
  /// In ru, this message translates to:
  /// **'Введите пароль'**
  String get enterPassword;

  /// No description provided for @repeatPassword.
  ///
  /// In ru, this message translates to:
  /// **'Повторите пароль'**
  String get repeatPassword;

  /// No description provided for @invalidPassword.
  ///
  /// In ru, this message translates to:
  /// **'Слишком слабый пароль'**
  String get invalidPassword;

  /// No description provided for @notMatchPasswords.
  ///
  /// In ru, this message translates to:
  /// **'Пароли не совпадают'**
  String get notMatchPasswords;

  /// No description provided for @requiredForEnter.
  ///
  /// In ru, this message translates to:
  /// **'- обязательное поле для заполнения'**
  String get requiredForEnter;

  /// No description provided for @authorization.
  ///
  /// In ru, this message translates to:
  /// **'Авторизоваться'**
  String get authorization;

  /// No description provided for @sendOneMoreCode.
  ///
  /// In ru, this message translates to:
  /// **'Отправить код повторно'**
  String get sendOneMoreCode;

  /// No description provided for @verificationText.
  ///
  /// In ru, this message translates to:
  /// **'На вашу почту отправлено письмо с кодом для подтверждения регистрации, введите его ниже.\n'**
  String get verificationText;

  /// No description provided for @confirmRegistration.
  ///
  /// In ru, this message translates to:
  /// **'Подтверждение регистрации'**
  String get confirmRegistration;

  /// No description provided for @enterCode.
  ///
  /// In ru, this message translates to:
  /// **'Введите код'**
  String get enterCode;

  /// No description provided for @yes.
  ///
  /// In ru, this message translates to:
  /// **'Да'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In ru, this message translates to:
  /// **'Нет'**
  String get no;

  /// No description provided for @confirmText.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены?'**
  String get confirmText;

  /// No description provided for @save.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get save;

  /// No description provided for @participants.
  ///
  /// In ru, this message translates to:
  /// **'Участники'**
  String get participants;

  /// No description provided for @separateTitle.
  ///
  /// In ru, this message translates to:
  /// **'Рассадить'**
  String get separateTitle;

  /// No description provided for @addSeparationBtnText.
  ///
  /// In ru, this message translates to:
  /// **'Добавить пару'**
  String get addSeparationBtnText;

  /// No description provided for @tournamentPageListOfPlayers.
  ///
  /// In ru, this message translates to:
  /// **'Список участников'**
  String get tournamentPageListOfPlayers;

  /// No description provided for @withoutCi.
  ///
  /// In ru, this message translates to:
  /// **'Без коменсации'**
  String get withoutCi;

  /// No description provided for @ci.
  ///
  /// In ru, this message translates to:
  /// **'Компенсация'**
  String get ci;

  /// No description provided for @createTournamentLabel.
  ///
  /// In ru, this message translates to:
  /// **'Название турнира'**
  String get createTournamentLabel;

  /// No description provided for @create.
  ///
  /// In ru, this message translates to:
  /// **'Создать'**
  String get create;

  /// No description provided for @dateTimeRangePlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Даты турнира'**
  String get dateTimeRangePlaceholder;

  /// No description provided for @fsmSeatingHeader.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка рассадки с ФСМ турнира'**
  String get fsmSeatingHeader;

  /// No description provided for @tournamentSettingsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Настройки турнира'**
  String get tournamentSettingsTitle;

  /// No description provided for @defaultGamesLabel.
  ///
  /// In ru, this message translates to:
  /// **'Количество обычных игр'**
  String get defaultGamesLabel;

  /// No description provided for @swissGamesLabel.
  ///
  /// In ru, this message translates to:
  /// **'Количество игр по швейцарке'**
  String get swissGamesLabel;

  /// No description provided for @finalGamesLabel.
  ///
  /// In ru, this message translates to:
  /// **'Количество финальных игр'**
  String get finalGamesLabel;

  /// No description provided for @invalidCode.
  ///
  /// In ru, this message translates to:
  /// **'Неверный код'**
  String get invalidCode;

  /// No description provided for @addGame.
  ///
  /// In ru, this message translates to:
  /// **'Добавить новую игру'**
  String get addGame;

  /// No description provided for @deleteGame.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get deleteGame;

  /// No description provided for @invalidEmailOrPassword.
  ///
  /// In ru, this message translates to:
  /// **'Неверная почта или пароль'**
  String get invalidEmailOrPassword;

  /// No description provided for @tableAndGame.
  ///
  /// In ru, this message translates to:
  /// **'Игра {game}, Стол {table}'**
  String tableAndGame(int table, int game);

  /// No description provided for @mafiaWon.
  ///
  /// In ru, this message translates to:
  /// **'Победа мафии'**
  String get mafiaWon;

  /// No description provided for @cityWon.
  ///
  /// In ru, this message translates to:
  /// **'Победа города'**
  String get cityWon;

  /// No description provided for @draw.
  ///
  /// In ru, this message translates to:
  /// **'Ничья'**
  String get draw;

  /// No description provided for @tournamentSettingsUpdateSuccess.
  ///
  /// In ru, this message translates to:
  /// **'Настройки турнира успешно обновлены'**
  String get tournamentSettingsUpdateSuccess;

  /// No description provided for @clubsHeader.
  ///
  /// In ru, this message translates to:
  /// **'Клубы'**
  String get clubsHeader;

  /// No description provided for @description.
  ///
  /// In ru, this message translates to:
  /// **'Описание'**
  String get description;

  /// No description provided for @openRating.
  ///
  /// In ru, this message translates to:
  /// **'Открыть рейтинг клуба'**
  String get openRating;

  /// No description provided for @billClubButtonText.
  ///
  /// In ru, this message translates to:
  /// **'Оплатить {amount}₽'**
  String billClubButtonText(int amount);

  /// No description provided for @billClubButtonDisabledText.
  ///
  /// In ru, this message translates to:
  /// **'Оплатить'**
  String get billClubButtonDisabledText;

  /// No description provided for @billClubDialogOption.
  ///
  /// In ru, this message translates to:
  /// **'{days} дней'**
  String billClubDialogOption(int days);

  /// No description provided for @clubDescription.
  ///
  /// In ru, this message translates to:
  /// **'Описание клуба'**
  String get clubDescription;

  /// No description provided for @logout.
  ///
  /// In ru, this message translates to:
  /// **'Выйти из аккаунта'**
  String get logout;

  /// No description provided for @contacts.
  ///
  /// In ru, this message translates to:
  /// **'Контакты'**
  String get contacts;

  /// No description provided for @aboutApp.
  ///
  /// In ru, this message translates to:
  /// **'О приложении'**
  String get aboutApp;

  /// No description provided for @politicaAlert.
  ///
  /// In ru, this message translates to:
  /// **'Нажимая кнопку Войти, Вы полностью принимаете '**
  String get politicaAlert;

  /// No description provided for @politicaHref.
  ///
  /// In ru, this message translates to:
  /// **'Политику персональных данных'**
  String get politicaHref;

  /// No description provided for @playersCount.
  ///
  /// In ru, this message translates to:
  /// **'Количество игроков'**
  String get playersCount;

  /// No description provided for @translationHelp.
  ///
  /// In ru, this message translates to:
  /// **'Плашки'**
  String get translationHelp;

  /// No description provided for @profile.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profile;

  /// No description provided for @billedFor.
  ///
  /// In ru, this message translates to:
  /// **'Оплачено до {date}'**
  String billedFor(String date);

  /// No description provided for @translationDialogTitle.
  ///
  /// In ru, this message translates to:
  /// **'Трансляция'**
  String get translationDialogTitle;

  /// No description provided for @translationContentLink.
  ///
  /// In ru, this message translates to:
  /// **'Ссылка для встраивания в обс'**
  String get translationContentLink;

  /// No description provided for @translationControlLink.
  ///
  /// In ru, this message translates to:
  /// **'Ссылка для управления'**
  String get translationControlLink;

  /// No description provided for @bucketFieldTitle.
  ///
  /// In ru, this message translates to:
  /// **'Корзины для полуфинального этапа'**
  String get bucketFieldTitle;

  /// No description provided for @bucketFieldHint.
  ///
  /// In ru, this message translates to:
  /// **'30;20;30'**
  String get bucketFieldHint;

  /// No description provided for @hideResult.
  ///
  /// In ru, this message translates to:
  /// **'Скрыть результат'**
  String get hideResult;

  /// No description provided for @local_time_placeholder.
  ///
  /// In ru, this message translates to:
  /// **'Выбрать время'**
  String get local_time_placeholder;

  /// No description provided for @rating_schema.
  ///
  /// In ru, this message translates to:
  /// **'Схема рассчета'**
  String get rating_schema;

  /// No description provided for @old_fsm_schema.
  ///
  /// In ru, this message translates to:
  /// **'Старая схема ФСМ'**
  String get old_fsm_schema;

  /// No description provided for @minus_fsm_schema.
  ///
  /// In ru, this message translates to:
  /// **'Схема ФСМ с минусами'**
  String get minus_fsm_schema;

  /// No description provided for @fantasy.
  ///
  /// In ru, this message translates to:
  /// **'Фентези'**
  String get fantasy;

  /// No description provided for @fantasyRatingEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Рейтинг пока пуст'**
  String get fantasyRatingEmpty;

  /// No description provided for @fantasyRating.
  ///
  /// In ru, this message translates to:
  /// **'Рейтинг'**
  String get fantasyRating;

  /// No description provided for @fantasyPoints.
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, =0{0 очков} =1{1 очко} few{{count} очка} many{{count} очков} other{{count} очков}}'**
  String fantasyPoints(int count);

  /// No description provided for @fantasyGame.
  ///
  /// In ru, this message translates to:
  /// **'Игра {number}'**
  String fantasyGame(int number);

  /// No description provided for @fantasyCurrentGameInfoUnavailable.
  ///
  /// In ru, this message translates to:
  /// **'Информация о текущей игре недоступна'**
  String get fantasyCurrentGameInfoUnavailable;

  /// No description provided for @fantasyCurrentGame.
  ///
  /// In ru, this message translates to:
  /// **'Текущая игра'**
  String get fantasyCurrentGame;

  /// No description provided for @fantasyNotParticipating.
  ///
  /// In ru, this message translates to:
  /// **'Вы не допущены к участию в фентези. Обратитесь к администратору турнира для получения доступа.'**
  String get fantasyNotParticipating;

  /// No description provided for @fantasyYourPrediction.
  ///
  /// In ru, this message translates to:
  /// **'Ваше предсказание:'**
  String get fantasyYourPrediction;

  /// No description provided for @fantasyPredictionTimeExpired.
  ///
  /// In ru, this message translates to:
  /// **'Время для предсказаний истекло'**
  String get fantasyPredictionTimeExpired;

  /// No description provided for @fantasyParticipants.
  ///
  /// In ru, this message translates to:
  /// **'Участники'**
  String get fantasyParticipants;

  /// No description provided for @fantasyNoParticipants.
  ///
  /// In ru, this message translates to:
  /// **'Пока не добавлен ни один участник'**
  String get fantasyNoParticipants;

  /// No description provided for @fantasyAddParticipant.
  ///
  /// In ru, this message translates to:
  /// **'Добавление участника'**
  String get fantasyAddParticipant;

  /// No description provided for @fantasyEmail.
  ///
  /// In ru, this message translates to:
  /// **'Почта'**
  String get fantasyEmail;

  /// No description provided for @fantasyEmailInvalid.
  ///
  /// In ru, this message translates to:
  /// **'Введите корректный адрес электронной почты'**
  String get fantasyEmailInvalid;

  /// No description provided for @fantasyRemoveParticipant.
  ///
  /// In ru, this message translates to:
  /// **'Удалить участника {email}?'**
  String fantasyRemoveParticipant(String email);

  /// No description provided for @fantasyNoPrediction.
  ///
  /// In ru, this message translates to:
  /// **'Нет'**
  String get fantasyNoPrediction;

  /// No description provided for @fantasyPredictionSeparator.
  ///
  /// In ru, this message translates to:
  /// **' → '**
  String get fantasyPredictionSeparator;

  /// No description provided for @fantasyPointsShort.
  ///
  /// In ru, this message translates to:
  /// **' очков'**
  String get fantasyPointsShort;

  /// No description provided for @fantasyStatusDisabled.
  ///
  /// In ru, this message translates to:
  /// **'Отключено'**
  String get fantasyStatusDisabled;

  /// No description provided for @fantasyStatusEnabledForSelected.
  ///
  /// In ru, this message translates to:
  /// **'Включено для выбранных'**
  String get fantasyStatusEnabledForSelected;

  /// No description provided for @fantasyStatusEnabledForAll.
  ///
  /// In ru, this message translates to:
  /// **'Включено для всех'**
  String get fantasyStatusEnabledForAll;

  /// No description provided for @fantasyStatusLabel.
  ///
  /// In ru, this message translates to:
  /// **'Статус фентези'**
  String get fantasyStatusLabel;

  /// No description provided for @seatingPlayerNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Не найден игрок с никнеймом: '**
  String get seatingPlayerNotFound;

  /// No description provided for @seatingSelectOrCreatePlayer.
  ///
  /// In ru, this message translates to:
  /// **'Выберите игрока из списка, либо создайте нового'**
  String get seatingSelectOrCreatePlayer;

  /// No description provided for @seatingCurrentFsmNickname.
  ///
  /// In ru, this message translates to:
  /// **'Текущий ФСМ никнейм выбранного игрока: '**
  String get seatingCurrentFsmNickname;

  /// No description provided for @confirm.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердить'**
  String get confirm;

  /// No description provided for @rating.
  ///
  /// In ru, this message translates to:
  /// **'Рейтинг'**
  String get rating;

  /// No description provided for @period.
  ///
  /// In ru, this message translates to:
  /// **'Период: '**
  String get period;

  /// No description provided for @ratingNoGamesFound.
  ///
  /// In ru, this message translates to:
  /// **'За данный период не найдено ни одной игры. Попробуйте изменить период.'**
  String get ratingNoGamesFound;

  /// No description provided for @ratingNumber.
  ///
  /// In ru, this message translates to:
  /// **'№'**
  String get ratingNumber;

  /// No description provided for @ratingPlayer.
  ///
  /// In ru, this message translates to:
  /// **'Игрок'**
  String get ratingPlayer;

  /// No description provided for @ratingScorePerGame.
  ///
  /// In ru, this message translates to:
  /// **'Балл за игру'**
  String get ratingScorePerGame;

  /// No description provided for @ratingMvp.
  ///
  /// In ru, this message translates to:
  /// **'MVP'**
  String get ratingMvp;

  /// No description provided for @ratingMvpCitizen.
  ///
  /// In ru, this message translates to:
  /// **'MVP (мирный)'**
  String get ratingMvpCitizen;

  /// No description provided for @ratingMvpSheriff.
  ///
  /// In ru, this message translates to:
  /// **'MVP (шериф)'**
  String get ratingMvpSheriff;

  /// No description provided for @ratingMvpDon.
  ///
  /// In ru, this message translates to:
  /// **'MVP (дон)'**
  String get ratingMvpDon;

  /// No description provided for @ratingMvpMafia.
  ///
  /// In ru, this message translates to:
  /// **'MVP (мафия)'**
  String get ratingMvpMafia;

  /// No description provided for @ratingWinRate.
  ///
  /// In ru, this message translates to:
  /// **'Винрейт'**
  String get ratingWinRate;

  /// No description provided for @ratingWinRateCitizen.
  ///
  /// In ru, this message translates to:
  /// **'Винрейт за мирного'**
  String get ratingWinRateCitizen;

  /// No description provided for @ratingWinRateSheriff.
  ///
  /// In ru, this message translates to:
  /// **'Винрейт за шерифа'**
  String get ratingWinRateSheriff;

  /// No description provided for @ratingWinRateMafia.
  ///
  /// In ru, this message translates to:
  /// **'Винрейт за мафию'**
  String get ratingWinRateMafia;

  /// No description provided for @ratingWinRateDon.
  ///
  /// In ru, this message translates to:
  /// **'Винрейт за дона'**
  String get ratingWinRateDon;

  /// No description provided for @ratingKillPercentage.
  ///
  /// In ru, this message translates to:
  /// **'Процент убийств'**
  String get ratingKillPercentage;

  /// No description provided for @ratingPoints.
  ///
  /// In ru, this message translates to:
  /// **'Очки'**
  String get ratingPoints;

  /// No description provided for @ratingPlus.
  ///
  /// In ru, this message translates to:
  /// **'+'**
  String get ratingPlus;

  /// No description provided for @ratingCi.
  ///
  /// In ru, this message translates to:
  /// **'Ci'**
  String get ratingCi;

  /// No description provided for @ratingWin.
  ///
  /// In ru, this message translates to:
  /// **'п'**
  String get ratingWin;

  /// No description provided for @ratingRoleWin.
  ///
  /// In ru, this message translates to:
  /// **'дк'**
  String get ratingRoleWin;

  /// No description provided for @ratingDies.
  ///
  /// In ru, this message translates to:
  /// **'по'**
  String get ratingDies;

  /// No description provided for @ratingGames.
  ///
  /// In ru, this message translates to:
  /// **'и'**
  String get ratingGames;

  /// No description provided for @ratingGameFilter.
  ///
  /// In ru, this message translates to:
  /// **'Минимум игр:'**
  String get ratingGameFilter;

  /// No description provided for @ratingGameFilterHint.
  ///
  /// In ru, this message translates to:
  /// **'Минимум игр'**
  String get ratingGameFilterHint;

  /// No description provided for @ratingGameFilterTitle.
  ///
  /// In ru, this message translates to:
  /// **'Фильтр по количеству игр'**
  String get ratingGameFilterTitle;

  /// No description provided for @ratingGameFilterDescription.
  ///
  /// In ru, this message translates to:
  /// **'Показывать только игроков, которые сыграли минимум указанное количество игр за выбранный период.'**
  String get ratingGameFilterDescription;

  /// No description provided for @ratingGameFilterCurrent.
  ///
  /// In ru, this message translates to:
  /// **'Текущий фильтр: {count} игр'**
  String ratingGameFilterCurrent(int count);

  /// No description provided for @date.
  ///
  /// In ru, this message translates to:
  /// **'Дата:'**
  String get date;

  /// No description provided for @error.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка'**
  String get error;

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get cancel;

  /// No description provided for @tempTryLuck.
  ///
  /// In ru, this message translates to:
  /// **'Испытай удачу!'**
  String get tempTryLuck;

  /// No description provided for @tempTryNextTime.
  ///
  /// In ru, this message translates to:
  /// **'Попробуй в следующий раз'**
  String get tempTryNextTime;

  /// No description provided for @tempGotCard.
  ///
  /// In ru, this message translates to:
  /// **'Ты получил карточку!'**
  String get tempGotCard;

  /// No description provided for @tempGotGoldCard.
  ///
  /// In ru, this message translates to:
  /// **'Ты получил ЗОЛОТУЮ карточку!'**
  String get tempGotGoldCard;

  /// No description provided for @next.
  ///
  /// In ru, this message translates to:
  /// **'Дальше'**
  String get next;

  /// No description provided for @unknownError.
  ///
  /// In ru, this message translates to:
  /// **'Произошла неизвестная ошибка {error}'**
  String unknownError(String error);

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In ru, this message translates to:
  /// **'Восстановление пароля'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In ru, this message translates to:
  /// **'Введите ваш email, и мы отправим вам инструкции по восстановлению пароля'**
  String get forgotPasswordDescription;

  /// No description provided for @forgotPasswordEmailNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Пользователь с таким email не найден'**
  String get forgotPasswordEmailNotFound;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In ru, this message translates to:
  /// **'Сброс пароля'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordDescription.
  ///
  /// In ru, this message translates to:
  /// **'Введите токен из письма и новый пароль'**
  String get resetPasswordDescription;

  /// No description provided for @resetPasswordTokenHint.
  ///
  /// In ru, this message translates to:
  /// **'Токен из письма'**
  String get resetPasswordTokenHint;

  /// No description provided for @resetPasswordInvalidToken.
  ///
  /// In ru, this message translates to:
  /// **'Неверный токен'**
  String get resetPasswordInvalidToken;

  /// No description provided for @fantasyNotificationsDisabled.
  ///
  /// In ru, this message translates to:
  /// **'У вас выключены пуш-уведомления'**
  String get fantasyNotificationsDisabled;

  /// No description provided for @fantasyNotificationsDisabledDescription.
  ///
  /// In ru, this message translates to:
  /// **'Включите уведомления, чтобы получать сообщения о доступности нового предсказания'**
  String get fantasyNotificationsDisabledDescription;

  /// No description provided for @fantasyEnableNotifications.
  ///
  /// In ru, this message translates to:
  /// **'Включить уведомления'**
  String get fantasyEnableNotifications;

  /// No description provided for @fantasyNotificationsEnabled.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления успешно включены'**
  String get fantasyNotificationsEnabled;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
