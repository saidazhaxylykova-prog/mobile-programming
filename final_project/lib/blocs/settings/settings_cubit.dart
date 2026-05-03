import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/storage/preferences_service.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final PreferencesService _prefs;

  SettingsCubit(this._prefs)
      : super(SettingsState(
          themeMode: _prefs.getThemeMode(),
          locale: _prefs.getLocale(),
        ));

  Future<void> setTheme(ThemeMode mode) async {
    await _prefs.setThemeMode(mode);
    emit(state.copyWith(themeMode: mode));
  }

  Future<void> setLocale(Locale locale) async {
    await _prefs.setLocale(locale);
    emit(state.copyWith(locale: locale));
  }
}
