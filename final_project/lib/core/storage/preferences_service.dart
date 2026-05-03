import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _kThemeMode = 'theme_mode';
  static const _kLocale = 'locale_code';
  static const _kCachedUsername = 'cached_username';

  final SharedPreferences _prefs;

  PreferencesService._(this._prefs);

  static Future<PreferencesService> create() async {
    final p = await SharedPreferences.getInstance();
    return PreferencesService._(p);
  }

  ThemeMode getThemeMode() {
    final raw = _prefs.getString(_kThemeMode);
    switch (raw) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final value = mode == ThemeMode.light
        ? 'light'
        : mode == ThemeMode.dark
            ? 'dark'
            : 'system';
    await _prefs.setString(_kThemeMode, value);
  }

  Locale getLocale() {
    final code = _prefs.getString(_kLocale) ?? 'en';
    return Locale(code);
  }

  Future<void> setLocale(Locale locale) async {
    await _prefs.setString(_kLocale, locale.languageCode);
  }

  String? getCachedUsername() => _prefs.getString(_kCachedUsername);

  Future<void> setCachedUsername(String username) async {
    await _prefs.setString(_kCachedUsername, username);
  }

  Future<void> clearUsername() async {
    await _prefs.remove(_kCachedUsername);
  }
}
