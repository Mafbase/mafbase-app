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

  /// No description provided for @clubEditOwners.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать администраторов'**
  String get clubEditOwners;

  /// No description provided for @ownersTitle.
  ///
  /// In ru, this message translates to:
  /// **'Администраторы'**
  String get ownersTitle;

  /// No description provided for @ownersEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Пока не добавлен ни один администратор'**
  String get ownersEmpty;

  /// No description provided for @ownersAddTitle.
  ///
  /// In ru, this message translates to:
  /// **'Добавление администратора'**
  String get ownersAddTitle;

  /// No description provided for @ownersEmail.
  ///
  /// In ru, this message translates to:
  /// **'Почта'**
  String get ownersEmail;

  /// No description provided for @ownersEmailInvalid.
  ///
  /// In ru, this message translates to:
  /// **'Введите корректный адрес электронной почты'**
  String get ownersEmailInvalid;

  /// No description provided for @ownersRemoveOwner.
  ///
  /// In ru, this message translates to:
  /// **'Удалить администратора {email}?'**
  String ownersRemoveOwner(String email);

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

  /// No description provided for @profileAuthorizedAs.
  ///
  /// In ru, this message translates to:
  /// **'Вы авторизованы как: {email}'**
  String profileAuthorizedAs(String email);

  /// No description provided for @profileLinkedPlayer.
  ///
  /// In ru, this message translates to:
  /// **'Связанный профиль игрока:'**
  String get profileLinkedPlayer;

  /// No description provided for @profilePlayerNotSelected.
  ///
  /// In ru, this message translates to:
  /// **'Профиль игрока не выбран'**
  String get profilePlayerNotSelected;

  /// No description provided for @profileChangePlayer.
  ///
  /// In ru, this message translates to:
  /// **'Изменить профиль игрока'**
  String get profileChangePlayer;

  /// No description provided for @profileSelectPlayer.
  ///
  /// In ru, this message translates to:
  /// **'Выбрать профиль игрока'**
  String get profileSelectPlayer;

  /// No description provided for @profileFsmNickname.
  ///
  /// In ru, this message translates to:
  /// **'ФСМ: {nickname}'**
  String profileFsmNickname(String nickname);

  /// No description provided for @profileDeleteAccount.
  ///
  /// In ru, this message translates to:
  /// **'Удалить аккаунт'**
  String get profileDeleteAccount;

  /// No description provided for @profilePaymentTitle.
  ///
  /// In ru, this message translates to:
  /// **'Оплата'**
  String get profilePaymentTitle;

  /// No description provided for @profileTournamentSubscriptionTitle.
  ///
  /// In ru, this message translates to:
  /// **'Подписка на турниры'**
  String get profileTournamentSubscriptionTitle;

  /// No description provided for @profileTournamentSubscriptionStatus.
  ///
  /// In ru, this message translates to:
  /// **'Статус: {status}'**
  String profileTournamentSubscriptionStatus(String status);

  /// No description provided for @profileTournamentSubscriptionStatusActive.
  ///
  /// In ru, this message translates to:
  /// **'Активна'**
  String get profileTournamentSubscriptionStatusActive;

  /// No description provided for @profileTournamentSubscriptionStatusInactive.
  ///
  /// In ru, this message translates to:
  /// **'Неактивна'**
  String get profileTournamentSubscriptionStatusInactive;

  /// No description provided for @profileTournamentSubscriptionPlan.
  ///
  /// In ru, this message translates to:
  /// **'Тариф: {plan}'**
  String profileTournamentSubscriptionPlan(String plan);

  /// No description provided for @profileTournamentSubscriptionPlanUnavailable.
  ///
  /// In ru, this message translates to:
  /// **'Подписка не оформлена'**
  String get profileTournamentSubscriptionPlanUnavailable;

  /// No description provided for @profileTournamentSubscriptionTypeUnknown.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестный тариф'**
  String get profileTournamentSubscriptionTypeUnknown;

  /// No description provided for @profileTournamentSubscriptionTypeTournamentWithAllAddons10Players.
  ///
  /// In ru, this message translates to:
  /// **'Турниры + все дополнения (10 игроков)'**
  String get profileTournamentSubscriptionTypeTournamentWithAllAddons10Players;

  /// No description provided for @profileTournamentSubscriptionCreate.
  ///
  /// In ru, this message translates to:
  /// **'Оформить подписку'**
  String get profileTournamentSubscriptionCreate;

  /// No description provided for @profileTournamentSubscriptionRenew.
  ///
  /// In ru, this message translates to:
  /// **'Продлить подписку'**
  String get profileTournamentSubscriptionRenew;

  /// No description provided for @profileTournamentSubscriptionLoading.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка...'**
  String get profileTournamentSubscriptionLoading;

  /// No description provided for @profileTournamentSubscriptionOption.
  ///
  /// In ru, this message translates to:
  /// **'{days} дней'**
  String profileTournamentSubscriptionOption(int days);

  /// No description provided for @profileTournamentSubscriptionReload.
  ///
  /// In ru, this message translates to:
  /// **'Обновить'**
  String get profileTournamentSubscriptionReload;

  /// No description provided for @profileTournamentSubscriptionErrorGeneric.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить данные о подписке'**
  String get profileTournamentSubscriptionErrorGeneric;

  /// No description provided for @profileTournamentSubscriptionInfoTitle.
  ///
  /// In ru, this message translates to:
  /// **'О подписке'**
  String get profileTournamentSubscriptionInfoTitle;

  /// No description provided for @profileTournamentSubscriptionInfoDescription.
  ///
  /// In ru, this message translates to:
  /// **'При создании турниров в период подписки, будет выставляться статус оплаченного турнира на 10 человек'**
  String get profileTournamentSubscriptionInfoDescription;

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
  /// **'{count, plural, =0{0 очков} =1{{count} очко} few{{count} очка} many{{count} очков} other{{count} очков}}'**
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

  /// No description provided for @ok.
  ///
  /// In ru, this message translates to:
  /// **'Ок'**
  String get ok;

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

  /// No description provided for @customColumns.
  ///
  /// In ru, this message translates to:
  /// **'Формулы'**
  String get customColumns;

  /// No description provided for @customColumnsEditor.
  ///
  /// In ru, this message translates to:
  /// **'Редактор столбцов'**
  String get customColumnsEditor;

  /// No description provided for @customColumnsAdd.
  ///
  /// In ru, this message translates to:
  /// **'Добавить столбец'**
  String get customColumnsAdd;

  /// No description provided for @customColumnsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Название'**
  String get customColumnsTitle;

  /// No description provided for @customColumnsFormula.
  ///
  /// In ru, this message translates to:
  /// **'Формула'**
  String get customColumnsFormula;

  /// No description provided for @customColumnsFormulaHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите формулу (напр. score / totalGames)'**
  String get customColumnsFormulaHint;

  /// No description provided for @customColumnsValidate.
  ///
  /// In ru, this message translates to:
  /// **'Проверить'**
  String get customColumnsValidate;

  /// No description provided for @customColumnsFormulaValid.
  ///
  /// In ru, this message translates to:
  /// **'Формула корректна'**
  String get customColumnsFormulaValid;

  /// No description provided for @customColumnsFormulaInvalid.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка: {error}'**
  String customColumnsFormulaInvalid(String error);

  /// No description provided for @customColumnsAvailableVariables.
  ///
  /// In ru, this message translates to:
  /// **'Доступные переменные'**
  String get customColumnsAvailableVariables;

  /// No description provided for @customColumnsDelete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить столбец'**
  String get customColumnsDelete;

  /// No description provided for @customColumnsDeleteConfirm.
  ///
  /// In ru, this message translates to:
  /// **'Удалить столбец \"{title}\"?'**
  String customColumnsDeleteConfirm(String title);

  /// No description provided for @customColumnsEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Нет пользовательских столбцов'**
  String get customColumnsEmpty;

  /// No description provided for @customColumnsEditButton.
  ///
  /// In ru, this message translates to:
  /// **'Настроить столбцы'**
  String get customColumnsEditButton;

  /// No description provided for @customColumnsNoValue.
  ///
  /// In ru, this message translates to:
  /// **'—'**
  String get customColumnsNoValue;

  /// No description provided for @customColumnsSave.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get customColumnsSave;

  /// No description provided for @customColumnsEdit.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать'**
  String get customColumnsEdit;

  /// No description provided for @customColumnsOperations.
  ///
  /// In ru, this message translates to:
  /// **'Операции: +, -, *, /, ^ (степень), % (остаток), скобки'**
  String get customColumnsOperations;

  /// No description provided for @customColumnsFunctions.
  ///
  /// In ru, this message translates to:
  /// **'Функции: sqrt, abs, log, log2, log10, ceil, floor, sin, cos, tan'**
  String get customColumnsFunctions;

  /// No description provided for @tooltipScore.
  ///
  /// In ru, this message translates to:
  /// **'Общий балл'**
  String get tooltipScore;

  /// No description provided for @tooltipAddScore.
  ///
  /// In ru, this message translates to:
  /// **'Общий доп. балл'**
  String get tooltipAddScore;

  /// No description provided for @tooltipMinusScore.
  ///
  /// In ru, this message translates to:
  /// **'Общий штраф'**
  String get tooltipMinusScore;

  /// No description provided for @tooltipWins.
  ///
  /// In ru, this message translates to:
  /// **'Общее кол-во побед'**
  String get tooltipWins;

  /// No description provided for @tooltipFirstDie.
  ///
  /// In ru, this message translates to:
  /// **'Кол-во первых убитых'**
  String get tooltipFirstDie;

  /// No description provided for @tooltipCi.
  ///
  /// In ru, this message translates to:
  /// **'Компенсация'**
  String get tooltipCi;

  /// No description provided for @tooltipTotalGames.
  ///
  /// In ru, this message translates to:
  /// **'Всего игр'**
  String get tooltipTotalGames;

  /// No description provided for @tooltipCitizenGames.
  ///
  /// In ru, this message translates to:
  /// **'Игр за мирного'**
  String get tooltipCitizenGames;

  /// No description provided for @tooltipMafiaGames.
  ///
  /// In ru, this message translates to:
  /// **'Игр за мафию'**
  String get tooltipMafiaGames;

  /// No description provided for @tooltipDonGames.
  ///
  /// In ru, this message translates to:
  /// **'Игр за дона'**
  String get tooltipDonGames;

  /// No description provided for @tooltipSheriffGames.
  ///
  /// In ru, this message translates to:
  /// **'Игр за шерифа'**
  String get tooltipSheriffGames;

  /// No description provided for @tooltipCitizenWins.
  ///
  /// In ru, this message translates to:
  /// **'Побед за мирного'**
  String get tooltipCitizenWins;

  /// No description provided for @tooltipMafiaWins.
  ///
  /// In ru, this message translates to:
  /// **'Побед за мафию'**
  String get tooltipMafiaWins;

  /// No description provided for @tooltipDonWins.
  ///
  /// In ru, this message translates to:
  /// **'Побед за дона'**
  String get tooltipDonWins;

  /// No description provided for @tooltipSheriffWins.
  ///
  /// In ru, this message translates to:
  /// **'Побед за шерифа'**
  String get tooltipSheriffWins;

  /// No description provided for @tooltipCitizenAddScore.
  ///
  /// In ru, this message translates to:
  /// **'Доп. балл за мирного'**
  String get tooltipCitizenAddScore;

  /// No description provided for @tooltipMafiaAddScore.
  ///
  /// In ru, this message translates to:
  /// **'Доп. балл за мафию'**
  String get tooltipMafiaAddScore;

  /// No description provided for @tooltipDonAddScore.
  ///
  /// In ru, this message translates to:
  /// **'Доп. балл за дона'**
  String get tooltipDonAddScore;

  /// No description provided for @tooltipSheriffAddScore.
  ///
  /// In ru, this message translates to:
  /// **'Доп. балл за шерифа'**
  String get tooltipSheriffAddScore;

  /// No description provided for @tooltipCitizenScore.
  ///
  /// In ru, this message translates to:
  /// **'Балл за мирного'**
  String get tooltipCitizenScore;

  /// No description provided for @tooltipMafiaScore.
  ///
  /// In ru, this message translates to:
  /// **'Балл за мафию'**
  String get tooltipMafiaScore;

  /// No description provided for @tooltipDonScore.
  ///
  /// In ru, this message translates to:
  /// **'Балл за дона'**
  String get tooltipDonScore;

  /// No description provided for @tooltipSheriffScore.
  ///
  /// In ru, this message translates to:
  /// **'Балл за шерифа'**
  String get tooltipSheriffScore;

  /// No description provided for @tooltipCitizenMinusScore.
  ///
  /// In ru, this message translates to:
  /// **'Штраф за мирного'**
  String get tooltipCitizenMinusScore;

  /// No description provided for @tooltipMafiaMinusScore.
  ///
  /// In ru, this message translates to:
  /// **'Штраф за мафию'**
  String get tooltipMafiaMinusScore;

  /// No description provided for @tooltipDonMinusScore.
  ///
  /// In ru, this message translates to:
  /// **'Штраф за дона'**
  String get tooltipDonMinusScore;

  /// No description provided for @tooltipSheriffMinusScore.
  ///
  /// In ru, this message translates to:
  /// **'Штраф за шерифа'**
  String get tooltipSheriffMinusScore;

  /// No description provided for @tooltipBestMoveCitizen.
  ///
  /// In ru, this message translates to:
  /// **'Доп. балл за лучший ход мирного'**
  String get tooltipBestMoveCitizen;

  /// No description provided for @tooltipBestMoveSheriff.
  ///
  /// In ru, this message translates to:
  /// **'Доп. балл за лучший ход шерифа'**
  String get tooltipBestMoveSheriff;

  /// No description provided for @tooltipRefereeCount.
  ///
  /// In ru, this message translates to:
  /// **'Кол-во судейств'**
  String get tooltipRefereeCount;

  /// No description provided for @tooltipFnMin.
  ///
  /// In ru, this message translates to:
  /// **'Минимум из двух значений'**
  String get tooltipFnMin;

  /// No description provided for @tooltipFnMax.
  ///
  /// In ru, this message translates to:
  /// **'Максимум из двух значений'**
  String get tooltipFnMax;

  /// No description provided for @tooltipFnAbs.
  ///
  /// In ru, this message translates to:
  /// **'Модуль числа'**
  String get tooltipFnAbs;

  /// No description provided for @tooltipFnRound.
  ///
  /// In ru, this message translates to:
  /// **'Округление'**
  String get tooltipFnRound;

  /// No description provided for @tooltipFnFloor.
  ///
  /// In ru, this message translates to:
  /// **'Округление вниз'**
  String get tooltipFnFloor;

  /// No description provided for @tooltipFnCeil.
  ///
  /// In ru, this message translates to:
  /// **'Округление вверх'**
  String get tooltipFnCeil;

  /// No description provided for @playerStatsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Статистика игрока'**
  String get playerStatsTitle;

  /// No description provided for @playerStatsOverall.
  ///
  /// In ru, this message translates to:
  /// **'Общая статистика'**
  String get playerStatsOverall;

  /// No description provided for @playerStatsCitizen.
  ///
  /// In ru, this message translates to:
  /// **'Мирный житель'**
  String get playerStatsCitizen;

  /// No description provided for @playerStatsMafia.
  ///
  /// In ru, this message translates to:
  /// **'Мафия'**
  String get playerStatsMafia;

  /// No description provided for @playerStatsDon.
  ///
  /// In ru, this message translates to:
  /// **'Дон'**
  String get playerStatsDon;

  /// No description provided for @playerStatsSheriff.
  ///
  /// In ru, this message translates to:
  /// **'Шериф'**
  String get playerStatsSheriff;

  /// No description provided for @playerStatsGames.
  ///
  /// In ru, this message translates to:
  /// **'Игры'**
  String get playerStatsGames;

  /// No description provided for @playerStatsWins.
  ///
  /// In ru, this message translates to:
  /// **'Победы'**
  String get playerStatsWins;

  /// No description provided for @playerStatsWinRate.
  ///
  /// In ru, this message translates to:
  /// **'Винрейт'**
  String get playerStatsWinRate;

  /// No description provided for @playerStatsAvgBonus.
  ///
  /// In ru, this message translates to:
  /// **'Ср. доп. балл'**
  String get playerStatsAvgBonus;

  /// No description provided for @playerStatsSameCityTop.
  ///
  /// In ru, this message translates to:
  /// **'ТОП-5 партнёров (город)'**
  String get playerStatsSameCityTop;

  /// No description provided for @playerStatsSameMafiaTop.
  ///
  /// In ru, this message translates to:
  /// **'ТОП-5 партнёров (мафия)'**
  String get playerStatsSameMafiaTop;

  /// No description provided for @playerStatsDiffTeamTop.
  ///
  /// In ru, this message translates to:
  /// **'ТОП-5 противников'**
  String get playerStatsDiffTeamTop;

  /// No description provided for @playerStatsError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить статистику'**
  String get playerStatsError;

  /// No description provided for @playerStatsNoData.
  ///
  /// In ru, this message translates to:
  /// **'Нет данных о парах'**
  String get playerStatsNoData;
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
