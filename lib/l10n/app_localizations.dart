import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
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
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
