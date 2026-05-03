// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'SaidaGram';

  @override
  String get tabFeed => 'Лента';

  @override
  String get tabCreate => 'Создать';

  @override
  String get tabExplore => 'Обзор';

  @override
  String get tabProfile => 'Профиль';

  @override
  String get loginTitle => 'С возвращением';

  @override
  String get loginSubtitle => 'Войдите, чтобы продолжать делиться';

  @override
  String get signupTitle => 'Регистрация';

  @override
  String get signupSubtitle => 'Присоединяйтесь к SaidaGram';

  @override
  String get emailHint => 'Эл. почта';

  @override
  String get passwordHint => 'Пароль';

  @override
  String get loginButton => 'Войти';

  @override
  String get signupButton => 'Зарегистрироваться';

  @override
  String get noAccount => 'Нет аккаунта?';

  @override
  String get haveAccount => 'Уже есть аккаунт?';

  @override
  String get logOut => 'Выйти';

  @override
  String get feedEmpty => 'Постов пока нет. Будь первым!';

  @override
  String get createPlaceholder => 'О чём думаете?';

  @override
  String get post => 'Опубликовать';

  @override
  String get postCreated => 'Пост опубликован!';

  @override
  String get exploreTitle => '1001 способ сказать нет';

  @override
  String get exploreEmpty => 'Потяните вниз, чтобы обновить.';

  @override
  String get profileEmail => 'Эл. почта';

  @override
  String get profileUsername => 'Имя пользователя';

  @override
  String get save => 'Сохранить';

  @override
  String get myPosts => 'Мои посты';

  @override
  String get language => 'Язык';

  @override
  String get theme => 'Тема';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get langEnglish => 'Английский';

  @override
  String get langRussian => 'Русский';

  @override
  String get langKazakh => 'Казахский';

  @override
  String get errorGeneric => 'Что-то пошло не так';

  @override
  String get loading => 'Загрузка...';

  @override
  String get retry => 'Повторить';

  @override
  String get usernameUpdated => 'Имя обновлено';
}
